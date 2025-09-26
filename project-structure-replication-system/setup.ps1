#!/usr/bin/env pwsh
param(
    [Parameter(Mandatory=$false)]
    [string]$Action = "help",
    
    [Parameter(Mandatory=$false)]
    [string]$ProjectName = ""
)

function Write-Success($message) { Write-Host "[SUCCESS] $message" -ForegroundColor Green }
function Write-Error($message) { Write-Host "[ERROR] $message" -ForegroundColor Red }
function Write-Warning($message) { Write-Host "[WARNING] $message" -ForegroundColor Yellow }
function Write-Info($message) { Write-Host "[INFO] $message" -ForegroundColor Blue }
function Write-Header($message) { 
    Write-Host ""
    Write-Host "=== $message ===" -ForegroundColor Cyan
    Write-Host "================================" -ForegroundColor Gray
}

if ($Action -eq "setup") {
    Write-Header "PROJECT STRUCTURE SETUP v3.0"
    
    if (-not $ProjectName) {
        Write-Error "Project name required!"
        Write-Info "Usage: .\setup.ps1 setup YourProjectName"
        exit 1
    }
    
    $sourceProject = if (Test-Path "project-links") { "project-links" } elseif (Test-Path "../project-links") { "../project-links" } else { $null }
    
    if (-not $sourceProject) {
        Write-Error "project-links folder not found!"
        Write-Info "Make sure project-links exists in current or parent directory"
        exit 1
    }
    
    if (Test-Path $ProjectName) {
        Write-Warning "Folder '$ProjectName' already exists!"
        $overwrite = Read-Host "Overwrite? (y/n)"
        if ($overwrite -ne "y") {
            Write-Info "Setup cancelled"
            exit 0
        }
        Remove-Item $ProjectName -Recurse -Force
    }
    
    Write-Info "Creating new project: $ProjectName"
    Copy-Item $sourceProject $ProjectName -Recurse
    Write-Success "Copied complete v3.0 enterprise structure"
    
    # Update project name in key files
    Write-Info "Customizing files..."
    
    $readmePath = "$ProjectName/README.md"
    if (Test-Path $readmePath) {
        $content = Get-Content $readmePath -Raw
        $content = $content -replace "Project Links Manager", $ProjectName
        Set-Content $readmePath $content
        Write-Success "Updated README.md"
    }
    
    $versionPath = "$ProjectName/project-docs/PROJECT_STRUCTURE_VERSION.md"
    if (Test-Path $versionPath) {
        $content = Get-Content $versionPath -Raw
        $content = $content -replace "Project Links Manager", $ProjectName
        Set-Content $versionPath $content
        Write-Success "Updated version file"
    }
    
    # Verify setup
    Write-Info "Verifying setup..."
    $checks = @(
        "$ProjectName/.github/workflows/ci.yml",
        "$ProjectName/config/security",
        "$ProjectName/config/quality",
        "$ProjectName/project-docs/templates",
        "$ProjectName/test"
    )
    
    $allGood = $true
    foreach ($path in $checks) {
        if (Test-Path $path) {
            Write-Success "$(Split-Path $path -Leaf) found"
        } else {
            Write-Error "$(Split-Path $path -Leaf) missing"
            $allGood = $false
        }
    }
    
    if ($allGood) {
        Write-Success "Setup complete! Project '$ProjectName' is ready!"
        Write-Info "Next steps:"
        Write-Host "  1. cd $ProjectName"
        Write-Host "  2. Edit README.md with your details"
        Write-Host "  3. Start coding!"
    } else {
        Write-Error "Setup had issues"
    }
    
} elseif ($Action -eq "update") {
    Write-Header "UPDATE TO v3.0"
    
    if (Test-Path "project-docs/PROJECT_STRUCTURE_VERSION.md") {
        $versionContent = Get-Content "project-docs/PROJECT_STRUCTURE_VERSION.md" -Raw
        if ($versionContent -match "v3\.0") {
            Write-Success "Already at v3.0!"
            exit 0
        }
    }
    
    Write-Info "Upgrading to v3.0..."
    
    # Create enterprise folders
    $folders = @(".github/workflows", "config/security", "config/quality", "docs")
    foreach ($folder in $folders) {
        if (-not (Test-Path $folder)) {
            New-Item $folder -ItemType Directory -Force | Out-Null
            Write-Success "Created $folder"
        }
    }
    
    # Find source (project-links)
    $source = if (Test-Path "project-links") { "project-links" } else { "../project-links" }
    
    if (-not (Test-Path $source)) {
        Write-Error "Cannot find project-links reference!"
        exit 1
    }
    
    # Copy enterprise files
    if (Test-Path "$source/.github/workflows/ci.yml") {
        Copy-Item "$source/.github/workflows/ci.yml" ".github/workflows/" -Force
        Write-Success "Added CI/CD pipeline"
    }
    
    if (Test-Path "$source/config") {
        Copy-Item "$source/config/*" "config/" -Recurse -Force
        Write-Success "Added configurations"
    }
    
    # Update version
    if (Test-Path "project-docs/PROJECT_STRUCTURE_VERSION.md") {
        $content = Get-Content "project-docs/PROJECT_STRUCTURE_VERSION.md" -Raw
        $content = $content -replace "v2\.0", "v3.0"
        Set-Content "project-docs/PROJECT_STRUCTURE_VERSION.md" $content
        Write-Success "Updated to v3.0"
    }
    
    Write-Success "Update complete!"
    
} elseif ($Action -eq "verify") {
    Write-Header "VERIFICATION"
    
    $issues = 0
    
    # Check folders
    $folders = @{
        ".github/workflows" = "CI/CD"
        "config" = "Configuration" 
        "project-docs" = "Documentation"
        "test" = "Tests"
    }
    
    foreach ($path in $folders.Keys) {
        if (Test-Path $path) {
            Write-Success "$($folders[$path]) found"
        } else {
            Write-Error "$($folders[$path]) missing"
            $issues++
        }
    }
    
    # Check templates
    if (Test-Path "project-docs/templates") {
        $templates = Get-ChildItem "project-docs/templates" -Filter "*.md" -Recurse
        Write-Info "Templates: $($templates.Count) (expected: 17)"
        if ($templates.Count -ge 17) {
            Write-Success "Template count OK"
        } else {
            Write-Warning "Low template count"
        }
    }
    
    # Check version
    if (Test-Path "project-docs/PROJECT_STRUCTURE_VERSION.md") {
        $content = Get-Content "project-docs/PROJECT_STRUCTURE_VERSION.md" -Raw
        if ($content -match "v3\.0") {
            Write-Success "Version: v3.0"
        } else {
            Write-Warning "Version not v3.0"
        }
    }
    
    if ($issues -eq 0) {
        Write-Success "All checks passed!"
    } else {
        Write-Error "$issues issues found"
    }
    
} else {
    Write-Header "PROJECT STRUCTURE SETUP TOOL v3.0"
    Write-Host ""
    Write-Host "ONE FILE TO RULE THEM ALL!"
    Write-Host ""
    Write-Host "COMMANDS:"
    Write-Host "  .\setup.ps1 setup ProjectName    # Create new v3.0 project"
    Write-Host "  .\setup.ps1 update              # Upgrade existing to v3.0"
    Write-Host "  .\setup.ps1 verify              # Check current structure"
    Write-Host "  .\setup.ps1 help                # Show this help"
    Write-Host ""
    Write-Host "EXAMPLES:"
    Write-Host "  .\setup.ps1 setup MyAwesomeApp   # Creates complete structure"
    Write-Host "  .\setup.ps1 update               # Upgrades v2.0 to v3.0"
    Write-Host "  .\setup.ps1 verify               # Validates structure"
    Write-Host ""
    Write-Host "WHAT YOU GET (v3.0):"
    Write-Host "  [+] CI/CD Pipeline"
    Write-Host "  [+] Security Framework"
    Write-Host "  [+] Quality Tools"
    Write-Host "  [+] 17 Professional Templates"
    Write-Host "  [+] Complete Documentation"
    Write-Host "  [+] Test Organization"
    Write-Host ""
    Write-Host "TIME: 30 seconds for new project!"
}