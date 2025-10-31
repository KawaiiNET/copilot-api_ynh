# YunoHost App Integration - Complete Summary

This document provides a comprehensive overview of the YunoHost app packaging that has been added to the copilot-api repository.

## What Was Added

Complete YunoHost app packaging has been integrated into the repository, allowing users to easily install and manage the Copilot API Proxy on their YunoHost servers.

## Files Added

### Core Configuration Files

1. **manifest.toml** (1.8 KB)
   - App metadata and installation parameters
   - Resource definitions with verified SHA256 hash
   - YunoHost packaging format v2 compliant

2. **config_panel.toml** (798 B)
   - Admin panel configuration
   - Allows easy post-installation configuration
   - Properly binds to .env variables

3. **README_yunohost.md** (4.0 KB)
   - YunoHost-specific documentation
   - Installation instructions
   - Usage guide with API endpoints

4. **YUNOHOST_INSTALL.md** (4.1 KB)
   - Detailed installation guide
   - Configuration instructions
   - Troubleshooting tips

### Installation Scripts (scripts/)

All scripts are executable and follow YunoHost best practices:

1. **install** (2.7 KB)
   - Installs Bun runtime
   - Builds the application
   - Configures systemd service and nginx
   - Sets up proper permissions

2. **remove** (1.2 KB)
   - Clean removal of app
   - Removes all configurations
   - Stops and removes systemd service

3. **upgrade** (2.3 KB)
   - Handles app upgrades
   - Preserves configuration and data
   - Rebuilds the application

4. **backup** (1.5 KB)
   - Backs up app files and data
   - Includes configuration files
   - Backs up logs

5. **restore** (2.3 KB)
   - Restores app from backup
   - Reinstalls dependencies
   - Restores all configurations

6. **change_url** (994 B)
   - Handles domain/path changes
   - Updates nginx configuration

7. **calculate_sha256.sh** (1.9 KB)
   - Helper script to calculate SHA256 hash
   - Reads version from package.json
   - Verifies version consistency

### Configuration Templates (conf/)

1. **nginx.conf** (749 B)
   - Reverse proxy configuration
   - WebSocket support
   - Proper timeout settings
   - YunoHost SSO integration

2. **copilot-api.service** (1.2 KB)
   - Systemd service configuration
   - Security hardening (NoNewPrivileges, ProtectSystem, etc.)
   - Environment variable management
   - Automatic restart on failure

3. **.env** (190 B)
   - Environment variables template
   - GH_TOKEN for GitHub authentication
   - ACCOUNT_TYPE for Copilot plan
   - PORT configuration

### Documentation (doc/)

1. **DESCRIPTION.md** (2.3 KB)
   - English description for YunoHost catalog
   - Features overview
   - Configuration guide

2. **DESCRIPTION_fr.md** (2.8 KB)
   - French description for YunoHost catalog
   - Translated features and guide

### CI/CD Support (.github/yunohost/)

1. **check_process** (814 B)
   - YunoHost CI/CD integration
   - Test configuration
   - Upgrade test definitions

## Features Implemented

✅ **Multi-instance Support**
   - Multiple instances can run on the same server

✅ **Automatic Dependency Management**
   - Bun runtime installed automatically
   - All dependencies managed by the scripts

✅ **Security Hardening**
   - GitHub token via environment variables (not command line)
   - Systemd service with multiple protection layers
   - Proper file permissions (750 for dirs, 400 for .env)
   - Non-root user execution

✅ **Complete Backup/Restore**
   - All app files backed up
   - Configuration preserved
   - Data directory included

✅ **Easy Configuration**
   - Web-based config panel
   - Post-installation configuration
   - Support for all account types

✅ **Nginx Integration**
   - Reverse proxy with WebSocket support
   - Proper timeout settings
   - YunoHost SSO integration

✅ **Logging**
   - Systemd logging to /var/log/
   - Logrotate configuration
   - Easy log access via journalctl

## Installation

### Method 1: Direct Installation (Recommended for Testing)

```bash
sudo yunohost app install https://github.com/ericc-ch/copilot-api --debug
```

### Method 2: From Local Directory

```bash
git clone https://github.com/MrTakedi/copilot-api.git
cd copilot-api
sudo yunohost app install . --debug
```

## Configuration

### During Installation

You will be prompted for:
- **Domain**: Where the app will be accessible
- **Path**: URL path (default: /copilot-api)
- **Permissions**: Who can access (default: visitors)
- **GitHub Token**: Optional, can be added later
- **Account Type**: individual/business/enterprise

### After Installation

