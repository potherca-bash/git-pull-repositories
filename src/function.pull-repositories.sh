#!/usr/bin/env bash

git_pull_repositories() {

    local iExitCode sRootRepoHead sDirectory

    iExitCode="${EX_OK}"

    if [[ "$#" -lt 1 ]];then
        error 'One parameter expected' "${EX_NOT_ENOUGH_PARAMETERS}"
    else
        validate_directory "${1}"

        local -r sRootDirectory=$(unset CDPATH && cd "${1}" && pwd -P )

        pushd "${sRootDirectory}" > /dev/null
        readonly sRootRepoHead="$(git rev-list --parents HEAD 2> /dev/null | tail -1 || echo '')"
        popd > /dev/null

        for sDirectory in ${sRootDirectory}/*/;do
            git_pull_repository "${sDirectory}" "${sRootRepoHead}" || iExitCode="${EX_ERROR_UPDATING}"
            iResult=$?
            if [[ "${iResult}" != "${EX_OK}" ]];then
                iExitCode="${iResult}"
            fi
        done
    fi

    if [[ "${iExitCode}" != "${EX_OK}" ]];then
        error "Encountered a problem updating repositories" "${iExitCode}"
    fi

    return "${iExitCode}"
}

# EOF
