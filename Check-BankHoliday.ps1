Function Check-BankHoliday {
    Param (
        [CmdletBinding()]
        [Parameter(Mandatory,ValueFromPipeline)][datetime]$Date
    )
    Process {
        $bankHolidays = (Invoke-RestMethod -Uri "https://www.gov.uk/bank-holidays.json" -Method GET)
        $bankHolidays.'england-and-wales'.events.date -contains (Get-Date $Date -Format "yyyy-MM-dd")
    }
}