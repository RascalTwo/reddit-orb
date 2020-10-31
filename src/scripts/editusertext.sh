EditUserText() {
    access_token=$(cat access_token.txt);

    # Convert 0/1 booleans to true/false
    [[ "${RETURN_RTJSON}" = "1" ]] && RETURN_RTJSON="true" || RETURN_RTJSON="false";

    verboseCurl false --header "User-Agent: ${REDDIT_USER_AGENT}" --header "Authorization: bearer ${access_token}" --request POST --data "api_type=json&thing_id=${THING_ID}&text=${TEXT}&return_rtjson=${RETURN_RTJSON}" 'https://oauth.reddit.com/api/editusertext'
    errors=$(jq .json.errors < output);
    if [[ "${errors}" = "null" ]] || [[ "${errors}" = "[]" ]]; then
        echo "Thing successfully edited:"
        jq .json.data < output
    else
        echo "Reddit Error: ${errors}";
        return 1;
    fi
}

# Will not run if sourced for bats-core tests.
# View src/tests for more information.
ORB_TEST_ENV="bats-core"
if [ "${0#*$ORB_TEST_ENV}" == "$0" ]; then
    EditUserText
fi
