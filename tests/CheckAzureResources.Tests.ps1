Describe 'Azure Resources' {
    BeforeAll {
        $resourceGroup = 'rg-dbaautomation'
        $sqlServer = Get-AzSqlServer -ResourceGroupName $resourceGroup
        $sqlDatabase = Get-AzsqlDatabase -ResourceGroupName $resourceGroup -ServerName $sqlServer.ServerName | Where-Object {$_.DatabaseName -notin "master"}
    }
    It "$($sqlServer.ServerName) should be sqlestate" {
        $sqlServer.ServerName | Should -Be 'sqlestate'
    }
    It "$($sqlServer.SqlAdministratorLogin ) name should be SqlAdministrator" {
        $sqlServer.SqlAdministratorLogin | Should -Be 'SqlAdministrator'
    }
    It "$($sqlDatabase.DatabaseName) contain a database called estate" {
        $sqlDatabase.DatabaseName | Should -Be 'estate'
    }
}
