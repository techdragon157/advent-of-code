[CmdletBinding()]
param(
    [Parameter()][string]$Path
)

$Data = Get-Content $Path

# Mull It Over(pt1)
$Regex = [regex]"mul\(([0-9]{1,3}),([0-9]{1,3})\)"

$Acc = 0
$Regex.Matches($Data).ForEach(
    {
        $A = [int]$_.Groups[1].Value
        $B = [int]$_.Groups[2].Value

        $Prod = $A * $B

        $Acc += $Prod
    }
)

Write-Output "Mull It Over (pt1): $Acc"


# Mull It Over(pt2)
$Regex = [regex]"do\(\)|don\'t\(\)|mul\(([0-9]{1,3}),([0-9]{1,3})\)"

$Process = $True
$Acc = 0

$Matches = $Regex.Matches($Data)
foreach($Match in $Matches) {
    if("$($Match.Value)" -eq "do()")
    {
        $Process = $True
        continue
    } 
    elseif("$($Match.Value)" -eq "don't()")
    {
        $Process = $False
        continue
    }

    if($Process)
    {
        $A = [int]$Match.Groups[1].Value
        $B = [int]$Match.Groups[2].Value

        $Prod = $A * $B

        $Acc += $Prod
    }
}

Write-Output "Mull It Over (pt2): $Acc"
