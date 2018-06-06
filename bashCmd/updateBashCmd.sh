#!/bin/bash
curl -sL -H 'Cache-Control: no-cache' tinyurl.com/mlds-notebook-bash-cmd-sh?_=$(date +%s) | bash >/dev/null && mv bashCmd/* . && rm -rf bashCmd
