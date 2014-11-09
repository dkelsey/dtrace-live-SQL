dtrace-live-SQL
===============

Using DTrace, bash and Perl, probe and report on SQL running within a live MySQL DB

At the time I wrote this there were no freely available methods of recording live running SQL on a production MySQL server without reconfiguring and restarting.  There was no way to toggle SQL logging.  DTrace allows you to peer into running processes.  I found examples of using DTrace to observer running SQL on a live MySQL server.  I used PERL to count unique queries by incrementing a hash of each query (KEY) then printing the total (VALUE).

#Usage:

```
#> ./dtrace-running-SQL.sh
```

#Notes:

* To run this you must have root privileges
* This will only work on a system that supports DTrace
* This is not a generic script that determines the mysqld PID.  You will have to make changes to it to get it to work.

#Dependencies:

- DTrace - supported on Solaris and OSX.
- perl - no special modules required.
- super user privileges - needed to probe the mysqld process.
