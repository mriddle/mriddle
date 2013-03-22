
Spin up server
==
  From within our chef repo

    knife ec2 server create -I ami-fb8611c1 -f m1.small -S sppdev --subnet subnet-ddad4fb4 --security-group-ids sg-3b544757 -x ubuntu -N "SPP-Blog" -r "role[lpos_default], role[spp_blog]" --availability-zone ap-southeast-2a --region ap-southeast-2

Blog
==
 - Update site_config.yml
 - Update new relic config
 - Add your logo and update styling if you want
 - Add your posts under the post dir
 - `bundle install && rackup`

Adding a new post
==
- Create a new file within the ```posts``` directory. Make sure to use underscores in the name.
- run ```cap deploy```

