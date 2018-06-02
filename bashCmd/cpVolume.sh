createCp(){
	tr ';' '\n' <<<"$1" | { av="true"; while read a; do
		first=$(cut -d ':' -f 1 <<<"$a");
		if [[ -n "$first" ]]; then
		deux=$(cut -d ':' -f 2 <<<"$a");
		if [[ -z "$deux" ]]; then
			deux=$first;
		fi
		 av=$av";cp --parents -R \"$first/*\" \"$deux/\"";
		fi
	done 
	echo $av; }
}

if [[ $# -lt 1 ]]; then
	echo "Usage: ./cpVolume.sh nameVolume [createdVol|_(for auto)] [--path=path1erVolume[:pathSecondVolume];]"
else
	echo "Check Vol $1 exist ..."
	if ./_checkVol.sh $1; then
		echo "Check Conf OK ..."
		if ! ./_checkImg.sh "alpine"; then
				echo -e "\tDownload image for conf..."
				_docker pull alpine >/dev/null
		fi
		voln=$1
		# if [[ $# - 1 ]]; then
			f=[[ -n "$2" && "$2" != "_" ]] && "$2" || "custom_$(./_randomString.sh)"
			sdm=[[ -n "$3" &&  ${3:0:6} == "--path"  ]] && createCp ${3:6} || "cp -R /$voln/* /$f/"
			( ./createVolume.sh "$f" >/dev/null 2>&1  && \
			echo "CREATED VOL Name: $f"  && \
			echo "CP VOL $voln to $f"  && \
			_docker run -d --rm --name $f -v $voln:/$voln -v $f:/$f alpine sh -c "cp -R /$voln/* /$f/" >/dev/null 2>&1   && \
			echo "OK" ) || \ 
			 ( echo "DELETE VOL" && ./rmVolume.sh "$f"  && _docker stop $f >/dev/null ) >/dev/null 2>&1 
		# else

		# fi

	else
		echo "Volume $1 n'existe pas"
	fi

fi