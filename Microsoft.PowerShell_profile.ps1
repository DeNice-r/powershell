$aliasName = "my alias"
$keychainPath = "C:/keychain"

function echoHello {
    return "☦️"
}

function echoAhuy {
    return "🤬"
}

function kissBohdan {
    return "😘☦️дан"
}

function setAlias ([string] $name, [string] $value) {
    Set-Alias -Name $name -Value $value -force -Description "$aliasName" -Scope Global
}

function gitStatus {
    git status
}

function gitCommit([string] $message) {
    git commit -m "$message"
}

function gitAdd([string] $path) {
    git add "$path"
}

function gitAddCurrent {
    gitAdd(".")
}

function gitPush {
    git push
}

function gitPull {
    git pull
}

function gitCheckout([string] $name) {
    git checkout "$name"
}

function gitNewBranch([string] $name) {
    git checkout main
    git pull
    git checkout -b "$name"
}

function slsDeployFunction ([string] $functionName){
    npx sls deploy function -f "$functionName"
}

function slsDeploy {
    npx sls deploy
}

function gitAddCommitPush ([string] $message) {
    gitAddCurrent
    gitCommit("$message")
    gitPush
    echoAhuy
}

function gitReset {
    git reset --hard HEAD
}

function getHelp {
    Get-Alias | Where-Object {$_.Description -Match "$aliasName"}
}

function openConfig {
    Start-Job -ScriptBlock { ws $profile } > $null
}

function openConfigFolder {
    cd (Split-Path $profile)
}

function connectDevDb { # perhaps abstract from a specific connection and make it generic?
    $ip = (aws ec2 describe-instances --instance-ids i-01b9fb5f7079f1d89 --query "Reservations[*].Instances[*].PublicIpAddress" --output text --profile hh).replace(".", '-')
    ssh -i "$keychainPath/HamletHub.pem" -L 27017:hamlethub-dev-cluster.cluster-c5gewfc0vpna.us-east-1.docdb.amazonaws.com:27017 "ec2-user@ec2-$ip.compute-1.amazonaws.com"
}

function connectProdDb {
    $ip = (aws ec2 describe-instances --instance-ids i-08af34a8129a8dbf9 --query "Reservations[*].Instances[*].PublicIpAddress" --output text --profile hh).replace(".", '-')
    ssh -i "$keychainPath/HamletHub.pem" -L 27017:hamlethub-prod-cluster.cluster-c5gewfc0vpna.us-east-1.docdb.amazonaws.com:27017 "ec2-user@ec2-$ip.compute-1.amazonaws.com"
}

function connectFetchDb {
    $ip = (aws ec2 describe-instances --instance-ids i-00b948dee8d6723a9 --query "Reservations[*].Instances[*].PublicIpAddress" --output text --profile hh).replace(".", '-')
    ssh -i "$keychainPath/HamletHub.pem" -L 27017:fetch-events-dev-cluster.cluster-c5gewfc0vpna.us-east-1.docdb.amazonaws.com:27017 "ec2-user@ec2-$ip.compute-1.amazonaws.com"
}

function updateAttdl {
    # run cd attdl command on the server
    ssh ubuntu@140.238.172.178 -i "$keychainPath/ubuntu.key" "cd /home/ubuntu/attdl_bot && sudo bash update.sh"
}

function getWSLPath {
    param (
        [string]$Path = (Get-Location).Path
    )

    # Replace backslashes with forward slashes
    $wslPath = $Path.Replace('\', '/')

    # Replace 'C:' with '/mnt/c', 'D:' with '/mnt/d', etc.
    $driveRegex = '^[A-Za-z]:'
    if ($wslPath -match $driveRegex) {
        $driveLetter = $wslPath.Substring(0, 1).ToLower()
        $wslPath = $wslPath -replace $driveRegex, "/mnt/$driveLetter"
    }

    return $wslPath
}

function wslHere([string] $command) {
    $path = getWSLPath
    wsl "$command" "$path"
}

# function AppendNewAliasToThisFile {
#     $aliasName = Read-Host "Enter alias name"
#     $aliasValue = Read-Host "Enter alias value"
#     $aliasDescription = Read-Host "Enter alias description"
#     $aliasScope = Read-Host "Enter alias scope"
#     $aliasForce = Read-Host "Enter alias force"
#     $aliasOptions = Read-Host "Enter alias options"
#     $aliasOptions = $aliasOptions -split " "
#     Set-Alias -Name $aliasName -Value $aliasValue -Description $aliasDescription -Scope $aliasScope -Force $aliasForce -Option $aliasOptions
#     Add-Content -Path $profile -Value "setAlias `"$aliasName`" `"$aliasValue`""
# }

# Important
echoHello

# Garbage
# Global
setAlias "help" "getHelp"
setAlias "config" "openConfig"
setAlias "cdconfig" "openConfigFolder"

# Git
setAlias "gs" "gitStatus"
setAlias "gc" "gitCommit"
setAlias "gaa" "gitAddCurrent"
setAlias "ga" "gitAdd"
setAlias "gp" "gitPush"
setAlias "upd" "gitPull"
setAlias "gacp" "gitAddCommitPush"
setAlias "gito" "gitCheckout"
setAlias "gb" "gitNewBranch"
setAlias "greset" "gitReset"

# Serverless framework
setAlias "sdeploy" "slsDeploy"
setAlias "sdf" "slsDeployFunction"

# Hamlethub
setAlias "devdb" "connectDevDb"
setAlias "proddb" "connectProdDb"
setAlias "fetchdb" "connectFetchDb"
