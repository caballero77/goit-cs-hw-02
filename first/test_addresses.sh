#!/bin/bash
cd "$(dirname "$0")"
IFS=$'\n'

output='website_status.log'
input='addresses.txt'


read_addresses() {
    addresses=($(cat "$input"))
}

curl_address() {
    $(curl -L $1 > /dev/null 2>&1)
    result="$?"
}

format_output() {
    if [ $2 -eq 0 ]; then
        result="<$1> is UP"
    else
        result="<$1> is DOWN"
    fi
}

read_addresses

touch "$output"
> "$output"

for i in "${!addresses[@]}"; do
    address="${addresses[$i]}"
    curl_address "$address"
    format_output "$address" "$result"
    echo "$result"
    echo "$result" >> "$output"
done

echo "Results was also saved in log file: $output"