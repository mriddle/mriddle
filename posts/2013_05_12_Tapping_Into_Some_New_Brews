At Lonely Planet's Melbourne headquarters, we occasionally sample some of the beverages on offer at local spots like [The Reverence](http://www.reverencehotel.com/) and [Station Hotel](http://www.thestationhotel.com.au/), and we've even talked about getting a beer fridge in the office, but did you know that you can tap some rare and delicious brews right on your Mac?

A little known but very useful feature of the Homebrew packaging system is what it calls "Taps" (similar to what other, more boring packaging systems typically call sources or repos).

A Homebrew Tap is just another github repo that Homebrew can use as a source of formulae. This can be used to add packages that aren't part of the official repo, or to override the version installed by an official formula.

I recently updated [our Boxen configuration](https://github.com/lonelyplanet/spp_boxen) to PostgreSQL 9.1.9. My teammate Dave asked me where I found a Homebrew formula for 9.1.9 to use in Boxen, since the main Homebrew repo only has 9.2.x. As it happens, the Boxen Puppet manifest we're using packages its own formula and installs it explicitly. If you want to go that way, you can install it via URL by running:

```shell
brew install https://raw.github.com/octanner/puppet-postgresql/acbbd7dcb8dcad9e9dd1fcb056933ae003b006e7/files/brews/postgresql.rb
```

If you're not using Boxen, though (e.g., setting up a personal Mac), a better way to go (IMO) is to tap the [homebrew-versions](https://github.com/Homebrew/homebrew-versions) repo, which exists to provide formulae for stable branches of common software:

```shell
brew tap homebrew/versions
brew install postgresql91
```

There's more docco at https://github.com/mxcl/homebrew/wiki/brew-tap and a set of semi-official taps at https://github.com/Homebrew. Other than the versions tap, the dupes tap is useful for packages that come with OSX (and are therefore disallowed from the main homebrew repo) but are out of date or missing useful compile-time options.

Another tip: you can use `brew pin <formula>` to keep a formula from auto-upgrading when you run `brew upgrade` without specifying it explicitly.
