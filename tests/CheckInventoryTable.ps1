[CmdletBinding()]
param (
    [Parameter(Mandatory=$true,
                HelpMessage="SQL Server name in Azure.")]
    [string]
    $sqlServerName,

    [Parameter(Mandatory=$true,
            HelpMessage="SQL Database name in Azure.")]
    [string]
    $sqlDatabaseName,

    [Parameter(Mandatory=$true,
            HelpMessage="SQL administrator for connection to SQL server in Azure.")]
    [string]
    $sqlAdministrator,

    [Parameter(Mandatory=$true,
            HelpMessage="SQL password for connection to SQL server in Azure.")]
    [string]
    $sqlPassword
)


Describe "Check inventory table" {
    It "Gets inventory table records" {
        $credPwd = ConvertTo-SecureString $sqlPassword -AsPlainText -Force
        $credential = New-Object System.Management.Automation.PSCredential ($sqlAdministrator, $credPwd)
        $query = "SELECT [ServerName], [Description] FROM dbo.DatabaseInventory"
        $result = Invoke-DbaQuery -SqlInstance $sqlServerName -Database $sqlDatabaseName -SqlCredential $credential -Query $query
        $result.Count | Should -BeGreaterOrEqual 1
    }
}
