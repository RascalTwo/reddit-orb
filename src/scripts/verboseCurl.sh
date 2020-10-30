verboseCurl=$(cat <<'END_HEREDOC'
verboseCurl(){
		: 'First argument is if to display output or not, rest are passed to curl';
		display=$1;
		shift;
		: 'Redirect output to file while outputting HTTP code';
		STATUSCODE=$(curl --silent --output ./output --write-out "%{http_code}" "$@");

		: 'Treat Non-200 as error, output response and return 1';
		if test "$STATUSCODE" -ne 200; then
				echo "HTTP Response ${STATUSCODE}: ";
				cat ./output;
				rm ./output;
				return 1;
		fi;

		: 'Otherwise return 0, but first display and delete if output asked';
		if [ "$display" != "false" ]; then
			cat ./output;
			rm ./output;
		fi;
		return 0;
}
END_HEREDOC
);
echo "$verboseCurl" >> "$BASH_ENV"
