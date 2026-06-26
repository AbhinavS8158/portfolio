$ErrorActionPreference = "Stop"

Write-Host "Building Flutter Web..."
flutter build web --base-href /portfolio/

Write-Host "Navigating to build/web..."
cd build/web

Write-Host "Initializing git..."
git init
git add .
git commit -m "Manual deploy to gh-pages"

Write-Host "Pushing to gh-pages branch..."
git push --force https://github.com/AbhinavS8158/portfolio.git HEAD:gh-pages

Write-Host "Deployment complete!"
