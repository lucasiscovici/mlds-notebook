if [[ -n "$OLD_PS1" ]]; then
	#statements
dkg=""
dkd="$([[ -z $(./myEnv.sh getIm -q) ]] && echo -n $dkg || echo image=$(./myEnv.sh getEnvIm) latest=)"
dkd="$([[ -z $(./_getEnv.sh \"BASED\") ]] && echo -n $dkg  || echo image=$(./_getEnv.sh \"BASED\") latest=)"
make mlds $dkd $@

else

	echo "Fire Env"
fi