---
layout: post
title: Fast, dependable, atomic Rails deploys with packages [part 1]
author: dnolan
---

Lonely Planet celebrates its 40 years, the website itself was launched around 14 years ago. We continuously refactor the website and this year has been a big step on the release of our new code based on Ruby rather than Java. After several months, we learnt about our new stack and how to make the best of it.

One of our issue was to make our deployment process fast, dependable and atomic, indeed what was working like a charm during our testing phase was a bit different in production under load.

Let's see how we made reliable deployment and reduce their time by **>96%**

### Context

Here at Lonely Planet, most of our apps are using a standard rails stack based on nginx and unicorn. When we released our first application based on this stack in production we were using our configuration management tool (Chef) in order to deploy our code changes, the process roughly looked like that :

![flow chart with chef](/img/flowchart-with-chef1.png)

- Push you code to the SCM (git on github)
- Trigger the first job to test the app (Jenkins)
- Trigger the second job to deploy the app (Jenkins) which was a Chef run => [chef deploy resource](http://docs.opscode.com/resource_deploy.html)

## Challenges

This approach worked well for a while, especially when we didn't have a lot of deployments and projects following this process. Indeed as soon as we started to continuously deploy more and more in production we faced the following issues.

### Dependencies

#### Github

Each deploy was pulling the code from github (so were some Gems). Which means it was quite slow, and each time Github encountered issue (Ddos attack or so) it was impacting our deploy process.

#### Rubygems.org

Each deploy was bundling the app, so if rubygems was not operational we were not able to get our app working.

### Time / Resources

Between 8 and 10 minutes, CPU usage maxed out for 5 minutes, latency increase.

Because we were using Chef, we were wasting time on checking the state of the whole server where the only thing mattering was the code release.

*We were consuming a lot of CPU resources during the bundle of the app on all servers, making the live app slower (gems download/install/compilation).*

We were using a lot of CPU resources during the assets precompile phase.

### Rollback

The rollback process was a bit messy and slow : we had to do some changes to chef, which was then tested and deployed.

### Inconsistent

The chef deploy resource is not ideal. If your deployment failed in the middle of callback (before_restart) by example, you can end up with an inconsistent state (which doesn't help when you want to rollback). Some behavior are annoying (the deploy resource trying to chown every file in your app folder (even symlink point to shares) by example.

We had to force a deploy when we wanted to change a the application's configuration.

We needed a solution to fix all this breaking point.

## Goals

As mentioned before we wanted aprocess fast and dependable, solving all the above issues. That's why we decided to move to a packaged process. It should fix the dependencies, the CPU issues (no more bundle on the servers), ease the rollback process, make the deploy asidempotent as possible, reduce the deploy time due to a focused package deploy rather than "a chef server" deploy.

## But first

### Split code from environment configuration

It was the first step in our new process. To achieve a clean package with code only we had to be sure the configuration was out of the app. In the meantime it has to be simple to deploy in production and easy to adapt to the developer's local environment. We decided to use [https://github.com/bkeepers/dotenv](https://github.com/bkeepers/dotenv).It allow us to load ENV variables from an ENV file, we told dotenv the fiel location is stored is an ENV variable. Which means you have something like, CONF_MYAPP=/etc/MYAPP/env Then in your app's config

```ruby
require 'dotenv'
Dotenv.tap do |de|
  de.load
  de.load(ENV['CONF_MYAPP']) if ENV['CONF_MYAPP']
end
```

It was a simple step, but crucial if we wanted to implement packaging.

## Then
### Package the APP
#### Inside

We knew what we wanted to put in our package.
 - The code
 - The gems (bundled in the package itself)
 - Needed files only, so we have to remove useless folders (spec/git/doc etc...).

We didn't add the assets to the package because we chose to ship them to an S3 bucket : *Assets pipeline*

We didn't want to add more, because we focused on having a package having the strict minimum to release a unicorn app with the desired code version.

#### Container

All our systems are based on Ubuntu, therefore at least 2 solutions were possible concerning the package format :

- tarball
- debian package

Even if the tarball was the easiest solution we didn't want to have tarball + deploy script. It didn't look good enough for a long term solution, due to the lack of version management and metadata. We wanted to be sure to have a consistent state on a server, with some easy step deploy, rollback, or deploy the code at a well known state. The deb package looked like the best solution, we would be able to :

 - Version our releases (not only the filename) : so our system will be aware of the code version we use. It will be pretty simple to integrate to our bootstrap process as chef is really good at managing apt packages
 - Add metadata : release commit, code variant, so it is easy to know which version is live
 - apt/aptitude would manage the deploy phase : we don't have to worry when we upgrade from when version to another, when we downgrade either. A lot of work have already be done to manage software installation on Debian/Ubuntu, so why reinvent the wheel?
 - Add dependencies : we can include dependencies on system libraries, by examplelibxml2-dev/libsqlite straight away on our code package. So a package is able to start a full working app.

So now we have our code ready to use external configuration, a package to deploy the code, how will we use it?

## Final process

There are few more logical steps in the process than with the Chef integration.

![new chart](/img/flowchart-with-package.png)

- Push the code
- CI test the code
- CI build the package
- CI deploy the package

It will be different if you boot a server from scratch, because it is not triggered by a code push

- Chef deploy the server AND the app configuration
- Chef deploy the last package

## Outcome

 - Reduction of our deployment time from an average of 10 minutes per server to 25 seconds
 - No impact anymore from the different Github and Rubygems.org outage
 - Rollback step is easy and fast
 - Latency is constant even while deploying

In the next article we will see in details which tools have been used, and the detailed steps. We needed to be able to build the packages, host our deb repository, remotely trigger the package install and configure the environment.
