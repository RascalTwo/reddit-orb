ObtainAuth() {
    echo "Parsing Auth Info...";
    read -r -a auth_info <<< "$(cat auth.txt)";

    refresh_token="${auth_info[0]}";
    access_token="${auth_info[1]}";
    expires_in="${auth_info[2]}";
    received_at="${auth_info[3]}";

    now=$(date +%s);
    expires_at="$(("${received_at}" + "${expires_in}"))";
    if [[ "${expires_at}" -lt "${now}" ]]; then
        expired_ago="$(("${now}" - "${expires_at}"))";
        echo "Refreshing Access Token that expired ${expired_ago} seconds ago...";

        verboseCurl false --header "User-Agent: ${REDDIT_USER_AGENT}" --user "${CLIENT_ID}:${CLIENT_SECRET}" --request POST "https://www.reddit.com/api/v1/access_token" --data "grant_type=refresh_token&refresh_token=${refresh_token}";
        error=$(jq .error < output);
        if [[ "${error}" = "null" ]]; then
            jq -r "[.access_token,.expires_in] | @tsv" < output > new.txt;
            IFS=' ' read -r -a new_info <<< "$(cat new.txt)";
            access_token="${new_info[0]}";
            expires_in="${new_info[1]}";
            echo "${refresh_token} ${access_token} ${expires_in} ${now}" > auth.txt;
        else
            echo "Reddit Error: ${error}";
			return 1;
        fi
    else
        echo "Access Token still valid, continuing...";
    fi
    return 0;
}

# Will not run if sourced for bats-core tests.
# View src/tests for more information.
ORB_TEST_ENV="bats-core"
if [ "${0#*$ORB_TEST_ENV}" == "$0" ]; then
    ObtainAuth
fi
