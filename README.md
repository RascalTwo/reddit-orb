# Reddit Orb

[![CircleCI Build Status](https://circleci.com/gh/RascalTwo/reddit-orb.svg?style=shield "CircleCI Build Status")](https://circleci.com/gh/RascalTwo/reddit-orb) [![CircleCI Orb Version](https://img.shields.io/badge/endpoint.svg?url=https://badges.circleci.io/orb/rascaltwo/reddit-orb)](https://circleci.com/orbs/registry/orb/rascaltwo/reddit-orb) [![GitHub License](https://img.shields.io/badge/license-MIT-lightgrey.svg)](https://raw.githubusercontent.com/RascalTwo/reddit-orb/master/LICENSE) [![CircleCI Community](https://img.shields.io/badge/community-CircleCI%20Discuss-343434.svg)](https://discuss.circleci.com/c/ecosystem/orbs)

Allows interaction with the [Reddit API](https://www.reddit.com/dev/api/).

> Depends on [`dropbox-orb`](https://circleci.com/developer/orbs/orb/rascaltwo/dropbox-orb) to store OAuth authentication information.

There are a number of required enviroment variables:

- `DROPBOX_TOKEN`
  - Token for dropbox authentication
  - This is required for `dropbox-orb`

- `REDDIT_USER_AGENT`
  - The user agent to make requests to the Reddit API with
- `CLIENT_ID`
  - ID of a Reddit personnal use script
- `CLIENT_SECRET`
  - Secret of the same Reddit personnal use script

***

Additionally, you must obtain minimum an access and refresh token for your script.

This can be done by using [`reddit-oauth-helper`](https://github.com/not-an-aardvark/reddit-oauth-helper).

After using it, you will be presented with JSON object like this:

```json
{
  "access_token": "access-token-string",
  "token_type": "bearer",
  "expires_in": 3600,
  "refresh_token": "refresh-token-string",
  "scope": "string"
}
```

You must take this, and create a file like this:

```text
access-token-string refresh-token-string 0 0
```

then take this file and upload it to your dropbox, at a location accessible to `dropbox-orb`.

***

With this file in your Dropbox, and you running the `reddit-orb/obtain-auth` with a `credentialspath` of this filepath, you are now ready to run the other commands.

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

