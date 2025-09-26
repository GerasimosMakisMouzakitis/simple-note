# Project Development Rules

**Project:** [PROJECT_NAME]  
**Version:** 1.0  
**Last Updated:** [DATE]  
**Applies To:** All development work on [PROJECT_NAME]

## 🎯 **Core Principles**

### **1. Documentation-First Development**
- All features must have task breakdown before implementation begins
- Every completed feature requires completion summary documentation
- All significant decisions require comparison analysis when alternatives exist
- Templates must be used for all structured documentation

### **2. Systematic File Organization**
- All files follow standardized naming conventions
- Documentation uses version-based naming to prevent conflicts
- Project structure follows 5-folder system: templates, current-development, completed-features, reports, project-rules
- Never modify master templates - always copy and customize

### **3. Version Control Standards**
- Backup before any significant changes (timestamped folders)
- Frequent commits with descriptive messages
- UTC timestamps for all time-sensitive documentation
- Systematic git workflow with proper branching strategy

## 📁 **Directory Structure Rules**

### **project-docs/ Organization**
```
project-docs/
├── templates/                  [NEVER EDIT - Master templates only]
├── current-development/        [Active work - rename when complete]
├── completed-features/         [Archived - use versioned naming]
├── reports/                   [Analysis docs - use versioned naming]
│   ├── naming-analysis/
│   ├── comparisons/
│   └── assessments/
└── project-rules/             [Project governance - rarely changed]
```

