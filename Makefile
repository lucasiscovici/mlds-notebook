arg=$1
arg2=$1
c=${arg:-custom}
w=${arg2:-work}

define getP
	p=$(2)
	np=$(1)
	while [[ nc -z 0.0.0.0 $np && $np -le $p ]]; do
    	np=$((np+1))
    done
    if [[ $np -eq $p ]];then
    	echo "BUG PB PLUS DE PORT DISPO"
    else
    	echo $np
    fi
endef


mlds: 
	cat <<-'EOF' 
	docker run  -d \
				--rm \
				-v $c:/home/mlds/.custom \
				-v $PWD/$w:/home/mlds/work
				-p $(getP 8888 8898):8888 \
				-p $(getP 6006 6016):6006 \
				-p $(getP 54321 54331):54321 \
				-p $(getP 4040 4050):4040 \
				luluisco/mlds-notebook \
				start-notebook.sh \
				--NotebookApp.token=\"mlds\" \
'EOF'	