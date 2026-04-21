#!/bin/bash
# Common functions for Yandex Wordstat API

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CONFIG_FILE="$SCRIPT_DIR/../config/.env"
CACHE_DIR="$SCRIPT_DIR/../cache"
API_URL="https://api.direct.yandex.com/json/v5/"

load_config() {
    if [[ -f "$CONFIG_FILE" ]]; then
        # shellcheck disable=SC1090
        source "$CONFIG_FILE"
    fi

    if [[ -z "$YANDEX_WORDSTAT_TOKEN" ]]; then
        echo "Error: YANDEX_WORDSTAT_TOKEN not found."
        echo "Set in config/.env or environment. See config/README.md for instructions."
        exit 1
    fi
}

api_request() {
    local method="$1"
    local params="$2"

    local payload
    if [[ -n "$params" ]]; then
        payload="{\"method\":\"$method\",\"params\":$params}"
    else
        payload="{\"method\":\"$method\"}"
    fi

    curl -s -X POST "$API_URL" \
        -H "Authorization: Bearer $YANDEX_WORDSTAT_TOKEN" \
        -H "Content-Type: application/json; charset=utf-8" \
        -H "Accept-Language: ru" \
        -d "$payload"
}

wordstat_request() {
    local method="$1"
    local params="$2"

    local ws_url="https://api.wordstat.yandex.net/v1/$method"

    curl -s -X POST "$ws_url" \
        -H "Authorization: Bearer $YANDEX_WORDSTAT_TOKEN" \
        -H "Content-Type: application/json; charset=utf-8" \
        -d "$params"
}

json_value() {
    local json="$1"
    local key="$2"
    echo "$json" | grep -o "\"$key\":[^,}]*" | head -1 | sed 's/.*://' | tr -d '"[:space:]'
}

json_string() {
    local json="$1"
    local key="$2"
    echo "$json" | grep -o "\"$key\":\"[^\"]*\"" | head -1 | sed 's/.*:"//' | tr -d '"'
}

json_array() {
    local json="$1"
    local key="$2"
    echo "$json" | grep -o "\"$key\":\[[^]]*\]" | head -1 | sed 's/.*:\[/[/'
}

wait_for_report() {
    local report_id="$1"
    local get_method="$2"
    local max_attempts="${3:-30}"
    local attempt=0

    while [[ $attempt -lt $max_attempts ]]; do
        local response
        response=$(wordstat_request "$get_method" "$report_id")

        if echo "$response" | grep -q '"data":\['; then
            echo "$response"
            return 0
        fi

        if echo "$response" | grep -q '"error"'; then
            echo "$response"
            return 1
        fi

        echo "Waiting for report... ($((attempt + 1))/$max_attempts)" >&2
        sleep 2
        attempt=$((attempt + 1))
    done

    echo "Error: Timeout waiting for report" >&2
    return 1
}

json_escape() {
    local str="$1"
    str="${str//\\/\\\\}"
    str="${str//\"/\\\"}"
    str="${str//$'\n'/\\n}"
    str="${str//$'\t'/\\t}"
    echo "$str"
}

format_number() {
    local num="$1"
    printf "%'d" "$num" 2>/dev/null || echo "$num"
}
