# 设置控制台编码为 UTF-8
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8
$OutputEncoding = [System.Text.Encoding]::UTF8

# 读取 token
$token = Get-Content "..\token.txt" -First 1
Write-Host "Token读取成功" -ForegroundColor Green

Write-Host "开始部署..." -ForegroundColor Cyan

# 构建网站
Write-Host "构建Jekyll网站..." -ForegroundColor Yellow
jekyll build

# Git 操作
Write-Host "添加文件到Git..." -ForegroundColor Yellow
git add .

Write-Host "提交更改..." -ForegroundColor Yellow
git commit -m "更新: $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')"

Write-Host "推送到GitHub..." -ForegroundColor Yellow
git -c http.sslVerify=false push "https://jianyi8377:$token@github.com/Jianyi8377/jianyi8377.github.io.git" main

if ($LASTEXITCODE -eq 0) {
    Write-Host "✅ 部署成功! https://jianyi8377.github.io" -ForegroundColor Green
} else {
    Write-Host "❌ 部署失败!" -ForegroundColor Red
}