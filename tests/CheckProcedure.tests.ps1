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


Describe "Check stored procedure" {
    It "Gets stored procedure exist" {
        $credPwd = ConvertTo-SecureString $sqlPassword -AsPlainText -Force
        $credential = New-Object System.Management.Automation.PSCredential ($sqlAdministrator, $credPwd)
        $query = "select count(*) from sys.procedures where name = 'AddInventoryRecords'"
        $result = (Invoke-DbaQuery -SqlInstance $sqlServerName -Database $sqlDatabaseName -SqlCredential $credential -Query $query)[0]
        $result | Should -Be 1
    }
}
