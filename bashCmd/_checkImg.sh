exit $(images.sh --format="{{.Repository}}" | grep -q "$1")