a=-1
function cherche(){
	lib=$1
	pkg=$2
	shift
	if [[ $lib =="python" ]]; then
		if [[ -z $(_docker run -ti luluisco/mlds-notebook 'pip list --format freeze' | grep ^$2) ]];then
			_docker run -ti luluisco/mlds-notebook 'pip install $@'
		else
			echo  "CD" > "./.tmp/com" 
		fi
	fi
	

}
while true; do
	sleep 1
	d=$(date -r ./.tmp/com +%s)
	if [[ $d -gt $a ]]; then
		a=$d
		d=$(cat ./.tmp/com)
		cmd=$(cut -f1 <<<$d)
		ou=$(cut -f2 <<<$d)
		quoi=$(cut -f3 <<<$d)
		if [[ $cmd == "cherche" ]]; then
			#statements
			cherche $ou $quoi
		fi
	fi
done

