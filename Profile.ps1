Set-PSReadlineOption -EditMode vi

Remove-Alias -Name diff -Force

$Env:PATH="$Env:PRE_PATH;$Env:PATH"
