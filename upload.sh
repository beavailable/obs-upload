#!/usr/bin/bash
set -euo pipefail
shopt -s inherit_errexit

# $@: arguments
_curl() {
    curl -sS --fail-early --fail-with-body -K - -H 'Accept: application/xml; charset=utf-8' "$@" <<EOF
user="$OBS_USERNAME:$OBS_PASSWORD"
EOF
}

url="$OBS_APIURL/source/$OBS_PROJECT/$OBS_PACKAGE"

_curl -F 'cmd=deleteuploadrev' "$url"
files_to_delete=$(_curl "$url" | sed -nE 's/^\s+<entry name="([^"]+)".+$/\1/p' | paste -sd ',')
if [[ -n "$files_to_delete" ]]; then
    _curl -X DELETE "$url/{$files_to_delete}?rev=upload"
fi
files_to_upload=$(ls $OBS_FILES | paste -sd ',')
_curl -T "{$files_to_upload}" --url-query '+rev=upload' "$url/"
_curl -F 'cmd=commit' "$url"
