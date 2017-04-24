#!/usr/bin/env bash

error() {
    echo -e "${COLOR_RED}ERROR${COLOR_RESET} ${1}\n" >&2
    exit "${2}"
}

# EOF
