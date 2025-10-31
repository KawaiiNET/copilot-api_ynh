A reverse-engineered proxy for the GitHub Copilot API that exposes it as an OpenAI and Anthropic compatible service.

## Features

- **OpenAI & Anthropic Compatibility**: Exposes GitHub Copilot as an OpenAI-compatible and Anthropic-compatible API
- **Usage Dashboard**: Web-based dashboard to monitor your Copilot API usage
- **Rate Limit Control**: Manage API usage with rate-limiting options
- **Flexible Authentication**: Support for interactive authentication or direct token provision

## Prerequisites

- GitHub account with Copilot subscription (individual, business, or enterprise)

## Configuration

After installation, you can configure the app using the YunoHost admin panel or by editing the configuration file.

### GitHub Token

If you didn't provide a GitHub token during installation, you can add it later by:

1. SSH into your server
2. Navigate to the app's data directory: `/home/yunohost.app/copilot-api`
3. Run the authentication command: `cd /var/www/copilot-api && sudo -u copilot-api ./.bun/bin/bun run dist/main.js auth`

### Account Type

The default account type is "individual". If you have a business or enterprise GitHub Copilot plan, you should update the systemd service file to use the appropriate account type.

## Usage

### API Endpoints

The server exposes several endpoints:

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
`https://ericc-ch.github.io/copilot-api?endpoint=https://yourdomain.com/copilot-api/usage`

Replace `yourdomain.com` with your actual domain.

## Important Warnings

> **GitHub Security Notice:**  
> Excessive automated use of Copilot may trigger GitHub's abuse-detection systems. Use responsibly to avoid account restrictions.

> This is a reverse-engineered proxy and is not supported by GitHub. Use at your own risk.

## Support

For more information and documentation, visit: https://github.com/ericc-ch/copilot-api
