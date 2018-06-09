if [[ -n "$OLD_PS1" ]]; then
	#statements
dkd="$(confImgRun.sh)"
# echo "DEBUG $dkd"
pdof=\"$(cat .mldsEnv | sed -En "/^__.*/p" | sed -En "s/__(.*)/\1/p"  | tr '\n' ' ')\"

echo make -f "$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )/Makefile" mlds 
make mlds -f "$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )/Makefile" mlds $(echo $pdof | tr -d '"' ) $(echo $dkd | tr -d '"' )  "$@"

else

	echo "Fire Env"
fi