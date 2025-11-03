# Read token
$token = Get-Content "..\token.txt" -First 1
Write-Host "Token read successfully" -ForegroundColor Green

Write-Host "Starting deployment..." -ForegroundColor Cyan

# Build site
Write-Host "Building Jekyll site..." -ForegroundColor Yellow
jekyll build

# Git operations
Write-Host "Adding files to Git..." -ForegroundColor Yellow
git add .

Write-Host "Committing changes..." -ForegroundColor Yellow
git commit -m "Update: $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')"

Write-Host "Pushing to GitHub..." -ForegroundColor Yellow
git -c http.sslVerify=false push "https://jianyi8377:$token@github.com/Jianyi8377/jianyi8377.github.io.git" main

if ($LASTEXITCODE -eq 0) {
    Write-Host "√ Deployment successful! https://jianyi8377.github.io" -ForegroundColor Green
} else {
    Write-Host "× Deployment failed!" -ForegroundColor Red
}