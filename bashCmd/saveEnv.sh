#!/bin/bash
if [[ -n "$OLD_PS1" ]]; then
	ld=$(./autoCommit.sh)
	if [[ $ld == "YES" ]]; then
		# if ./myEnv.sh "checkImExist"; then
			
		# fi
		echo "COMMIT...."
		./commit.sh $(./myEnv.sh getEnvIm) -f
		echo "OK"
		# ./_changeEnv.sh BASED_ON 
	fi
fi