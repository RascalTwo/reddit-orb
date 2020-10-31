Submit() {
    access_token=$(cat access_token.txt);

    # Optional string values
    [[ -n "${TEXT}" ]] && TEXT="&text=${TEXT}" || TEXT="";
    [[ -n "${FLAIR_ID}" ]] && FLAIR_ID="&flair_id=${FLAIR_ID}" || FLAIR_ID="";
    [[ -n "${FLAIR_TEXT}" ]] && FLAIR_TEXT="&flair_text=${FLAIR_TEXT}" || FLAIR_TEXT="";
    [[ -n "${URL}" ]] && url="&url=${URL}" || url="";
    [[ -n "${VIDEO_POSTER_URL}" ]] && VIDEO_POSTER_URL="&video_poster_url=${VIDEO_POSTER_URL}" || VIDEO_POSTER_URL="";

    # Convert 0/1 booleans to true/false
    [[ "${NSFW}" = "1" ]] && NSFW="true" || NSFW="false";
    [[ "${SPOILER}" = "1" ]] && SPOILER="true" || SPOILER="false";
    [[ "${RESUBMIT}" = "1" ]] && RESUBMIT="true" || RESUBMIT="false";
    [[ "${SENDREPLIES}" = "1" ]] && SENDREPLIES="true" || SENDREPLIES="false";

    verboseCurl false --header "User-Agent: ${REDDIT_USER_AGENT}" --header "Authorization: bearer ${access_token}" --request POST --data "api_type=json&kind=${KIND}&sr=${SUBREDDIT}&title=${TITLE}&nsfw=${NSFW}&spoiler=${SPOILER}&resubmit=${RESUBMIT}&sendreplies=${SENDREPLIES}${TEXT}${FLAIR_ID}${FLAIR_TEXT}${url}${VIDEO_POSTER_URL}" 'https://oauth.reddit.com/api/submit'
    errors=$(jq .json.errors < output);
    if [[ "${errors}" = "null" ]] || [[ "${errors}" = "[]" ]]; then
        echo "Submission successfully made:"
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
    Submit
fi
