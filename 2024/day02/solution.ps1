[CmdletBinding()]
param(
    [Parameter()][string]$Path
)

Function Confirm-ReportStatus(){
    param(
        [Parameter()][int[]]$Levels,
        [Parameter()][bool]$Dampener = $False
    )

    $Status = $True

    $Asc = $Levels[0] -lt $Levels[1]

    For($i = 1; $i -lt $Levels.Count; $i++) {
        $Curr = $Levels[$i]
        $Prev = $Levels[$i - 1]

        if($Asc -and $Curr -lt $Prev) {
            # current is smaller than previous, we should be ascending - bad report
            $Status = $False;
        }

        if((-not $Asc) -and $Curr -gt $Prev) {
            # current is bigger than previous, we should be decending - bad report
            $Status = $False;
        }

        $Diff = [Math]::Abs($Curr - $Prev)

        if($Diff -lt 1 -or $Diff -gt 3) {
            $Status = $False;
        }
    }

    if(-not $Status -and $Dampener) {
        # dampener enabled, lets try removing some levels...
        For($i = 0; $i -lt $Levels.Count; $i++) {
            [int[]]$NewLevels = [int[]]($Levels | Select-Object -First $i) + ($Levels | Select-Object -skip ($i + 1))
            $Status += Confirm-ReportStatus -Levels $NewLevels -Dampener $False
        }
    }

    return $Status
}

$Reports = Get-Content $Path | ForEach-Object { ,($_ -split '\s+') }

# Safe Reports (pt1)
$SafeReports = 0
$Reports | ForEach-Object {
    $Levels = $_

    if(Confirm-ReportStatus -Levels $Levels) {
        $SafeReports ++;
    }
}

Write-Output "Safe Reports (pt1): $SafeReports"


# Safe Reports - Dampener (pt2)
$SafeReports = 0
$Reports | ForEach-Object {
    $Levels = $_

    if(Confirm-ReportStatus -Levels $Levels -Dampener $True) {
        $SafeReports ++;
    }
}

Write-Output "Safe Reports - Dampener (pt2): $SafeReports"
