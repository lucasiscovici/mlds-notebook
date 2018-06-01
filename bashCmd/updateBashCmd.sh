#!/bin/bash
curl -sL tinyurl.com/mlds-notebook-bash-cmd-sh?_=$(date +%s) | bash >/dev/null && mv bashCmd/* .
