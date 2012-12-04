Spin up server
==
  From within our chef repo

    knife ec2 server create -I ami-fb8611c1 -f m1.small -S sppdev --subnet subnet-dfad4fb6 --security-group-ids sg-a85447c4 -x ubuntu -N "SPP-Blog" -r "role[lpos_default], role[spp_blog]" --availability-zone ap-southeast-2a --region ap-southeast-2

Blog
==
 - Update site_config.json
 - Add your logo and update styling if you want
 - Add your posts under the post dir
 - `bundle install && rackup`
