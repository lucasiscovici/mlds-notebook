if [[ -n "$OLD_PS1" ]]; then
	#statements
dkg=""
dkd=\"$([[ -z "$(./myEnv.sh getIm)" ]] && echo -n $dkg || echo image=$(./myEnv.sh getEnvIm) latest=)\"
echo "DEBUG $dkd"
dkd=\"$([[ -z "$(./_getEnv.sh BASED)" ]] && echo -n $dkd  || echo image=$(./_getEnv.sh BASED) latest=)\"
echo "DEBUG $dkd"
pdof=$(cat ../.mldsEnv | sed -En "/^__.*/p" | sed -En "s/__(.*)/\1/p" | tr ':' '=' | tr '\n' ' ')

echo make mlds $(echo $dkd | tr -d '"' ) $pdof  $@
make mlds $dkd $pdof  $@

else

	echo "Fire Env"
fi