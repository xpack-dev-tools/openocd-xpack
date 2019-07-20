# How to publish the xPack OpenOCD?

## Build

Before starting the build, perform some checks.

### Check the `CHANGELOG.md` file

Open the `CHANGELOG.md` file and and check if all 
new entries are in.

Generally, apart from packing, there should be no local changes compared 
to the original OpenOCD distribution.

Note: if you missed to update the `CHANGELOG.md` before starting the build, 
edit the file and rerun the build, it should take only a few minutes to 
recreate the archives with the correct file.

### Check the version

The `VERSION` file should refer to the actual release.

### Push the build script

In this Git repo:

- if necessary, merge the `xpack-develop` branch into `xpack`.
- push it to GitHub.
- possibly push the helper project too.

### Run the build scripts

When everything is ready, follow the instructions in the 
[build](https://github.com/xpack-dev-tools/openocd-xpack/blob/xpack/README-BUILD.md) 
page.

## Test

Install the binaries on all supported platforms and check if they are 
functional, using the Eclipse STM32F4DISCOVERY blinky test and the
`-f "board/stm32f4discovery.cfg"` configuration file.

## Create a new GitHub pre-release

- go to the [GitHub Releases](https://github.com/xpack-dev-tools/openocd-xpack/releases) page
- click the **Draft a new release** button
- name the tag like **v0.10.0-13** (mind the dash in the middle!)
- select the `xpack` branch
- name the release like **xPack OpenOCD v0.10.0-13** (mind the dash)
- as description
  - add a downloads badge like `![Github Releases (by Release)](https://img.shields.io/github/downloads/xpack-dev-tools/openocd-xpack/v0.10.0-13/total.svg)`;
  - draft a short paragraph explaining what are the main changes
- **attach binaries** and SHA (drag and drop from the archives folder will do it)
- **enable** the **pre-release** button
- click the **Publish Release** button

Note: at this moment the system should send a notification to all clients watching this project.

## Prepare a new blog post 

In the `xpack.github.io` web Git:

- add a new file to `_posts/openocd/releases`
- name the file like `2019-07-17-openocd-v0-10-0-13-released.md`
- name the post like: **xPack OpenOCD v0.10.0-13 released**.
- as `download_url` use the tagged URL like `https://github.com/xpack-dev-tools/openocd-xpack/releases/tag/v0.10.0-13/` 
- update the `date:` field with the current date

If any, close 
[build issues](https://github.com/xpack-dev-tools/openocd-xpack/issues) 
on the way. Refer to them as:

- **[Issue:\[#1\]\(...\)]**.


## Update the SHA sums

Copy/paste the build report at the end of the post as:

```console

## Checksums
The SHA-256 hashes for the files are:

0d41f0f4c90a464701307735f7faddda7ceae2079654d3f323bfd7ec76933864 
xpack-openocd-0.10.0-13-darwin-x64.tgz

c71a95247a8b0bfffb6258c533666f9603d3973f68b173dce18bb07c0f425d7e 
xpack-openocd-0.10.0-13-linux-x32.tgz

c143c7481821342ecf82d2b22798d4b3df91a77e62d43265b12ce1b895953754 
xpack-openocd-0.10.0-13-linux-x64.tgz

47eae950068eeb8ab42948de3bca0dc01dfa93f6b2f163c7ee45bfba2aefba16 
xpack-openocd-0.10.0-13-win32-x32.zip

be0aab5e86e6f1653cf04472d81a1300b52c698290fe44cc6f0619e189dcee1e 
xpack-openocd-0.10.0-13-win32-x64.zip
```

If you missed this, `cat` the content of the `.sha` files:

```console
$ cd deploy
$ cat *.sha
```

## Update the Web

- commit the `xpack.github.io` project; use a message 
  like **xPack OpenOCD v0.10.0-13 released**
- wait for the GitHub Pages build to complete
- remember the post URL, since it must be updated in the release page

## Publish on the npmjs server

- open [GitHub Releases](https://github.com/xpack-dev-tools/openocd-xpack/releases) 
  and select the latest release
- update the `baseUrl:` with the file URLs (including the tag/version)
- from the web release, copy the SHA & file names
- commit all changes, use a message like 
  `package.json: update urls for 0.10.0-13 release` (without `v`)
- update `CHANGELOG.md`; commit with a message like 
  _CHANGELOG: prepare npm v0.10.0-13.1_
- `npm version 0.10.0-13.1`; the first 4 numbers are the same as the 
  GitHub release; the fifth number is the npm specific version
- push all changes to GitHub
- `npm publish` (use `--access public` when publishing for the first time)

## Create the final GitHub release

- go to the [GitHub Releases](https://github.com/xpack-dev-tools/openocd-xpack/releases) page
- update the link behind the badge with the blog URL
- add a link to the Web page `[Continue reading »]()`; use an same blog URL
- **disable** the **pre-release** button
- click the **Update Release** button

## Share on Twitter

- in a separate browser windows, open [TweetDeck](https://tweetdeck.twitter.com/)
- using the `@xpack_project` account
- paste the release name like **xPack OpenOCD v0.10.0-13 released**
- paste the link to the Github release
- click the **Tweet** button

