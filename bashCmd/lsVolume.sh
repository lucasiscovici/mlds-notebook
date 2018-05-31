if [[ $# -lt 1 ]]; then
	echo "USage: lsVolume.sh vol_name [path] [...]"
else
	vol=${1}
	path=${2:-/}
	shift
	shift
	opts=$@
	docker run -it --rm -v $vol:/vol alpine ls ${opts} /vol$path
fi