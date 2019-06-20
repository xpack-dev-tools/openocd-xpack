# How to publish the xPack OpenOCD?

## Build

Before starting the build, perform some checks.

### Check the CHANGELOG file

Open the `CHANGELOG.md` file and and check if all 
new entries are in.

Generally, apart from packing, there should be no local changes compared 
to the original OpenOCD distribution.

Note: if you missed to update the `CHANGELOG.md` before starting the build, 
edit the file and rerun the build, it should take only a few minutes to 
recreate the archives with the correct file.

### Check the version

The `VERSION` file should refer to the actual release.

### Push the build script git

In the `xpack-dev-tools/openocd-project` Git repo:

- if necessary, merge the `xpack-develop` branch into `xpack`.
- push it to GitHub.
- possibly push the helper project too.

### Run the build scripts

When everything is ready, follow the instructions in the 
[build](https://github.com/xpack-dev-tools/openocd-xpack/blob/xpack/README-BUILD.md) 
page.

## Test

Install the binaries on all supported platforms and check if they are 
functional.

## Create a new GitHub release

- go to the [GitHub Releases](https://github.com/xpack-dev-tools/openocd-xpack/releases) page
- click the **Draft a new release** button
- name the tag like **v0.10.0-12** (mind the dash in the middle!)
- select the `xpack` branch
- name the release like **xPack OpenOCD v0.10.0-12** 
(mind the dash)
- as description
  - add a downloads badge like `[![Github Releases (by Release)](https://img.shields.io/github/downloads/xpack-dev-tools/openocd-xpack/v0.10.0-12/total.svg)](https://github.com/xpack-dev-tools/openocd-xpack/releases/tag/v0.10.0-12/)`;
  - draft a short paragraph explaining what are the main changes
  - if any, close [GitHub Issues](https://github.com/xpack-dev-tools/openocd-xpack/issues) 
  on the way. Refer to them as:
    - **[Issue:\[#1\]\(...\)]**.
  - copy/paste the build report at the end of the post as:
```console
## Checksums
The SHA-256 hashes for the files are:

0d41f0f4c90a464701307735f7faddda7ceae2079654d3f323bfd7ec76933864 
xpack-openocd-0.10.0-12-darwin-x64.tgz

c71a95247a8b0bfffb6258c533666f9603d3973f68b173dce18bb07c0f425d7e 
xpack-openocd-0.10.0-12-linux-x32.tgz

c143c7481821342ecf82d2b22798d4b3df91a77e62d43265b12ce1b895953754 
xpack-openocd-0.10.0-12-linux-x64.tgz

47eae950068eeb8ab42948de3bca0dc01dfa93f6b2f163c7ee45bfba2aefba16 
xpack-openocd-0.10.0-12-win32-x32.zip

be0aab5e86e6f1653cf04472d81a1300b52c698290fe44cc6f0619e189dcee1e 
xpack-openocd-0.10.0-12-win32-x64.zip
```

If you missed this, `cat` the content of the `.sha` files:

```console
$ cd deploy
$ cat *.sha
```

- **attach binaries** and SHA (drag and drop will do it)
- do not enable the **Pre-release** button
- click the **Publish Release** button

Note: at this moment the system should send a notification to all clients watching this project.

## Prepare a new blog post 

In the `xpack/xpack.github.io` web Git:

- add a new file to `_posts/releases/openocd`
- name the file like `2019-06-20-openocd-v0-10-0-12-released.md`
- name the post like: **xPack OpenOCD v0.10.0-12 released**
- as `download_url` use the tagged URL `https://github.com/xpack-dev-tools/openocd-xpack/releases/tag/v0.10.0-12/` 
- update the `last_update:` field with the current date in ISO format
- commit the project; use a message 
  like **xPack OpenOCD v0.10.0-12 released**
- push the project
- wait a few moments for the Jekyll build to complete
- check if the new post is published at [`xpack.github.io/xpack/news`](https://xpack.github.io/xpack/news/)

## Publish on the npmjs server

- open [GitHub Releases](https://github.com/xpack-dev-tools/openocd-xpack/releases) 
  and select the latest release
- update the `baseUrl:` with the file URLs (including the tag/version)
- from the release, copy the SHA & file names
- commit all changes, use a message like `package.json: update urls for 0.10.0-12 release` (without `v`)
- update `CHANGELOG.md`; commit with a message like 
  _CHANGELOG: prepare npm v0.10.0-12.1_
- `npm version 0.10.0-12.1`; the first 4 numbers are the same as the 
  GitHub release; the fifth number is the npm specific version
- push all changes to GitHub
- `npm publish` (use `--access public` when publishing for the first time)

## Share on Twitter

- in a separate browser windows, open [TweetDeck](https://tweetdeck.twitter.com/)
- using the `@xpack_project` account
- paste the release name like **xPack OpenOCD v0.10.0-12 released**
- paste the link to the Github release
- click the **Tweet** button

