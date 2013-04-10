G'day guys,

Hope no one else has this issue! I ran into an error installing `nodejs` via `brew` because my xcode setup was corrupted. I believe the problem was caused by me installing [xcode commnand line tools](https://developer.apple.com/xcode/) and [GCC ](https://github.com/kennethreitz/osx-gcc-installer) from github. 

The error I got was `Error: Can't run /usr/bin/usr/bin/xcodebuild (no such file).` when running `brew install node --verbose`.

I ran `xcode-select --print-path` to make sure it resolved to `/usr/bin`, which it was. So I then had a look at `/usr/bin/xcodebuild` and to my surprise it was not a binary file but a shell script! Which was appeneding `usr/bin` onto the path retrieved from `--print-path`!

The fix was to grab a copy of the binary from another machine *(shit I know!)* and stuff it back into `/usr/bin` overriding the bash script which I assume came from the `GCC installer`.

-Matt