$env:POSH_GIT_ENABLED=$false


function prompt {
    oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH/catppuccin.omp.json" | Invoke-Expression
};
prompt;

Import-Module -Name Terminal-Icons


# If so and the current host is a command line, then change to red color 
# as warning to user that they are operating in an elevated context
# Useful shortcuts for traversing directories
function cd... { Set-Location ..\.. }
function cd.... { Set-Location ..\..\.. }


# Quick shortcut to start notepad
function n { notepad $args }

Set-PSReadLineOption -Colors @{
    Command = 'Yellow'
    Parameter = 'Green'
    String = 'DarkCyan'
}


# Does the the rough equivalent of dir /s /b. For example, dirs *.png is dir /s /b *.png
function dirs {
    if ($args.Count -gt 0) {
        Get-ChildItem -Recurse -Include "$args" | Foreach-Object FullName
    } else {
        Get-ChildItem -Recurse | Foreach-Object FullName
    }
}


function l { Get-ChildItem -Path $pwd -File }

function uptime {
    #Windows Powershell only
	If ($PSVersionTable.PSVersion.Major -eq 5 ) {
		Get-WmiObject win32_operatingsystem |
        Select-Object @{EXPRESSION={ $_.ConverttoDateTime($_.lastbootuptime)}} | Format-Table -HideTableHeaders
	} Else {
        net statistics workstation | Select-String "since" | foreach-object {$_.ToString().Replace('Statistics since ', '')}
    }
}

function reload-profile {
    & $profile
}

function find-file($name) {
    Get-ChildItem -recurse -filter "*${name}*" -ErrorAction SilentlyContinue | ForEach-Object {
        $place_path = $_.directory
        Write-Output "${place_path}\${_}"
    }
}


function touch($file) {
    "" | Out-File $file -Encoding ASCII
}


function which($name) {
    Get-Command $name | Select-Object -ExpandProperty Definition
}
function export($name, $value) {
    set-item -force -path "env:$name" -value $value;
}
function pkill($name) {
    Get-Process $name -ErrorAction SilentlyContinue | Stop-Process
}
function pgrep($name) {
    Get-Process $name
}

function TO-Second($h, $m) {
    $totalSeconds = ($h * 3600) + ($m * 60)
    $currentDate = Get-Date

    $newDate = $currentDate.AddSeconds($totalSeconds)

    $currentDate >> ~\shutdown_time.txt
    $newDate >> ~\shutdown_time.txt

    return $totalSeconds
}


$Env:GROQ_API_KEY="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"
function py {python}

 
function ai {
    param (
        [Parameter(ValueFromRemainingArguments = $true)]
        [string[]]$args
    )
    python 'C:\Users\Shafayet\automations\ai_cli.py' --service groq @args
}




