<br />

<pre>
fe_sendauth: no password supplied
</pre>

If you're getting this error in your local development when trying to use "PostgreSQL":http://www.postgresql.org/ set your pg_hba.conf to include a trust line for the hosts involved to fix the problem.

The default location for pg_hba.conf can be found here:
<i>/etc/postgresql/9.0/main/pg_hba.conf</i>

I changed the following lines at the bottom of the file

<pre>
# "local" is for Unix domain socket connections only
local   all         all                               trust
# IPv4 local connections:
host    all         all         127.0.0.1/32          trust
# IPv6 local connections:</code>
host    all         all         ::1/128               trust
</pre>

<b>Remember to restart your postgres server ;)</b>

-Matt