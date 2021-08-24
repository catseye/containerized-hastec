containerized-hastec
====================

Run the [Haste](https://haste-lang.org/) compiler `hastec` almost as if you had it installed locally.

Several of [Cat's Eye Technologies'](https://catseye.tc/) language projects
use `hastec`.  But as of this writing, `hastec`
[only works with GHC 7.10](https://github.com/valderman/haste-compiler/issues/428),
and trying to install GHC 7.10 on modern OSes is, shall we say, burdensome.

So this is a Docker image, based on [rwstauner/haste-compiler](https://hub.docker.com/r/rwstauner/haste-compiler),
with some additions:

*   has extra some Cabal packages installed (notably [Parsec](https://hackage.haskell.org/package/parsec))
*   can be run as the host user, not just as root
*   comes with a script so that `hastec` can be run on the host, almost as if it was installed there.

### Instructions

*   Install Docker and add your user to the `docker` group.
*   Put the `bin` directory in this repository on your executable `PATH`.
*   Run `hastec --help`.  This will cause the image to be downloaded from
    [catseye/containerized-hastec](https://github.com/catseye/containerized-hastec)
    on Docker Hub.
*   You can now run `hastec` almost as if it was installed locally.

If you want to build the image yourself instead of downloading the one
on Docker Hub, in the root directory of this repository, run `./build.sh`.

### Caveats

"almost as if you had it installed locally" does have some limitations.

The containerized `hastec` works on the host's file system through a
bind mount.  The script establishes a bind mount from the current
working directory of the host, and the container can't see any of
the host's filesystem that is outside that directory.

So, for example, you can't tell `hastec` to output the generated
JavaScript file to `../built/out.js` because it can't see `../`.

Also, the Docker daemon always runs as root.  The script tells the
container to be run as the current user on the host.  This prevents
the files that `hastec` write from being owned by root.  But this
directive is not total; the Docker daemon still runs as root.
For that reason I would recommend not running the script from a
directory that contains anything important, such as `/`.
