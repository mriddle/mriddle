I often clone my production data to play with during development. Even though my database is small the <code>heroku db:pull</code> takes ages. Don't worry though because there is a free and easy alternative (<i>If your development database is postgres</i>). It's called "PG Backups":http://addons.heroku.com/pgbackups

To get up and running with PG Backups do the following

*Install*
--- Ruby
$ heroku addons:add pgbackups
---

*Backup*
--- Ruby
$ heroku pgbackups:capture
---

*View*
--- Ruby
$ heroku pgbackups
---

*Download*
--- Ruby
$ heroku pgbackups:url b001
---

*Restore*
--- Ruby
$ pg_restore --verbose --clean --no-acl --no-owner -h myhost -U myuser -d mydb latest.dump
---

*Delete* (If you wanted to)
--- Ruby
$ heroku pgbackups:destroy b001
---

If you don't have postgres as your back-end for development I suggest you do because it's awesome and Heroku use it as your production database anyway.

-Matt