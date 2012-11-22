I often clone my production data to play with during development. Even though my database is small the <code>heroku db:pull</code> takes ages. Don't worry though because there is a free and easy alternative (<i>If your development database is postgres</i>). It's called [PG Backups](http://addons.heroku.com/pgbackups)

To get up and running with PG Backups do the following

**Install**

	$ heroku addons:add pgbackups

**Backup**

	$ heroku pgbackups:capture

**View**

	$ heroku pgbackups

**Download**

	$ heroku pgbackups:url b001

**Restore**

	$ pg_restore --verbose --clean --no-acl --no-owner -h myhost -U myuser -d mydb latest.dump

**Delete** (If you wanted to)

	$ heroku pgbackups:destroy b001

If you don't have postgres as your back-end for development I suggest you do because it's awesome and Heroku use it as your production database anyway.

-Matt