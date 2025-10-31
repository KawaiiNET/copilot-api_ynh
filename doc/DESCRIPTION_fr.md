Un proxy inverse pour l'API GitHub Copilot qui l'expose comme un service compatible OpenAI et Anthropic.

## Fonctionnalités

- **Compatibilité OpenAI & Anthropic** : Expose GitHub Copilot comme une API compatible OpenAI et Anthropic
- **Tableau de bord d'utilisation** : Interface web pour surveiller votre utilisation de l'API Copilot
- **Contrôle de limite de débit** : Gérez l'utilisation de l'API avec des options de limitation de débit
- **Authentification flexible** : Prise en charge de l'authentification interactive ou de la fourniture directe de jeton

## Prérequis

- Compte GitHub avec un abonnement Copilot (individuel, entreprise ou organisation)

## Configuration

Après l'installation, vous pouvez configurer l'application en utilisant le panneau d'administration YunoHost ou en éditant le fichier de configuration.

### Jeton GitHub

Si vous n'avez pas fourni de jeton GitHub lors de l'installation, vous pouvez l'ajouter plus tard en :

1. Vous connectant en SSH à votre serveur
2. Naviguant vers le répertoire de données de l'application : `/home/yunohost.app/copilot-api`
3. Exécutant la commande d'authentification : `cd /var/www/copilot-api && sudo -u copilot-api ./.bun/bin/bun run dist/main.js auth`

### Type de compte

Le type de compte par défaut est "individual". Si vous avez un plan GitHub Copilot entreprise ou organisation, vous devez mettre à jour le fichier de service systemd pour utiliser le type de compte approprié.

## Utilisation

### Points de terminaison API

Le serveur expose plusieurs points de terminaison :

#### Points de terminaison compatibles OpenAI
- `POST /v1/chat/completions` - Crée une réponse de modèle
- `GET /v1/models` - Liste les modèles disponibles
- `POST /v1/embeddings` - Crée des embeddings

#### Points de terminaison compatibles Anthropic
- `POST /v1/messages` - Crée une réponse de modèle
- `POST /v1/messages/count_tokens` - Compte les jetons

#### Surveillance de l'utilisation
- `GET /usage` - Obtenir les statistiques d'utilisation
- `GET /token` - Obtenir le jeton actuel

### Tableau de bord d'utilisation

Accédez au tableau de bord d'utilisation en visitant :
`https://ericc-ch.github.io/copilot-api?endpoint=https://votredomaine.com/copilot-api/usage`

Remplacez `votredomaine.com` par votre domaine réel.

## Avertissements importants

> **Avis de sécurité GitHub :**  
> L'utilisation automatisée excessive de Copilot peut déclencher les systèmes de détection d'abus de GitHub. Utilisez de manière responsable pour éviter les restrictions de compte.

> Il s'agit d'un proxy rétro-conçu et n'est pas pris en charge par GitHub. Utilisez à vos propres risques.

## Support

Pour plus d'informations et de documentation, visitez : https://github.com/ericc-ch/copilot-api
