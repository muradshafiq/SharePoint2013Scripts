Add-PSSnapin Microsoft.Sharepoint.Powershell

#$siteurl = Get-SPWebApplication http://team/ | Get-SPSite -Limit ALL

function Get-Workflows($siteurl)
{

    $site=Get-SPSite -Limit ALL
    $WorkflowDeatils=@()

    foreach($web in $site.AllWebs)
        {
        $web.name
        foreach($list in $web.Lists)
            {
            $list.name
            foreach($wf in $list.WorkflowAssociations)
                {
                $wf.title
                if ($true) # former: ($wf.Name -notlike "*Previous Version*")
                    {
                        foreach ($item in $list.Items)
                        {
                            foreach ($workflow in $item.Workflows)
                            {
                            if($workflow.InternalState -notlike "Completeddd") {
                                #Write-Host $item.Web, $item.FirstUniqueAncestor; $item.Title; $workflow.InternalState;" #$workflow.Created.ToLocalTime() 
                            Write-Host ("itemweb: {0}, itemtitle {1}, firstuniqueancestor: {2}, internalstate: {3}" -f $item.Web, $item.Title, $item.FirstUniqueAncestorSecurableObject, $workflow.InternalState) -ForegroundColor Yellow
                                }
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



$item.File
write-host $item.FirstUniqueAncestor
