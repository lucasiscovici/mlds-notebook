if [[ -n "$OLD_PS1" ]]; then
	#statements
dkd=[[ -z $(./_getEnv.sh "BASED") ]] && echo -n "" || echo image=(./_getEnv.sh "BASED") latest=
make mlds $dkd $@

else

	echo "Fire Env"
fi