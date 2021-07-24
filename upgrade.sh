OS="$(uname -a)"

case "$OS" in
	*Darwin*) ;;

	*arch*)
		yay -Syu
		;;
esac

npm -g update
