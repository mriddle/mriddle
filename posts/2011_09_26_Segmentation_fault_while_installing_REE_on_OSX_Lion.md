Hey guys, it's been a while I know! Started a new job at Lonely Planet which has kept me pretty busy.
Came across error below while setting up Ruby Enterprise Edition (REE) 

<pre>
cc -g -O2  -pipe -fno-common    -DRUBY_EXPORT  -L.    
  main.o dmydln.o libruby-static.a -L/opt/local/lib -Wl,
  -rpath,/Users/mojo/.rvm/rubies/ree-1.8.7-2011.03/lib -L/Users/
   mojo/.rvm/rubies/ree-1.8.7-2011.03/lib -lsystem_allocator -ldl -
   lobjc   -o miniruby
ld: warning: directory not found for option '-L/opt/local/lib'
./ext/purelib.rb:2: [BUG] Segmentation fault
ruby 1.8.7 (2011-02-18 patchlevel 334) [i686-darwin11.1.0], 
  MBARI 0x6770, Ruby Enterprise Edition 2011.03

make: *** [.rbconfig.time] Abort trap: 6
</pre>

Basically Xcode 4 on OSX Lion 10.7 defaults CC to llvm-gcc-4.2 which causes error in compiling REE under RVM. So when you install REE you might bump to following error

The solution is simple

<pre>
$ export CC=/usr/bin/gcc-4.2
$ rvm install ree --force
</pre>

Happy Tuesday
-Matt