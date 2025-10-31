# YunoHost Installation Instructions

This repository now contains all the necessary files to install the Copilot API Proxy as a YunoHost app.

## Files Added

The following YunoHost packaging files have been added to the repository:

### Core Files
- `manifest.toml` - App metadata and installation parameters
- `config_panel.toml` - Configuration panel for the YunoHost admin interface
- `README_yunohost.md` - YunoHost-specific documentation

### Scripts Directory (`scripts/`)
- `install` - Installation script
- `remove` - Removal script
- `upgrade` - Upgrade script
- `backup` - Backup script
- `restore` - Restore script
- `change_url` - URL change script

### Configuration Templates (`conf/`)
- `nginx.conf` - Nginx reverse proxy configuration
- `copilot-api.service` - Systemd service configuration
- `.env` - Environment variables template

### Documentation (`doc/`)
- `DESCRIPTION.md` - English description for YunoHost catalog
- `DESCRIPTION_fr.md` - French description for YunoHost catalog

## Installation on YunoHost

### Option 1: Install from this repository

To install directly from this repository:

```bash
sudo yunohost app install https://github.com/ericc-ch/copilot-api --debug
```

### Option 2: Install from local directory

1. Clone this repository to your YunoHost server
2. Navigate to the repository directory
3. Run:
```bash
sudo yunohost app install . --debug
```

## Configuration

### During Installation

You will be prompted for:
- Domain name where the app will be installed
- URL path (default: `/copilot-api`)
- Access permissions (default: visitors)
- GitHub token (optional, can be configured later)
- GitHub Copilot account type (individual/business/enterprise)

### After Installation

If you didn't provide a GitHub token during installation:

1. SSH into your YunoHost server
2. Switch to the app user: `sudo -u copilot-api -i`
3. Navigate to the installation directory: `cd /var/www/copilot-api`
4. Run authentication: `./.bun/bin/bun run dist/main.js auth`
5. Follow the prompts to authenticate with GitHub

You can also configure the app later through the YunoHost admin panel under "Applications" → "Copilot API" → "Config panel".

## Usage

Once installed, the API will be available at:
```
https://yourdomain.tld/copilot-api
```

### API Endpoints

- `POST /copilot-api/v1/chat/completions` - OpenAI-compatible chat completions
- `GET /copilot-api/v1/models` - List available models
- `POST /copilot-api/v1/embeddings` - Create embeddings
- `POST /copilot-api/v1/messages` - Anthropic-compatible messages
- `GET /copilot-api/usage` - Usage statistics

### Usage Dashboard

View your usage dashboard at:
```
https://ericc-ch.github.io/copilot-api?endpoint=https://yourdomain.tld/copilot-api/usage
```

## Important Notes

### SHA256 Hash Update Required

Before submitting to the YunoHost app catalog, you need to update the SHA256 hash in `manifest.toml`:

1. Download the release tarball:
   ```bash
   wget https://github.com/ericc-ch/copilot-api/archive/refs/tags/v0.7.0.tar.gz
   ```

2. Calculate the SHA256 hash:
   ```bash
   sha256sum v0.7.0.tar.gz
   ```

3. Update the hash in `manifest.toml` under `[resources.sources.main]`

### Security Warnings

- This is a reverse-engineered proxy and is not officially supported by GitHub
- Excessive automated use may trigger GitHub's abuse-detection systems
- Use responsibly to avoid account restrictions

## Troubleshooting

### View logs
```bash
sudo journalctl -u copilot-api -f
```

### Restart service
```bash
sudo systemctl restart copilot-api
```

### Check service status
```bash
sudo systemctl status copilot-api
```

## Uninstallation

To remove the app:
```bash
sudo yunohost app remove copilot-api
```

This will:
- Stop the service
- Remove the app files
- Remove the Nginx configuration
- Remove the systemd service
- Preserve your data directory (optional - you can delete it manually if needed)

## Support

For issues specific to the YunoHost packaging, please open an issue in this repository.

For issues with the Copilot API itself, please refer to the upstream repository: https://github.com/ericc-ch/copilot-api
