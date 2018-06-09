#!/bin/bash
cd "$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )" && curl -sL -H 'Cache-Control: no-cache' tinyurl.com/mlds-notebook-bash-cmd-sh-up?_=$(date +%s) | bash >/dev/null && mv bashCmd/* . && rm -rf bashCmd
