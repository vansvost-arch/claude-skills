# Yandex Wordstat API Token Setup

The API has been **free since June 2025**, with limits of 1,000 requests/day and 10 requests/second.

## Key Steps

1. **Request access** at https://yandex.ru/support2/wordstat/ru/content/api-wordstat — submit the form at the bottom and await approval (typically within a day)

2. **Create OAuth app** at https://oauth.yandex.ru/client/new
   - Name: any
   - Platform: Web services
   - Callback URL: https://oauth.yandex.ru/verification_code

3. **Get OAuth token** by visiting the authorization URL with your client ID:
   ```
   https://oauth.yandex.ru/authorize?response_type=token&client_id=YOUR_CLIENT_ID
   ```
   After login, grab the `access_token` value from the redirect URL.

   Or use the helper script:
   ```bash
   bash scripts/get_token.sh --client-id YOUR_CLIENT_ID
   ```

4. **Configure** by placing your token in `config/.env`:
   ```
   YANDEX_WORDSTAT_TOKEN=your_token_here
   ```

5. **Verify** by running:
   ```bash
   bash scripts/quota.sh
   ```
   Success shows `"Wordstat API: OK"`

## Troubleshooting

- **Error code 53**: Either the form wasn't submitted, the token expired, or a mismatched `client_id` was used
- **Methods unavailable**: Access approval is still pending from Yandex

## Token Lifespan

Tokens remain valid for **one year**, after which you repeat the same authorization process.