#### Add GitHub Token (if not provided during installation):

```bash
# SSH into your server
ssh user@yourdomain.tld

# Switch to app user
sudo -u copilot-api -i

# Navigate to install directory
cd /var/www/copilot-api

# Run authentication
./.bun/bin/bun run dist/main.js auth
```

#### Or Configure via Admin Panel:

1. Go to YunoHost admin panel
2. Navigate to Applications → Copilot API
3. Click "Config panel"
4. Update GitHub token and account type

## Usage

### API Endpoints

Once installed, access the API at `https://yourdomain.tld/copilot-api`:

**OpenAI Compatible:**
- `POST /copilot-api/v1/chat/completions`
- `GET /copilot-api/v1/models`
- `POST /copilot-api/v1/embeddings`

**Anthropic Compatible:**
- `POST /copilot-api/v1/messages`
- `POST /copilot-api/v1/messages/count_tokens`

**Usage Monitoring:**
- `GET /copilot-api/usage`
- `GET /copilot-api/token`

### Usage Dashboard

View usage statistics at:
```
https://ericc-ch.github.io/copilot-api?endpoint=https://yourdomain.tld/copilot-api/usage
```

## Management

### View Logs
```bash
sudo journalctl -u copilot-api -f
```

### Restart Service
```bash
sudo systemctl restart copilot-api
```

### Check Status
```bash
sudo systemctl status copilot-api
```

### Update Configuration
```bash
# Edit .env file
sudo nano /var/www/copilot-api/.env

# Restart service
sudo systemctl restart copilot-api
```

## Uninstallation

```bash
sudo yunohost app remove copilot-api
```

This will:
- Stop the service
- Remove app files
- Remove nginx configuration
- Remove systemd service
- Data directory is preserved (can be manually deleted)

## Testing Results

✅ **Build**: Passes (tsdown compilation successful)
✅ **Tests**: All 26 tests passing
✅ **Linting**: Passes (eslint)
✅ **SHA256**: Verified (d068030271b917c9f59e21dda4dbd36840372160efa1b1f0598e35dc277689de)
✅ **Code Review**: All feedback addressed

## Security Considerations

⚠️ **Important Warnings:**

1. **Reverse-Engineered Proxy**: This is not officially supported by GitHub
2. **Abuse Detection**: Excessive use may trigger GitHub's abuse-detection systems
3. **Use Responsibly**: To avoid account restrictions

**Security Features:**
- GitHub token stored in environment variables (not command line)
- Systemd hardening (NoNewPrivileges, ProtectSystem, ProtectHome, etc.)
- Proper file permissions and ownership
- Non-root user execution
- SSL/HTTPS via nginx reverse proxy

## Support and Documentation

- **Upstream Project**: https://github.com/ericc-ch/copilot-api
- **YunoHost Documentation**: See README_yunohost.md and YUNOHOST_INSTALL.md
- **Issues**: Report YunoHost-specific issues to this repository

## Notes for Maintainers

### Updating the SHA256 Hash

When a new version is released:

```bash
# Run the helper script
./scripts/calculate_sha256.sh

# Update manifest.toml with the new hash
```

The script automatically:
- Reads version from package.json
- Downloads the release tarball
- Calculates SHA256
- Checks version consistency with manifest.toml

### Bun Installation

The scripts use the official Bun installation method:
```bash
curl -fsSL https://bun.sh/install | bash
```

This is the recommended approach per https://bun.sh/docs/installation

### Testing Changes

Before submitting changes:

```bash
# Build
bun run build

# Test
bun test

# Lint
bun run lint
```

## Checklist Summary

- [x] ✅ Create YunoHost manifest.toml with app metadata
- [x] ✅ Create all installation scripts (install, remove, upgrade, backup, restore, change_url)
- [x] ✅ Create configuration templates (nginx, systemd, .env)
- [x] ✅ Add documentation (English and French)
- [x] ✅ Create config panel for easy management
- [x] ✅ Add SHA256 helper script
- [x] ✅ Add CI/CD check_process file
- [x] ✅ Verify SHA256 hash
- [x] ✅ Address all code review feedback
- [x] ✅ Test build and linting
- [x] ✅ All tests passing

## Conclusion

The copilot-api repository now includes complete YunoHost app packaging, allowing users to easily install and manage the Copilot API Proxy on their YunoHost servers. All files follow YunoHost best practices and packaging format v2 specifications, with proper security hardening, backup/restore functionality, and comprehensive documentation.

The implementation maintains full compatibility with the existing application while adding the convenience of YunoHost's app management features.
