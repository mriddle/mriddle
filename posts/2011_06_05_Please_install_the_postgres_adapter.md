I ran into the following problem this evening when starting my __rails server__

<pre>
$ rails server
=> Booting WEBrick
=> Rails 3.0.4 application starting in development on http://0.0.0.0:3000
=> Call with -d to detach
=> Ctrl-C to shutdown server
Exiting
/usr/local/rvm/gems/ruby-1.9.2-p180/gems/activerecord-3.0.4/lib/active_record/connection_adapters
/abstract/connection_specification.rb:71:in `rescue in establish_connection':
Please install the postgres adapter: `gem install activerecord-postgres-adapter`
(no such file to load -- active_record/connection_adapters/postgres_adapter) (RuntimeError)
</pre>

I got this error on my laptop so I thought I had some missing dependencies, I ran the gem install command as it suggested but got the following as a response:

<pre>
$ gem install activerecord-postgres-adapter
ERROR:  Could not find a valid gem 'activerecord-postgres-adapter' (>= 0) in any repository
ERROR:  Possible alternatives: activerecord-postgis-adapter, activerecord-postgres-copy,
activerecord-postgres-hstore, activerecord-jdbcpostgresql-adapter, activerecord-dbslayer-adapter
</pre>

There were a few suggestions on StackOverflow, they suggested installing the postgres gem

<pre>
$ gem install pg
</pre>

However I already had it installed. Ensured I had the latest version and kept looking...

*The solution was* simple really, I needed to change my __database.yml__ file.
I had the __adapter__ set to __postgres__ instead of __postgresql__

Newb mistake I will not be making again.

-Matt