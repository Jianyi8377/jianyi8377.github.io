# Read token
$tokenPath = "..\token.txt"
if (-not (Test-Path $tokenPath)) {
    Write-Host "Error: Token file not found" -ForegroundColor Red
    exit 1
}

$token = Get-Content $tokenPath -First 1
Write-Host "Token read successfully" -ForegroundColor Green

Write-Host "Starting sync from repository to local..." -ForegroundColor Cyan

# Stash local changes
Write-Host "Stashing local changes..." -ForegroundColor Yellow
git stash

# Fetch latest from repository
Write-Host "Fetching latest from repository..." -ForegroundColor Yellow
git -c http.sslVerify=false fetch "https://jianyi8377:$token@github.com/Jianyi8377/jianyi8377.github.io.git"

# Hard reset to main branch (WARNING: This will overwrite all local changes)
Write-Host "Resetting local files to repository state..." -ForegroundColor Yellow
git reset --hard origin/main

# Pull latest changes
Write-Host "Pulling latest changes..." -ForegroundColor Yellow
git -c http.sslVerify=false pull "https://jianyi8377:$token@github.com/Jianyi8377/jianyi8377.github.io.git" main

if ($LASTEXITCODE -eq 0) {
    Write-Host "SUCCESS: Local files now match repository exactly" -ForegroundColor Green
} else {
    Write-Host "FAILED: Sync failed!" -ForegroundColor Red
}