if [[ -n "$OLD_PS1" ]]; then
	#statements
dkg="$(./confImgRun.sh)"
# echo "DEBUG $dkd"
pdof=\"$(cat ../.mldsEnv | sed -En "/^__.*/p" | sed -En "s/__(.*)/\1/p" | tr ':' '=' | tr '\n' ' ')\"

# echo make mlds $(echo $dkd | tr -d '"' ) $pdof  $@
make mlds $(echo $dkd | tr -d '"' ) $(echo $pdof | tr -d '"' )  $@

else

	echo "Fire Env"
fi