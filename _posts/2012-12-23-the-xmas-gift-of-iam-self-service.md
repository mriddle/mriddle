---
layout: post
title: The Xmas Gift of IAM Self Service
author: mjennings
excerpt: When we created IAM accounts for our team, we had a desire to as self service as possible. Ideally, we wanted to provide a username and temporary password and then have users be able to set themselves up an access key, security certificate and MFA and be able to manage this themselves ongoing. However, this obviously couldn't be at the expense of security. We needed to ensure that users could only modify their own information and if we remove a user from our account theyre gone.
---

**Update: 9 April 2013**

*AWS has announced an update to IAM which allows the use of variables which makes this process much easier: http://docs.aws.amazon.com/IAM/latest/UserGuide/PolicyVariables.html. This post has been updated to reflect these changes.*

When we created [IAM](http://aws.amazon.com/iam/) accounts for our team, we had a desire to as self service as possible. Ideally, we wanted to provide a username and temporary password and then have users be able to set themselves up an access key, security certificate and MFA and be able to manage this themselves ongoing. However, this obviously couldn't be at the expense of security. We needed to ensure that users could only modify their own information and if we remove a user from our account theyre gone.

On the surface, this seemed like a trivial problem, we'd simply generate a policy for full IAM access for each individual user and that would be the end of it:

```
{
  "Statement": [
    {
      "Sid": "Stmt1356297700489",
      "Action": [
        "iam:*"
      ],
      "Effect": "Allow",
      "Resource": [
        "arn:aws:iam::049718304780:ACCOUNT#:user/${aws:username}"
      ]
    }
  ]
}
```

Unfortunately, the major challenge we faced was that IAM permissions through the console appears to be an all or nothing system. Even if you have full IAM access for your own user, you cant do anything as you dont have any permissions to list other users:

![IAM](/img/screen-shot-2012-12-24-at-08-24-39.png)

After much investigation (trial & error), we found the only way to achieve what we wanted was giving groups full IAM read only access and controlling write access with individual policies. While this may seem like a security vulnerability, the IAM console is cleverly designed to not provide any secret information. It may not be ideal that all users can see the groups that are setup, who has access keys etc., but none of this information is particularly useful.

This is the policy were using at the moment:

```
{
  "Statement": [
    {
      "Action": [
        "iam:*Password*",
        "iam:*AccessKey*",
        "iam:*SigningCertificate*",
        "iam:*MFADevice*",
        "iam:UpdateLoginProfile"
      ],
      "Effect": "Allow",
      "Resource": [
        "arn:aws:iam::ACCOUNT#:user/${aws:username}"
      ]
    },
      "Action": [
        "iam:*MFADevice*"
      ],
      "Effect": "Allow",
      "Resource": [
        "arn:aws:iam::ACCOUNT#:mfa/${aws:username}"
      ]
    }
  ]
}
```

Properly formatted code is available in this [gist](https://gist.github.com/4366364). We have had to change this a couple of time as AWS has made modifications to the names of IAM permissions. Unfortunately, we haven't found this out until someone has told us they can't do something.

<del datetime="2013-04-09T15:49:18+00:00">With our relatively small number of users, setting this up manually wasnt too onerous but it also should be fairly straightforward to script. If anyone does get around to scripting it, please share! We'll probably end up doing it soon anyway.</del>

Hopefully this post will become redundant soon if AWS improves how it handles these permissions.
