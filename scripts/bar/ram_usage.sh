#!/bin/sh

free | awk '/Mem:/ {
    printf "%.1f/%.1fG", $3/1024/1024, $2/1024/1024
}'
