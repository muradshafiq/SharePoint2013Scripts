Add-PSSnapin Microsoft.Sharepoint.Powershell

#$siteurl = Get-SPWebApplication http://team/ | Get-SPSite -Limit ALL

function Get-Workflows($siteurl)
{

    $site=Get-SPSite -Limit ALL
    $WorkflowDeatils=@()

    foreach($web in $site.AllWebs)
        {
        foreach($list in $web.Lists)
            {
            foreach($wf in $list.WorkflowAssociations)
                {
                if ($true) # former: ($wf.Name -notlike "*Previous Version*")
                    {
                        foreach ($item in $list.Items)
                        {
                            foreach ($workflow in $item.Workflows)
                            {
                            Write-Host ("INFO -- List: {0}, item {1}, workflow status: {2}, workflow started: {3}" -f $spWeb.Lists[$i].Title, $item.Title, $workflow.InternalState, $workflow.Created.ToLocalTime())  -BackgroundColor Black -ForegroundColor Yellow
                            }
                        }

                        $row=new-object PSObject
                        add-Member -inputObject $row -memberType NoteProperty -name "Site URL" -Value $web.Url
                        add-Member -inputObject $row -memberType NoteProperty -name "List Title" -Value $list.Title
                        add-Member -inputObject $row -memberType NoteProperty -name "Workflow name" -Value $wf.Name
                        $WorkflowDeatils+=$row
                    }
                }
            }
        }
    #$WorkflowDeatils
}

Get-Workflows #| Export-csv C:\workflows.csv
#$site.Dispose()
