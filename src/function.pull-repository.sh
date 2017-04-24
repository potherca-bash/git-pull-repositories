#!/usr/bin/env bash

git_pull_repository() {

    local iExitCode sDirectory sRootRepoHead

    iExitCode="${EX_OK}"
    validate_directory "${1}"

    local -r sDirectory=$(unset CDPATH && cd "${1}"/ && pwd -P )
    local -r sRootRepoHead="${2:-}"

    pushd "${sDirectory}" > /dev/null

    sRepo=$(basename "${sDirectory}")
    sRepoHead="$(git rev-list --parents HEAD 2> /dev/null | tail -1 || echo '')"

    if [[ "${sRootRepoHead}" = "${sRepoHead}" || "${sRepoHead}" = "" ]];then
        sBranch="${COLOR_DIM}(not a git repo)${COLOR_RESET}"
            printf ' ======> Not updating %s branch of "%s" %s\n' "${COLOR_YELLOW}${sBranch}${COLOR_RESET}" "${sRepo}" "${sBranch}" "${COLOR_DIM}(not on master)${COLOR_RESET}"
    else
        sBranch=$(git symbolic-ref --quiet --short -q HEAD 2>/dev/null)

        if [[ "${sBranch}" = 'master' ]];then
            printf ' ======> Updating %s branch of "%s"\n' "${COLOR_GREEN}${sBranch}${COLOR_RESET}" "${sRepo}"
            git pull --ff-only origin "${sBranch}" || { printf ' ! ERROR Failed updating %s of "%s"\n\n' "${sBranch}" "${sRepo}" && iExitCode="${EX_ERROR_UPDATING}"; }
        else
            printf ' ======> Not updating %s branch of "%s" %s\n' "${COLOR_YELLOW}${sBranch}${COLOR_RESET}" "${sRepo}" "${sBranch}" "${COLOR_DIM}(not on master)${COLOR_RESET}"
        fi
    fi

    popd > /dev/null

    return "${iExitCode}"
}

# EOF
