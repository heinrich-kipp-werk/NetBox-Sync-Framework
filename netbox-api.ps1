function Netbox {
    param (
        [string]$Token,
        [string]$Uri,
        [object]$Body,
        [string]$Query,
        [string]$Create = -1,
        [string]$Delete = -1,
        [string]$PartialUpdate = -1,
        [string]$BulkUpdate = -1,
        [string]$Select = -1,
        [bool]$Debug = $false
    )

    #Check for required variables
    if (!$Token -or !$Uri) {
        Write-Output "You need to specifiy the Netbox Token and the URL."
        Exit-PSHostProcess
    }
    
    #detect http method to use
    $method = -1
    
    if ($Create -ne -1) {
        $method = "Post"
        $task = $Create
    }elseif ($Delete -ne -1) {
        $method = "Delete"
        $task = $Delete
    }elseif ($PartialUpdate -ne -1) {
        $method = "Patch"
        $task = $PartialUpdate
    }elseif ($BulkUpdate -ne -1) {
        $method = "Put"
        $task = $BulkUpdate
    }elseif ($Select -ne -1) {
        $method = "Get"
        $task = $Select
    }

    if ($method -eq -1) {
        Write-Output "You need to specify one of these options: -Create, -Delete, -PartialUpdate, -BulkUpdate. For more informations see the Documentation."
        Exit-PSHostProcess
    }

    #create request url
    if ($Query) {
        $url = "$Uri/api/$task/?$Query"
    }else{
        $url = "$Uri/api/$task/"
    }

    if ($Debug -eq $true) {
        Write-Output "$method URL $url"

        if ($Body) {
            Write-Output "Body: " $Body
        }
    }

    $Body = ConvertTo-Json -Depth 16 $Body

    $res = Invoke-WebRequest -Headers @{'Authorization' = 'Token ' + $Token; 'Accept' = 'application/json'; 'indent' = '4'} -ContentType 'application/json' -Method $method -UseBasicParsing -Uri $url -Body $Body
    if ($res.StatusCode -gt 199 -and $res.StatusCode -lt 300) {
        $res = $($res.Content | ConvertFrom-Json)
        if ($null -ne $res.results) {
            return $res.results
        }else{
            return $res
        }
    }else{
        Write-Output "Error: " $res
    }
}