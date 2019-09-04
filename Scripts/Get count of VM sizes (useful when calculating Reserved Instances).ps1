
Connect-AzAccount
$subscriptions = Get-AzSubscription
$ArrList = [System.Collections.ArrayList]@()

foreach ($subscription in $subscriptions)
{
    Write-Host 'Subscription: ' -NoNewline
    Write-Host $subscription.Name -ForegroundColor Yellow -NoNewline
    Select-AzSubscription -SubscriptionObject $subscription | Out-Null
    $vms = Get-AzVM | Select-Object -ExpandProperty HardwareProfile
    Write-Host " ($($($vms | Measure-Object).Count) VMs)"

    foreach ($vm in $vms)
    {
        $ArrList.Add($vm) | Out-Null
    }
}

Write-Host "Total VMs:" $ArrList.Count
$ArrList | Group-Object -Property "VmSize" -NoElement | Sort-Object "count" -Descending