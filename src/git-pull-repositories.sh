#!/usr/bin/env bash

# Copyright (C) 2017  Potherca <potherca@gmail.com>
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

set -o errexit  # Exit script when a command exits with non-zero status.
set -o errtrace # Exit on error inside any functions or sub-shells.
set -o nounset  # Exit script on use of an undefined variable.
set -o pipefail # Return exit status of the last command in the pipe that exited with a non-zero exit code

source 'color.inc'
source 'exit-codes.inc'
source 'function.error.sh'
source 'function.validate-directory.sh'
source 'function.pull-repository.sh'
source 'function.pull-repositories.sh'

if [[ ${BASH_SOURCE[0]} != $0 ]]; then
    export -f git_pull_repositories
else
     git_pull_repositories "${@:-}"
    exit ${?}
fi

# EOF
