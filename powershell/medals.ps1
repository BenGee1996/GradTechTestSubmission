function Build-MedalTable {
    param
    (
        [Parameter(Mandatory)]
        [array]
        $Medals
    )

    # First place gives 3 points, second place 2 points and third place 1 point

    $Scoring = [PSCustomObject]@{
        1 = 3
        2 = 2
        3 = 1
    }

    $MedalTable = @{}

    foreach ($Result in $Medals.podium) {

        $Position = $Result.split(".")[0]
        $Country = $Result.Split(".")[1]

        if ($MedalTable.Keys -contains $Country) {
            $MedalTable.$Country += $Scoring.$Position
        } else {
            $MedalTable.$Country = $Scoring.$Position
        }    
    }

   return $MedalTable.GetEnumerator() | sort Value -descending
}   

    $MedalResults = @(
        @{
            'sport' = 'cycling'
            'podium' = @('1.China', '2.Germany', '3.ROC')
        }
        @{
            'sport' = 'fencing'
            'podium' = @('1.ROC', '2.France', '3.Italy')
        }
        @{
            'sport' = 'high jump'
            'podium' = @('1.Italy', '1.Qatar', '3.Belarus')
        }
        @{
            'sport' = 'swimming'
            'podium' = @('1.USA', '2.France', '3.Brazil')
        }
    )

Build-MedalTable -Medals $MedalResults
