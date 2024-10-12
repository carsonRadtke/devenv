cp .clang-format $Env:USERPROFILE
cp .gitcommitmsg $Env:USERPROFILE
cp .gitconfig $Env:USERPROFILE
cp .gitignore $Env:USERPROFILE

mkdir $Env:USERPROFILE\Documents/Powershell
cp Profile.ps1 $Env:USERPROFILE\Documents/Powershell/Profile.ps1

mkdir $Env:USERPROFILE\.config\nvim
cp init.lua $Env:USERPROFILE\.config\nvim
cp colors.vim $Env:USERPROFILE\.config\nvim
