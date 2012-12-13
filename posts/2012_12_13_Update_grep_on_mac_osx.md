Update grep to the latest version using brew on mac!

OSX 10.7 comes installed with grep version 2.5.1 which sadly does not include the *--exclude-dir* option.
To update run the following code

```
  brew install xz #required for installing grep through homebrew
  brew install https://raw.github.com/Homebrew/homebrew-dupes/master/grep.rb
```

Enjoy :)