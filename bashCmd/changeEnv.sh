if [[ -n "$OLD_PS1" && $# -ge 1 ]]; then
	curr=""
if ./_check.sh "$1"; then
	curr="*"
fi
export PS1="MLDS-NB-C-CURR->$1$curr):\W\$ " ;
export MLDS_C_CURR="$1" ;
fi