#!/bin/bash -eu

inventory="$(dirname "$0")/../ansible/inventory.yaml"

octets=""
for i in {1..6}; do
  ip=$(sudo virsh domifaddr "rocky10-k3s-${i}" | awk '$3 == "ipv4" {print $4}')

  if [[ -z "$ip" ]]; then
    echo "error: no ipv4 address found for rocky10-k3s-${i}" >&2
    exit 1
  fi

  ip=${ip%/*}              # strip /24
  octets="$octets ${ip##*.}"  # keep only the last octet
done

awk -v octets="$octets" '
  BEGIN { split(octets, o, " "); n = 1 }
  $1 ~ /^172\.16\.99\.[0-9x]+:$/ && n in o { sub(/[0-9x]+:$/, o[n] ":"); n++ }
  { print }
' "$inventory" > "$inventory.tmp"
mv "$inventory.tmp" "$inventory"
