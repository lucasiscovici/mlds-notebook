if [[ -n "$OLD_PS1" ]]; then
	#statements
dkd="$(./confImgRun.sh)"
# echo "DEBUG $dkd"
pdof=\"$(cat ../.mldsEnv | sed -En "/^__.*/p" | sed -En "s/__(.*)/\1/p"  | tr '\n' ' ')\"

#echo make mlds $(echo $dkd | tr -d '"' ) $(echo $pdof | tr -d '"' )    $@
make mlds $(echo $dkd | tr -d '"' ) $(echo $pdof | tr -d '"' )  $@

else

	echo "Fire Env"
fi