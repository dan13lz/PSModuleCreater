Set-Alias -Name NewCMDlet -Value New-PSModule
Set-Alias -Name VsCode -Value New-VsCode

function New-PSModule ($param){
    Write-Host "New powershell module creating..."
    $mod_name = Read-Host 'Module name("MyModule")'
    $func_name = Read-Host 'Function name("New-MyPSFunction")'
    $ali_name = Read-Host 'Alias name("MyFunc")'
  #  $func_body = Read-Host 'Function content("Get-AdComputer hostname")'
    Set-ModuleCreating -param1 $mod_name -param2 $func_name -param3 $ali_name -param4 $func_body
}

function Set-ModuleCreating ($param1,$param2,$param3,$param4){
    $hostname = hostname
    $link = "\\$hostname\c$\Program Files\WindowsPowerShell\Modules\$param1\"   #HARDLINK??
    $pattern = '
    Set-Alias -Name '+$param3+' -Value '+$param2+' 
    function '+$param2+'($parametr1,$parametr2){'+'
      '+$param4+'     
    }' #end pattern
    New-Item -path $link$param1'.psm1' -Force 
    Set-Content $link$param1'.psm1' $pattern 
    Write-Host "Module "$param1" created:"$link$param1'.psm1'
    VsCode -path $link -module $param1
}

Function New-VsCode ($path,$module) { 
    <#runas.exe /netonly /user:info.local\zalivakhin.adm powershell#> (code -r $path$module'.psm1')
    }


