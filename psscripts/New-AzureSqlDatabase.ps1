Function New-AzureSqlDatabase  {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true,
                HelpMessage="Resource group name in Azure.")]
        [string]
        $resourceGroupName,

        [Parameter(Mandatory=$true,
                HelpMessage="SQL Server name in Azure.")]
        [string]
        $sqlServerName,

        [Parameter(Mandatory=$true,
                HelpMessage="SQL Database name in Azure.")]
        [string]
        $sqlDatabaseName,

        [Parameter(Mandatory=$true,
                HelpMessage="The public IP address to whitelist.")]
        [string]
        $publicIp,

        [Parameter(Mandatory=$true,
                HelpMessage="SQL administrator for connection to SQL server in Azure.")]
        [string]
        $sqlAdministrator,

        [Parameter(Mandatory=$true,
                HelpMessage="SQL password for connection to SQL server in Azure.")]
        [string]
        $sqlPassword,

        [Parameter(HelpMessage="Region location in Azure to deploy resource")]
        [string]
        $location = 'westeurope'
    )
    begin {
        # Variables shouldbe lowercase
        $sqlServerName = $sqlServerName.ToLower()
        $sqlDatabaseName = $sqlDatabaseName.ToLower()
    }
    process {
        try {
            $rg = Get-AzResourceGroup -Name $resourceGroupName -ErrorAction SilentlyContinue
            if (-not $rg) {
                New-AzResourceGroup -Name $resourceGroupName -Location $location
            }
                                            
            $azSqlServer = Get-AzSqlServer -ServerName $sqlServerName
            if (-not $azSqlServer) {
                $azSqlServer = New-AzSqlServer -ResourceGroupName $resourceGroupName `
                -ServerName $sqlServerName `
                -Location $location `
                -SqlAdministratorCredentials $(New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $sqlAdministrator, $(ConvertTo-SecureString -String $sqlPassword -AsPlainText -Force)) `
                -ErrorAction Stop
            }
            
            $azSqlFirwallRule = Get-AzSqlServerFirewallRule -FirewallRuleName 'FirewallRule_AccessRule' -ServerName $sqlServerName -ResourceGroupName $resourceGroupName -ErrorAction SilentlyContinue
            if (-not $azSqlFirwallRule) {
                # Create a server firewall rule that allows access from the specified IP range
                $serverFirewallRule = New-AzSqlServerFirewallRule -ResourceGroupName $resourceGroupName `
                -ServerName $sqlServerName `
                -FirewallRuleName "FirewallRule_AccessRule" -StartIpAddress $publicIp -EndIpAddress $publicIp `
                -ErrorAction Stop
            }
                            
            $azSqlDatabase = Get-AzSqlDatabase -DatabaseName $sqlDatabaseName -ServerName $sqlServerName -ResourceGroupName $resourceGroupName -ErrorAction  SilentlyContinue
            if (-not $azSqlDatabase) {
                $database = New-AzSqlDatabase  -ResourceGroupName $resourceGroupName `
                -ServerName $sqlServerName `
                -DatabaseName $sqlDatabaseName `
                -Edition "Basic" `
                -ErrorAction Stop 
            }
        }
        catch {
            Write-Error "Oops was unable to create new Azure SQL database: $_"
        }
    }
}
