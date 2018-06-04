#!/bin/bash
if [[ -n "$OLD_PS1" ]]; then
	echo "$MLDS_C_CURR" > ../.mldsEnv
	echo "Env Save"
fi