### **Directory Usage Rules**
- **templates/**: Contains master templates. NEVER edit directly. Copy to other folders for use.
- **current-development/**: Working files for active features. Move to completed-features when done.
- **completed-features/**: Permanent archive using strict naming convention
- **reports/**: Analysis and assessment documents using versioned naming
- **project-rules/**: Governance documents that rarely change

## 📝 **File Naming Conventions**

### **Completed Features** (completed-features/)
```
[FILE_TYPE]_v[VERSION]_[FEATURE-NAME]_[COMPLETION-DATE].md
```

**Examples:**
- `TASK_BREAKDOWN_v0.2.0_Note-Area-Feature_2025-09-23.md`
- `COMPLETION_SUMMARY_v1.1.0_User-Authentication_2025-10-15.md`
- `APP_VERSION_v0.2.0_Note-Area-Feature_2025-09-23.md`

### **Reports** (reports/)
```
[REPORT_TYPE]_[SUBJECT]_[DATE].md
```

**Examples:**
- `NAMING_CONVENTION_ANALYSIS_2025-09-22.md`
- `COMPARISON_REPORT_Database-Selection_2025-10-15.md`
- `PERFORMANCE_ASSESSMENT_Load-Testing_2025-11-01.md`

### **Current Development** (current-development/)
```
[DESCRIPTOR]_[FEATURE-NAME].md
```

**Examples:**
- `TASK_BREAKDOWN_Note-Area-Feature.md` (temporary - rename when complete)
- `PLANNING_User-Authentication.md`
- `RESEARCH_API-Integration.md`

## ⏰ **Time and Dating Standards**

### **UTC Time Requirement**
- All timestamps in documentation must use UTC
- Format: `YYYY-MM-DDTHH:MM:SSZ` for precise times
- Format: `YYYY-MM-DD` for dates only
- Rationale: Prevents timezone confusion in global teams

### **Dating Examples**
- ✅ `2025-09-23T14:30:00Z` (UTC timestamp)
- ✅ `2025-09-23` (date only)
- ❌ `9/23/2025` (ambiguous format)
- ❌ `2025-09-23 14:30:00` (no timezone specified)

## 🔄 **Backup Requirements**

### **Mandatory Backup Triggers**
- Before implementing any new feature
- Before major refactoring or restructuring
- Before updating project structure
- Before file renaming operations

### **Backup Naming**
```
backups/[PROJECT_NAME]-[YYYYMMDD-HHMMSS]/
```

**Example:**
```
backups/project-links-20250923-032421/
```

### **Backup Content**
- Complete copy of all project files
- Include documentation, code, tests, and configuration
- Exclude temporary files (.git, node_modules, etc.)
- Create README in backup folder explaining what was backed up and why

## 📋 **Template Usage Rules**

### **Template Workflow**
1. **Never edit templates directly** - they are master copies
2. **Copy template to appropriate folder** (usually current-development/)
3. **Customize copy for your specific use case**
4. **When complete, move to completed-features/ with proper naming**

### **Template Categories**
- **TASK_BREAKDOWN_TEMPLATE.md**: For planning new features
- **COMPLETION_SUMMARY_TEMPLATE.md**: For documenting completed work
- **COMPARISON_REPORT_TEMPLATE.md**: For analyzing alternatives
- **NAMING_CONVENTION_ANALYSIS_TEMPLATE.md**: For file organization analysis

### **Template Maintenance**
- Templates updated only when improvements benefit all future projects
- Changes to templates require documentation of rationale
- Version templates if significant changes are made

## 🏗️ **Development Workflow**

### **Feature Development Process**
1. **Planning Phase**:
   - Copy TASK_BREAKDOWN_TEMPLATE.md to current-development/
   - Fill out complete task breakdown
   - Create backup before implementation begins

2. **Implementation Phase**:
   - Follow task breakdown systematically
   - Commit frequently with descriptive messages
   - Update task breakdown to mark completed items

3. **Completion Phase**:
   - Copy COMPLETION_SUMMARY_TEMPLATE.md to current-development/
   - Document all achievements and implementation details
   - Move both files to completed-features/ with proper naming
   - Update project version if applicable

### **Decision Documentation**
- Use COMPARISON_REPORT_TEMPLATE.md for significant technical decisions
- Document alternatives considered and rationale for choice
- Include implementation recommendations and risk assessment

## 🧪 **Testing Standards**

### **Testing Requirements**
- All features require manual testing before completion
- Create test cases for edge conditions and error scenarios
- Document test results in completion summary
- Maintain test files in test/ directory

### **Test Documentation**
- Test plans should reference specific task breakdown items
- Test results should be quantified where possible
- Include screenshots or examples for UI features
- Document any known limitations or issues

## 📊 **Version Management**

### **Versioning Strategy**
- **Major Version (X.0.0)**: Breaking changes or major new functionality
- **Minor Version (0.X.0)**: New features that are backward compatible
- **Patch Version (0.0.X)**: Bug fixes and small improvements

### **Version Documentation**
- Update version numbers in all relevant files consistently
- Document version changes in completion summaries
- Create APP_VERSION file for major releases explaining changes
- Tag releases in git with proper version numbers

## 🚀 **Quality Assurance**

### **Documentation Quality**
- All documentation must be complete and understandable
- Use proper markdown formatting consistently
- Include examples and use cases where applicable
- Proofread all documentation before archiving

### **Code Quality**
- Follow consistent coding standards for the project language
- Include comments for complex logic
- Maintain clean, readable code structure
- Document API interfaces and data formats

### **File Organization Quality**
- Verify all files are in correct directories
- Ensure naming conventions are followed exactly
- Check that all internal links work correctly
- Maintain clean directory structure without orphaned files

## ⚠️ **Common Pitfalls to Avoid**

### **Documentation Mistakes**
- ❌ Editing master templates directly
- ❌ Using inconsistent naming conventions
- ❌ Forgetting to create backups before changes
- ❌ Using local timestamps instead of UTC
- ❌ Incomplete task breakdowns or completion summaries

### **File Organization Mistakes**
- ❌ Mixing completed and current work in same folders
- ❌ Using non-standard file names in completed-features/
- ❌ Creating deep nested directory structures
- ❌ Storing temporary files in permanent directories

### **Workflow Mistakes**
- ❌ Starting implementation without proper planning
- ❌ Skipping documentation for "small" changes
- ❌ Inconsistent git commit practices
- ❌ Not testing thoroughly before completion

## 📚 **Team Guidelines**

### **Onboarding New Team Members**
- Review this rules document completely
- Practice using templates with sample feature
- Understand directory structure and naming conventions
- Learn backup and version control procedures

### **Collaboration Standards**
- All team members must follow same rules consistently
- Communicate changes to rules or processes
- Share knowledge through proper documentation
- Review each other's work for compliance

### **Conflict Resolution**
- Rules document takes precedence over individual preferences
- Suggest rule changes through proper documentation process
- Maintain consistency even if individual approaches differ
- Focus on project success over personal preferences

---

## 📅 **Rule Maintenance**

### **Regular Reviews**
- **Monthly**: Check compliance with current rules
- **Per Feature**: Assess if rules supported successful completion
- **Quarterly**: Consider rule improvements based on experience

### **Rule Updates**
- Document reason for any rule changes
- Update version number when significant changes made
- Communicate changes to all team members
- Update templates if rule changes affect their structure

---

**Rules Version:** 1.0  
**Effective Date:** [DATE]  
**Next Review:** [DATE + 3 months]  
**Approved By:** [TEAM_LEAD/PROJECT_MANAGER]

*These rules ensure consistent, professional development practices and high-quality project organization. Following them systematically leads to successful project outcomes and maintainable codebases.*