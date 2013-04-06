Spent a little time looking for the best way to add Authors to the gitconfig using Boxen/Puppet and came up with this.

```puppet
class config::git {

  package { ["edgecase-git-pair"]:
    ensure => installed,
    provider => "gem",
  }

  git::config::global{ 'color.ui':
    value => 'auto',
  }

  git::config::global{ 'push.default':
    value => 'simple',
  }

  git::config::global{ 'core.editor':
    value => 'subl -w',
  }

  define add_git_pair ($user_details = $title) {
    exec {"Add ${user_details} git pair":
      command => "git config --global --add git-pair.authors \"${user_details}\"",
      unless => "grep -c \"${user_details}\" /Users/${::luser}/.gitconfig"
    }
  }

  add_git_pair{"User Name1 <username1@email.com.au>":}
  add_git_pair{"User Name2 <username2@email.com.au>":}

}
```

Hope you found it useful :)
