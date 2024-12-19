[CmdletBinding()]
param(
    [Parameter()][string]$Path
)

$Lines = Get-Content $Path | ForEach-Object { ,($_ -split '\s+') }
$List1 = $Lines | ForEach-Object { [int]$_[0] } | Sort-Object
$List2 = $Lines | ForEach-Object { [int]$_[1] } | Sort-Object

# Diff Calculation - (pt1)
$DiffTotal = 0
For($i = 0; $i -lt $Lines.Count; $i++) {
    $Diff = [Math]::Abs($List1[$i] - $List2[$i])
    $DiffTotal += $Diff
}

Write-Output "Total Diff (pt1): $DiffTotal"


# Similarity Calculation - (pt2)
$SimTotal = 0
For($i = 0; $i -lt $Lines.Count; $i++) {
    $Count = ($List2 | Where-Object { $_ -eq $List1[$i] }).Count
    $Sim = $List1[$i] * $Count
    $SimTotal += $Sim
}

Write-Output "Similarity Score (pt2): $SimTotal"
