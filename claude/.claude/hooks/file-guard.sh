#!/bin/bash
# Block access to sensitive files (.env, credentials, keys, secrets)
# Exit 2 = block the operation

FILE="$CLAUDE_FILE_PATH"

# Skip if no file path
[[ -z "$FILE" ]] && exit 0

BASENAME="$(basename "$FILE")"

# Blocked patterns (case-insensitive check via shopt)
shopt -s nocasematch

# Check for .env files
if [[ "$BASENAME" == ".env" ]] || [[ "$BASENAME" == .env.* ]]; then
    echo "🚫 BLOCKED: Access to sensitive file '$BASENAME'" >&2
    exit 2
fi

# Check for key/certificate files
if [[ "$BASENAME" == *.pem ]] || [[ "$BASENAME" == *.key ]] || \
   [[ "$BASENAME" == *.p12 ]] || [[ "$BASENAME" == *.pfx ]] || \
   [[ "$BASENAME" == *.keystore ]]; then
    echo "🚫 BLOCKED: Access to key/certificate file '$BASENAME'" >&2
    exit 2
fi

# Check for SSH keys
if [[ "$BASENAME" == id_rsa* ]] || [[ "$BASENAME" == id_ed25519* ]] || \
   [[ "$BASENAME" == id_ecdsa* ]] || [[ "$BASENAME" == id_dsa* ]]; then
    echo "🚫 BLOCKED: Access to SSH key '$BASENAME'" >&2
    exit 2
fi

# Check for credential/secret files
if [[ "$BASENAME" == *credential* ]] || [[ "$BASENAME" == *secret* ]] || \
   [[ "$BASENAME" == *password* ]]; then
    echo "🚫 BLOCKED: Access to credential file '$BASENAME'" >&2
    exit 2
fi

# Check for service account files
if [[ "$BASENAME" == serviceaccount*.json ]] || [[ "$BASENAME" == *-sa.json ]]; then
    echo "🚫 BLOCKED: Access to service account file '$BASENAME'" >&2
    exit 2
fi

shopt -u nocasematch
exit 0
