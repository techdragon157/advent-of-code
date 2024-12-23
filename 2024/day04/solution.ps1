[CmdletBinding()]
param(
    [Parameter()][string]$Path
)

$Lines = Get-Content $Path | ForEach-Object { $_ }

$Grid = $Lines | ForEach-Object { ,([string]$_) }

$GRID_ROWS = $Grid.Length
$GRID_COLS = $Grid[0].Length

$WORD = "XMAS"

Function Confirm-Word(){
    param(
        [Parameter()][string]$Search
    )

    if($Search -eq $WORD) {
        return $True
    }

    return $False
}

$Acc = 0
for($row = 0; $row -lt $GRID_ROWS; $row++)
{
    for($col = 0; $col -lt $GRID_COLS; $col++)
    {
        #FORWARDS
        if($col -le $GRID_COLS - $WORD.Length)
        {
            # forwards
            #Write-Output "$($Grid[$row][$col])$($Grid[$row][$col+1])$($Grid[$row][$col+2])$($Grid[$row][$col+3])"
            if(Confirm-Word -Search "$($Grid[$row][$col])$($Grid[$row][$col+1])$($Grid[$row][$col+2])$($Grid[$row][$col+3])") { $Acc++ }
        }


        # BACKWARDS
        if($col -ge $WORD.Length-1)
        {
            # backwards
            #Write-Output "$($Grid[$row][$col])$($Grid[$row][$col-1])$($Grid[$row][$col-2])$($Grid[$row][$col-3])"
            if(Confirm-Word -Search "$($Grid[$row][$col])$($Grid[$row][$col-1])$($Grid[$row][$col-2])$($Grid[$row][$col-3])") { $Acc++ }
        }


        # DOWN
        if($row -le $GRID_ROWS - $WORD.Length)
        {
            # down
            #Write-Output "$($Grid[$row][$col])$($Grid[$row+1][$col])$($Grid[$row+2][$col])$($Grid[$row+3][$col])"
            if(Confirm-Word -Search "$($Grid[$row][$col])$($Grid[$row+1][$col])$($Grid[$row+2][$col])$($Grid[$row+3][$col])") { $Acc++ }
        }


        # UP
        if($row -ge $WORD.Length-1)
        {
            # up
            #Write-Output "$($Grid[$row][$col])$($Grid[$row-1][$col])$($Grid[$row-2][$col])$($Grid[$row-3][$col])"
            if(Confirm-Word -Search "$($Grid[$row][$col])$($Grid[$row-1][$col])$($Grid[$row-2][$col])$($Grid[$row-3][$col])") { $Acc++ }
        }


        # DIAGONAL DOWN
        if($row -le $GRID_ROWS - $WORD.Length -and $col -le $GRID_COLS - $WORD.Length)
        {
            # down-forward (diagonal)
            #Write-Output "$($Grid[$row][$col])$($Grid[$row+1][$col+1])$($Grid[$row+2][$col+2])$($Grid[$row+3][$col+3])"
            if(Confirm-Word -Search "$($Grid[$row][$col])$($Grid[$row+1][$col+1])$($Grid[$row+2][$col+2])$($Grid[$row+3][$col+3])") { $Acc++ }
        }
        if($row -le $GRID_ROWS - $WORD.Length -and $col -ge $WORD.Length-1)
        {
            # down-backwards (diagonal)
            #Write-Output "$($Grid[$row][$col])$($Grid[$row+1][$col-1])$($Grid[$row+2][$col-2])$($Grid[$row+3][$col-3])"
            if(Confirm-Word -Search "$($Grid[$row][$col])$($Grid[$row+1][$col-1])$($Grid[$row+2][$col-2])$($Grid[$row+3][$col-3])") { $Acc++ }
        }


        # DIAGONAL UP
        if($row -ge $WORD.Length-1 -and $col -le $GRID_COLS - $WORD.Length)
        {
            # up-forward (diagonal)
            #Write-Output "$($Grid[$row][$col])$($Grid[$row-1][$col+1])$($Grid[$row-2][$col+2])$($Grid[$row-3][$col+3])"
            if(Confirm-Word -Search "$($Grid[$row][$col])$($Grid[$row-1][$col+1])$($Grid[$row-2][$col+2])$($Grid[$row-3][$col+3])") { $Acc++ }
        }
        if($row -ge $WORD.Length-1 -and $col -ge $WORD.Length-1)
        {
            # up-backwrads (diagonal)
            #Write-Output "$($Grid[$row][$col])$($Grid[$row-1][$col-1])$($Grid[$row-2][$col-2])$($Grid[$row-3][$col-3])"
            if(Confirm-Word -Search "$($Grid[$row][$col])$($Grid[$row-1][$col-1])$($Grid[$row-2][$col-2])$($Grid[$row-3][$col-3])") { $Acc++ }
        }

        #break
    }

    #break;
}

Write-Output "Ceres Search (pt1): $Acc"


$WORD = "MAS"

$Acc = 0
for($row = 0; $row -lt $GRID_ROWS; $row++)
{
    for($col = 0; $col -lt $GRID_COLS; $col++)
    {
        # DIAGONAL DOWN
        if($row -le $GRID_ROWS - $WORD.Length -and $col -le $GRID_COLS - $WORD.Length)
        {
            # down-forward (diagonal)
            #Write-Output "$($Grid[$row][$col])$($Grid[$row+1][$col+1])$($Grid[$row+2][$col+2])$($Grid[$row+3][$col+3])"
            if(Confirm-Word -Search "$($Grid[$row][$col])$($Grid[$row+1][$col+1])$($Grid[$row+2][$col+2])") { $Acc++ }
        }
        if($row -le $GRID_ROWS - $WORD.Length -and $col -ge $WORD.Length-1)
        {
            # down-backwards (diagonal)
            #Write-Output "$($Grid[$row][$col])$($Grid[$row+1][$col-1])$($Grid[$row+2][$col-2])$($Grid[$row+3][$col-3])"
            if(Confirm-Word -Search "$($Grid[$row][$col])$($Grid[$row+1][$col-1])$($Grid[$row+2][$col-2])") { $Acc++ }
        }


        # DIAGONAL UP
        if($row -ge $WORD.Length-1 -and $col -le $GRID_COLS - $WORD.Length)
        {
            # up-forward (diagonal)
            #Write-Output "$($Grid[$row][$col])$($Grid[$row-1][$col+1])$($Grid[$row-2][$col+2])$($Grid[$row-3][$col+3])"
            if(Confirm-Word -Search "$($Grid[$row][$col])$($Grid[$row-1][$col+1])$($Grid[$row-2][$col+2])") { $Acc++ }
        }
        if($row -ge $WORD.Length-1 -and $col -ge $WORD.Length-1)
        {
            # up-backwrads (diagonal)
            #Write-Output "$($Grid[$row][$col])$($Grid[$row-1][$col-1])$($Grid[$row-2][$col-2])$($Grid[$row-3][$col-3])"
            if(Confirm-Word -Search "$($Grid[$row][$col])$($Grid[$row-1][$col-1])$($Grid[$row-2][$col-2])") { $Acc++ }
        }

        #break
    }

    #break;
}

Write-Output "Ceres Search (pt2): $Acc"
