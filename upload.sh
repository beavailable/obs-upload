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
files=$(_curl "$url" | sed -nE 's/^\s+<entry name="([^"]+)".+$/\1/p' | paste -sd ',')
if [[ -n "$files" ]]; then
    _curl -X DELETE "$url/{$files}?rev=upload"
fi
for f in $OBS_FILES; do
    _curl -T "$f" "$url/${f#*/}?rev=upload"
done
_curl -F 'cmd=commit' "$url"
