#!/bin/bash

if [[ -n "$OLD_PS1"  ]]; then
	./images.sh --filter=reference='mlds_*_env'
fi