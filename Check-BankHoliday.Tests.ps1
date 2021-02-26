BeforeAll {
    . ./Check-BankHoliday.ps1
}
Describe "Check-BankHoliday" {
    Context "Parameters" {
        It "'Date' is defined" {
            Get-Command Check-BankHoliday | Should -HaveParameter Date
        }
        It "'Date' is mandatory" {
            Get-Command Check-BankHoliday | Should -HaveParameter Date -Mandatory
        }
        It "'Date' is of type 'datetime'" {
            Get-Command Check-BankHoliday | Should -HaveParameter Date -Type datetime
        }
    }
    Context "Valid Bank Holiday dates" {
        It "For <Date> it reports <expected>" -ForEach @(
            @{Date = "01/01/2021"; Expected = $true}
            @{Date = "04/02/2021"; Expected = $true}
            @{Date = "04/05/2021"; Expected = $true}
            @{Date = "05/03/2021"; Expected = $true}
            @{Date = "05/31/2021"; Expected = $true}
            @{Date = "08/30/2021"; Expected = $true}
            @{Date = "12/27/2021"; Expected = $true}
            @{Date = "12/28/2021"; Expected = $true}
        ) {
            Check-BankHoliday -Date $Date | Should -Be $expected
        }
    }

    Context "Invalid Bank Holiday dates" {
        It "For <Date> it reports <expected>" -ForEach @(
            @{Date = "02/01/2021"; Expected = $false}
            @{Date = "02/04/2021"; Expected = $false}
            @{Date = "05/04/2021"; Expected = $false}
            @{Date = "03/05/2021"; Expected = $false}
            @{Date = "05/30/2021"; Expected = $false}
            @{Date = "08/24/2021"; Expected = $false}
            @{Date = "12/20/2021"; Expected = $false}
            @{Date = "12/21/2021"; Expected = $false}
        )  {
            Check-BankHoliday -Date $Date | Should -Be $expected
        }
    }
}