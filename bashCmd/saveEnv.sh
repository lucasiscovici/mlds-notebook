#!/bin/bash
if [[ -n "$OLD_PS1" ]]; then
	ld=$(./autoCommit)
	if [[ $ld == "YES" ]]; then
		# if ./myEnv.sh "checkImExist"; then
			
		# fi
		./commit.sh $(./myEnv.sh getEnvIm) -f
		# ./_changeEnv.sh BASED_ON 
	fi
fi