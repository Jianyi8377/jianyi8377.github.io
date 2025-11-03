@echo off
chcp 65001 >nul
echo 开始部署...

jekyll build
git add .
git commit -m "更新: %date% %time%"
git -c http.sslVerify=false push origin main

echo.
echo ✅ 部署完成! https://jianyi8377.github.io
pause