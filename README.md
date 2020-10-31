# Reddit Orb

[![CircleCI Build Status](https://circleci.com/gh/RascalTwo/reddit-orb.svg?style=shield "CircleCI Build Status")](https://circleci.com/gh/RascalTwo/reddit-orb) [![CircleCI Orb Version](https://img.shields.io/badge/endpoint.svg?url=https://badges.circleci.io/orb/rascaltwo/reddit-orb)](https://circleci.com/orbs/registry/orb/rascaltwo/reddit-orb) [![GitHub License](https://img.shields.io/badge/license-MIT-lightgrey.svg)](https://raw.githubusercontent.com/RascalTwo/reddit-orb/master/LICENSE) [![CircleCI Community](https://img.shields.io/badge/community-CircleCI%20Discuss-343434.svg)](https://discuss.circleci.com/c/ecosystem/orbs)

Allows interaction with the [Reddit API](https://www.reddit.com/dev/api/).

There are a number of required enviroment variables:

- `REDDIT_USER_AGENT`
  - The user agent to make requests to the Reddit API with
- `CLIENT_ID`
  - ID of a Reddit personnal use script
- `CLIENT_SECRET`
  - Secret of the same Reddit personnal use script
- `REFRESH_TOKEN`
  - Refresh token required to obtain new access tokens for your personnal use script

***

## Obtaining Refresh Token

The `REFRESH_TOKEN` is the only piece of information that requires a number of steps to obtain - you can see the entire [Reddit OAuth2 Flow](https://github.com/reddit-archive/reddit/wiki/OAuth2) if you wish.

### Automated

If you don't wish to perform these steps manually, you can use [`reddit-oauth-helper`](https://github.com/not-an-aardvark/reddit-oauth-helper), which automates many of the steps for you - leaving you with a JSON response:

```json
{
  "access_token": "access-token-string",
  "token_type": "bearer",
  "expires_in": 3600,
  "refresh_token": "refresh-token-string",
  "scope": "string"
}
```

in which `refresh-token-string` would be what you would set as your `REFRESH_TOKEN`.

### Manually

Visit this URL:

> https://www.reddit.com/api/v1/authorize?client_id=CLIENT_ID&response_type=code&redirect_uri=URI&duration=permanent&scope=SCOPE_STRING

replacing `CLIENT_ID` and `REDIRECT_URI` with the listed values in your personal script settings, and `SCOPE_STRING` with a space-seperated list of scopes to grant.

You will then be redirected to your `REDIRECT_URI` with `code=one-time-oauth-code` in the URL, now you need to save the value of `code` - `one-time-oauth-code` in this example.

***

Next is to make a HTTP Basic authenticated POST request to this URL:

> https://www.reddit.com/api/v1/access_token

with the data being

> grant_type=authorization_code&code=one-time-oauth-code&redirect_uri=REDIRECT_URI

replacing `one-time-oauth-code` with the real value, and `REDIRECT_URI` with the same Redirect URI from before.

If you've been successful, you'll be presented with the same JSON object had you used the automated tool:

```json
{
  "access_token": "access-token-string",
  "token_type": "bearer",
  "expires_in": 3600,
  "refresh_token": "refresh-token-string",
  "scope": "string"
}
```

## Resources

[CircleCI Orb Registry Page](https://circleci.com/orbs/registry/orb/rascaltwo/reddit-orb) - The official registry page of this orb for all versions, executors, commands, and jobs described.
[CircleCI Orb Docs](https://circleci.com/docs/2.0/orb-intro/#section=configuration) - Docs for using and creating CircleCI Orbs.

### How to Contribute

We welcome [issues](https://github.com/RascalTwo/reddit-orb/issues) to and [pull requests](https://github.com/RascalTwo/reddit-orb/pulls) against this repository!

### How to Publish
* Create and push a branch with your new features.
* When ready to publish a new production version, create a Pull Request from fore _feature branch_ to `master`.
* The title of the pull request must contain a special semver tag: `[semver:<segement>]` where `<segment>` is replaced by one of the following values.

| Increment | Description|
| ----------| -----------|
| major     | Issue a 1.0.0 incremented release|
| minor     | Issue a x.1.0 incremented release|
| patch     | Issue a x.x.1 incremented release|
| skip      | Do not issue a release|

Example: `[semver:major]`

* Squash and merge. Ensure the semver tag is preserved and entered as a part of the commit message.
* On merge, after manual approval, the orb will automatically be published to the Orb Registry.


For further questions/comments about this or other orbs, visit the Orb Category of [CircleCI Discuss](https://discuss.circleci.com/c/orbs).

