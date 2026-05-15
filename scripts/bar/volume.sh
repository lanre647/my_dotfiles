#!/bin/sh

amixer get Master | tail -n1 | awk -F'[][]' '{ print $2 }'
