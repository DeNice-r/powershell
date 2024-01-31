function echoHello {
    echo ☦️
}

function echoAhuy {
    echo 🤬
}

function kissBohdan {
    echo 😘☦️дан
}

function setAlias ([string] $name, [string] $value) {
    Set-Alias -Name $name -Value $value -force -Description "my alias" -Scope Global
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

function getHelp {
    Get-Alias | Where-Object {$_.Description -Match "my alias"}
}

function openConfig {
    code $profile
}

function connectDevDb { # perhaps abstract from a specific connection and make it generic?
    $ip = (aws ec2 describe-instances --instance-ids i-01b9fb5f7079f1d89 --query "Reservations[*].Instances[*].PublicIpAddress" --output text --profile hh).replace(".", '-')
    ssh -i E:/keychain/HamletHub.pem -L 27017:hamlethub-dev-cluster.cluster-c5gewfc0vpna.us-east-1.docdb.amazonaws.com:27017 "ec2-user@ec2-$ip.compute-1.amazonaws.com"
}

function connectProdDb {
    $ip = (aws ec2 describe-instances --instance-ids i-08af34a8129a8dbf9 --query "Reservations[*].Instances[*].PublicIpAddress" --output text --profile hh).replace(".", '-')
    ssh -i E:/keychain/HamletHub.pem -L 27017:hamlethub-prod-cluster.cluster-c5gewfc0vpna.us-east-1.docdb.amazonaws.com:27017 "ec2-user@ec2-$ip.compute-1.amazonaws.com"
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
setAlias "gs" "gitStatus"
setAlias "gc" "gitCommit"
setAlias "gaa" "gitAddCurrent"
setAlias "ga" "gitAdd"
setAlias "gp" "gitPush"
setAlias "upd" "gitPull"
setAlias "sdf" "slsDeployFunction"
setAlias "sdeploy" "slsDeploy"
setAlias "gacp" "gitAddCommitPush"
setAlias "help" "getHelp"
setAlias "config" "openConfig"
setAlias "devdb" "connectDevDb"
setAlias "proddb" "connectProdDb"
