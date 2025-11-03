@echo off
chcp 65001 >nul
echo 开始部署...

set /p TOKEN=<..\token.txt

jekyll build
git add . 
git commit -m "更新" || echo 无新更改
git -c http.sslVerify=false push https://jianyi8377:%TOKEN%@github.com/Jianyi8377/jianyi8377.github.io.git main

set TOKEN=
echo 完成
pause