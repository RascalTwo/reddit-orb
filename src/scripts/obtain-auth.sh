ObtainAuth() {
    verboseCurl false --header "User-Agent: ${REDDIT_USER_AGENT}" --user "${CLIENT_ID}:${CLIENT_SECRET}" --request POST "https://www.reddit.com/api/v1/access_token" --data "grant_type=refresh_token&refresh_token=${REFRESH_TOKEN}";
    error=$(jq .error < output);
    if [[ "${error}" = "null" ]]; then
        jq -r .access_token < output > access_token.txt;
    else
        echo "Reddit Error: ${error}";
        return 1;
    fi
    return 0;
}

# Will not run if sourced for bats-core tests.
# View src/tests for more information.
ORB_TEST_ENV="bats-core"
if [ "${0#*$ORB_TEST_ENV}" == "$0" ]; then
    ObtainAuth
fi
