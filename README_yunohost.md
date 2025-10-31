# Copilot API for YunoHost

[![Integration level](https://dash.yunohost.org/integration/copilot-api.svg)](https://ci-apps.yunohost.org/ci/apps/copilot-api/) ![Working status](https://ci-apps.yunohost.org/ci/badges/copilot-api.status.svg) ![Maintenance status](https://ci-apps.yunohost.org/ci/badges/copilot-api.maintain.svg)

[![Install Copilot API with YunoHost](https://install-app.yunohost.org/install-with-yunohost.svg)](https://install-app.yunohost.org/?app=copilot-api)

*[Read this README in other languages.](./ALL_README.md)*

> *This package allows you to install Copilot API quickly and simply on a YunoHost server.*  
> *If you don't have YunoHost, please consult [the guide](https://yunohost.org/install) to learn how to install it.*

## Overview

A reverse-engineered proxy for the GitHub Copilot API that exposes it as an OpenAI and Anthropic compatible service. This allows you to use GitHub Copilot with any tool that supports the OpenAI Chat Completions API or the Anthropic Messages API.

**Shipped version:** 0.7.0~ynh1

## Screenshots

![Usage Dashboard](https://github.com/ericc-ch/copilot-api/raw/main/pages/screenshot.png)

## Disclaimers / important information

> **Warning**  
> This is a reverse-engineered proxy of GitHub Copilot API. It is not supported by GitHub, and may break unexpectedly. Use at your own risk.

> **GitHub Security Notice:**  
> Excessive automated or scripted use of Copilot may trigger GitHub's abuse-detection systems. Use responsibly to avoid account restrictions.

### Configuration

After installation, you will need to configure your GitHub token:

1. SSH into your YunoHost server
2. Switch to the copilot-api user: `sudo -u copilot-api -i`
3. Navigate to the installation directory: `cd /var/www/copilot-api`
4. Run the authentication command: `./.bun/bin/bun run dist/main.js auth`
5. Follow the prompts to authenticate with GitHub

Alternatively, you can provide a GitHub token during installation or configure it later through the YunoHost admin panel.

### Features

- **OpenAI & Anthropic Compatibility**: Exposes GitHub Copilot as an OpenAI-compatible and Anthropic-compatible API
- **Usage Dashboard**: Web-based dashboard to monitor your Copilot API usage
- **Rate Limit Control**: Manage API usage with rate-limiting options
- **Claude Code Integration**: Compatible with Claude Code from Anthropic
- **Flexible Authentication**: Support for individual, business, and enterprise GitHub Copilot plans

### API Endpoints

Once installed, the following endpoints will be available at `https://yourdomain.tld/copilot-api`:

#### OpenAI Compatible Endpoints
- `POST /v1/chat/completions` - Creates a model response
- `GET /v1/models` - Lists available models
- `POST /v1/embeddings` - Creates embeddings

#### Anthropic Compatible Endpoints
- `POST /v1/messages` - Creates a model response
- `POST /v1/messages/count_tokens` - Counts tokens

#### Usage Monitoring
- `GET /usage` - Get usage statistics
- `GET /token` - Get current token

### Usage Dashboard

Access the usage dashboard by visiting:
```
https://ericc-ch.github.io/copilot-api?endpoint=https://yourdomain.tld/copilot-api/usage
```

Replace `yourdomain.tld` with your actual YunoHost domain.

## Documentation and resources

- Official app website: <https://github.com/ericc-ch/copilot-api>
- Official user documentation: <https://github.com/ericc-ch/copilot-api#readme>
- YunoHost Store: <https://apps.yunohost.org/app/copilot-api>
- Report a bug: <https://github.com/YunoHost-Apps/copilot-api_ynh/issues>

## Developer info

Please send your pull request to the [testing branch](https://github.com/YunoHost-Apps/copilot-api_ynh/tree/testing).

To try the testing branch, please proceed like that:

```bash
sudo yunohost app install https://github.com/YunoHost-Apps/copilot-api_ynh/tree/testing --debug
or
sudo yunohost app upgrade copilot-api -u https://github.com/YunoHost-Apps/copilot-api_ynh/tree/testing --debug
```

**More info regarding app packaging:** <https://yunohost.org/packaging_apps>
