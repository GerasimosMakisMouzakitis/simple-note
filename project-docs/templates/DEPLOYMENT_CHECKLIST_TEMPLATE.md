# Deployment Checklist Template

## Pre-Deployment Checklist
**Date:** [INSERT DATE]
**Deployer:** [INSERT NAME]
**Version:** [INSERT VERSION]
**Environment:** [Production/Staging/Development]

## Code Preparation
- [ ] All tests passing
- [ ] Code review completed
- [ ] Documentation updated
- [ ] Version number updated
- [ ] Changelog updated

## Environment Setup
- [ ] Deployment environment ready
- [ ] Database migrations prepared
- [ ] Environment variables configured
- [ ] SSL certificates valid
- [ ] Domain configuration verified

## Security Checks
- [ ] Security scan completed
- [ ] Sensitive data removed from code
- [ ] API keys secured
- [ ] Access permissions configured
- [ ] Backup procedures verified

## Performance Verification
- [ ] Load testing completed
- [ ] Performance benchmarks met
- [ ] CDN configuration verified
- [ ] Caching strategy implemented
- [ ] Database optimization done

## Deployment Steps
1. **Backup Current Version**
   - [ ] Database backup created
   - [ ] File system backup completed
   - [ ] Configuration backup saved

2. **Deploy New Version**
   - [ ] Code deployed successfully
   - [ ] Database migrations run
   - [ ] Configuration files updated
   - [ ] Services restarted

3. **Verification**
   - [ ] Application starts successfully
   - [ ] Core functionality tested
   - [ ] API endpoints responding
   - [ ] Database connectivity verified

## Post-Deployment
- [ ] Smoke tests passed
- [ ] Performance monitoring active
- [ ] Error monitoring configured
- [ ] User acceptance testing
- [ ] Team notification sent

## Rollback Plan
**Trigger Conditions:**
- [List conditions that would trigger rollback]

**Rollback Steps:**
1. [Step 1]
2. [Step 2]
3. [Step 3]

## Sign-off
**Deployer:** [NAME] | **Date:** [DATE] | **Status:** [Success/Failed/Rolled Back]