# Project Structure Setup Script v4.0
# Simple Sticky Notes - Professional Project Organization
# Author: GerasimosMakisMouzakitis

param(
    [string]$Action,
    [string]$ProjectName
)

# Color functions for better output
function Write-Header($text) {
    Write-Host "`n=== $text ===" -ForegroundColor Cyan
    Write-Host ("=" * ($text.Length + 8)) -ForegroundColor Cyan
}

function Write-Success($text) {
    Write-Host "[SUCCESS] $text" -ForegroundColor Green
}

function Write-Info($text) {
    Write-Host "[INFO] $text" -ForegroundColor Yellow
}

function Write-Error($text) {
    Write-Host "[ERROR] $text" -ForegroundColor Red
}

if ($Action -eq "setup" -and $ProjectName) {
    Write-Header "PROJECT STRUCTURE SETUP v4.0"
    
    if (Test-Path $ProjectName) {
        Write-Error "Directory '$ProjectName' already exists!"
        exit 1
    }
    
    Write-Info "Creating new project: $ProjectName"
    New-Item $ProjectName -ItemType Directory | Out-Null
    
    # Create folder structure
    $folders = @(
        "project-docs/templates",
        "project-docs/current-development", 
        "project-docs/completed-features",
        "project-docs/reports/assessments",
        "project-docs/reports/comparisons", 
        "project-docs/reports/naming-analysis",
        "project-docs/project-rules",
        ".github/workflows",
        "config/security",
        "config/quality", 
        "docs",
        "test",
        "backups"
    )
    
    foreach ($folder in $folders) {
        New-Item "$ProjectName/$folder" -ItemType Directory -Force | Out-Null
        Write-Success "Created $folder"
    }
    
    # Copy templates from source
    $sourceTemplates = "../project-docs/templates"
    if (Test-Path $sourceTemplates) {
        Copy-Item "$sourceTemplates/*" "$ProjectName/project-docs/templates/" -Recurse -Force
        Write-Success "Copied 17 professional templates"
    }
    
    # Create essential files
    @"
# $ProjectName

**Version:** 1.0.0 | **Author:** [Your Name] | **License:** MIT

[Replace with your project description]

## Features

[List your project features]

## Getting Started

[Add setup instructions]

## License & Credits

**Author:** [Your Name]  
**Repository:** [Your Repository URL]  
**Version:** 1.0.0
"@ | Out-File "$ProjectName/README.md" -Encoding UTF8

    @"
# $ProjectName App Version

**Current App Version:** v1.0.0  
**Author:** [Your Name]  
**Repository:** [Your Repository URL]  
**Last Updated:** $(Get-Date -Format 'yyyy-MM-dd')

## App Version History

### v1.0.0 (Current - $(Get-Date -Format 'yyyy-MM-dd'))
- **Feature:** Initial project setup
- **Type:** Initial release

## Version Numbering

- **Major (X.0.0):** Breaking changes or complete app rewrites
- **Minor (0.X.0):** New features that are backward compatible  
- **Patch (0.0.X):** Bug fixes and small improvements
"@ | Out-File "$ProjectName/project-docs/project-rules/APP_VERSION.md" -Encoding UTF8

    @"
# Project Structure Version

**Current Version:** v4.0

## Version History

### v4.0 (Current)
- Dual version tracking system (app + structure)
- Professional version management (APP_VERSION.md)
- Enhanced analysis and reporting capabilities
- 17 professional templates
- Complete enterprise structure

### v3.0
- Enterprise structure (CI/CD, security, quality)
- 17 professional templates
- Advanced project organization

### v2.0  
- Enhanced template system
- Improved project organization

### v1.0
- Basic template system
- Core documentation framework
"@ | Out-File "$ProjectName/project-docs/project-rules/PROJECT_STRUCTURE_VERSION.md" -Encoding UTF8

    # Copy Rules.md from source
    $sourceRules = "../project-docs/project-rules/Rules.md"
    if (Test-Path $sourceRules) {
        Copy-Item $sourceRules "$ProjectName/project-docs/project-rules/"
        Write-Success "Copied Rules.md"
    }
    
    # Create howto.md
    @"
# How to Use This Project Structure

This project follows the v4.0 Professional Project Structure.

## Quick Start
1. Update APP_VERSION.md with your project details
2. Edit README.md with your project information
3. Follow the systematic workflow in project-docs/project-rules/Rules.md

## Template Usage
- Copy templates from project-docs/templates/ to current-development/
- Never edit templates directly
- Follow 3-phase workflow: Planning → Implementation → Documentation

See project-docs/project-rules/Rules.md for complete guidelines.
"@ | Out-File "$ProjectName/howto.md" -Encoding UTF8
    
    Write-Success "Project '$ProjectName' created successfully!"
    Write-Info "Next steps:"
    Write-Info "1. cd $ProjectName"  
    Write-Info "2. Edit APP_VERSION.md with your project details"
    Write-Info "3. Update README.md"
    Write-Info "4. Follow howto.md for systematic development"
    
} elseif ($Action -eq "verify") {
    Write-Header "VERIFICATION v4.0"
    
    $issues = 0
    
    # Check folders
    $folders = @{
        ".github/workflows" = "CI/CD"
        "config" = "Configuration"
        "project-docs" = "Documentation" 
        "test" = "Tests"
        "project-docs/project-rules" = "Governance"
    }
    
    foreach ($path in $folders.Keys) {
        if (Test-Path $path) {
            Write-Success "$($folders[$path]) found"
        } else {
            Write-Error "$($folders[$path]) missing"
            $issues++
        }
    }
    
    # Check version files  
    $versionFiles = @{
        "project-docs/project-rules/APP_VERSION.md" = "App Version Tracking"
        "project-docs/project-rules/PROJECT_STRUCTURE_VERSION.md" = "Structure Version Tracking"
    }
    
    foreach ($file in $versionFiles.Keys) {
        if (Test-Path $file) {
            Write-Success "$($versionFiles[$file]) found"
        } else {
            Write-Error "$($versionFiles[$file]) missing" 
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
            Write-Error "Missing templates"
            $issues++
        }
    }
    
    if ($issues -eq 0) {
        Write-Success "All v4.0 checks passed!"
    } else {
        Write-Error "$issues issues found"
    }
    
} else {
    Write-Header "PROJECT STRUCTURE SETUP TOOL v4.0"
    Write-Host ""
    Write-Host "PROFESSIONAL PROJECT ORGANIZATION SYSTEM!"
    Write-Host ""
    Write-Host "COMMANDS:"
    Write-Host "  .\setup.ps1 setup ProjectName    # Create new v4.0 project"
    Write-Host "  .\setup.ps1 verify              # Check current structure" 
    Write-Host "  .\setup.ps1 help                # Show this help"
    Write-Host ""
    Write-Host "EXAMPLES:"
    Write-Host "  .\setup.ps1 setup MyAwesomeApp   # Creates complete v4.0 structure"
    Write-Host "  .\setup.ps1 verify               # Validates current structure"
    Write-Host ""
    Write-Host "WHAT YOU GET (v4.0):"
    Write-Host "  [+] Dual Version Tracking (App + Structure)"
    Write-Host "  [+] Professional Version Management"  
    Write-Host "  [+] 17 Professional Templates"
    Write-Host "  [+] Enterprise Organization (CI/CD, Security, Quality)"
    Write-Host "  [+] Complete Documentation System"
    Write-Host "  [+] Systematic Development Workflow"
    Write-Host "  [+] Battle-tested with Real Application"
    Write-Host ""
    Write-Host "SOURCE: Simple Sticky Notes v1.1.0 Project"
    Write-Host "TIME: 30 seconds for complete professional setup!"
}