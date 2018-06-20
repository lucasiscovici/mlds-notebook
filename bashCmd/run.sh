if [[ -n "$OLD_PS1" ]]; then
	#statements
dkd="$(confImgRun.sh)"
# echo "DEBUG $dkd"
pdof=\"$(cat .mldsEnv | sed -En "/^__.*/p" | sed -En "s/__(.*)/\1/p"  | tr '\n' ' ')\"

echo make -f "$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )/Makefile" mlds $(echo $pdof | tr -d '"' ) $(echo $dkd | tr -d '"' )  "$@" 
# make mlds -f "$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )/Makefile" mlds $(echo $pdof | tr -d '"' ) $(echo $dkd | tr -d '"' )  "$@"
echo make mlds -f "$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )/Makefile" mlds $(echo $pdof | tr -d '"' ) $(echo $dkd | tr -d '"' )  "$@" | bash 

else

	echo "Fire Env"
fi