# SSL.com Voyager

This evaluation will help us evaluate you as a candidate for our Software Engineering team. It is important to understand this is only one aspect of our evaluation process. Below you will find all of the information needed to complete the evaluation.

We are trying to understand what makes you tick, where you might excel and where you might struggle. This is only a single point to evaluating our candidates and does not by itself make or break your engagement with our team. Do the best you can and show us what you got! Please spend **no more than 4 hours** from start to finish. We want to see what you can get done in that time. Environment setup (installing ruby, postgres, rails) should **NOT** be accounted for in your 4 hours. We are basing this on the honor system but please do keep a log of what time you start and what time you end. Please include this in your PR in the description.

Unless specified, please feel free to use any gem, engines, methods, libraries, information sources and development tools that you see fit in order to complete this project. You are free to showcase how you can manage development, feature and timelines to get as much done as possible with the best possible results. Please keep in mind we are a security company and secure, scalable applications are expected at all times.

If you finish early You can look into the Bonus Points section for additional tasks we would like you to complete if possible. Good luck!

<br>

## Configuring Your Environment

> [!NOTE]
> It is important this repository be publicly accessible so that our team members can review it. If the repository is not publicly accessible, it will not be considered.

##### STEP 1: Clone this repo and push it into a new public repository

```
git clone https://github.com/SSLcom/voyager
```

<br>

##### STEP 2: Configure and start support services

```bash
# - - - - - - - - - - - -
# CREATE DOCKER NETWORKS
# - - - - - - - - - - - -

docker network create service-net
docker network create backend-net

# - - - - - - - - - - - -
# CREATE SUPPORT SERVICES
# - - - - - - - - - - - -

docker compose --env-file .docker/.env up postgres -d
docker compose --env-file .docker/.env up redis -d
docker compose --env-file .docker/.env up mail-catcher -d
```

<br>
<br>

> [!TIP]
> This will dump you into a bash session where you can run any shell, rails or rake command. Every command needs to be prefixed with bundle exec.

##### STEP 3: Start the development container

```
docker compose --env-file .docker/.env run -it --rm -p 3500:3500 -p 35000:35000 application /bin/bash
```

Once you are in the container on the command line, this functions as it does with any rails application.

First you will need to create, migrate and seed the database.

```
bundle exec rake db:create && bundle exec rake db:migrate && bundle exec rake db:seed
```

You will then need to start the services. We use foreman to run all of the servcies needed for the rails application

```
foreman start
```

** If you get an error about foreman not being installed, you can install it using `gem install foreman`



<br>

##### STEP 4: Access services
- You can now access the rails application via http://127.0.0.1:3500
- You can now access mail catcher via http://127.0.0.1:1080
- If you are using the debug gem for breakpoints in VS code, the debugger is configured to use port `35000`

<br>

## Best Practices

Lets cover a couple ground rules that we follow here at SSL.com in terms of development processes, procedures and standards.

- You must use Ruby 3.2 and Rails 7.1.3
- You must use TailwindCSS for the CSS elements.
- You must use HAML instead of ERB for your views.
- You must use Stimulus or Vanilla JS for any javascript needs.
- You must use RSpec for testing.
- Your code must pass the StandardRB formatting requirements.

<br>

**Tools & Gems**

The following tools are installed to aid in development and review.

<br>

**Bundler Audit:**

This will check gems for security issues.

```
bundle exec bundler audit --update
```

<br>

**Bundler Leak:**

This will check gems for memory leaks.

```
bundle exec bundler leak --update
```

<br>

**Brakeman:**

This will perform static code analysis for security risks.

```
bundle exec brakeman
```

<br>

**StandardRB:**

This will ensure you are following our coding standards.

```
bundle exec standardrb
```

<br>

## Getting Started

Great! Lets get started. Below you will find an example of a daily ticket you might work on here at SSL.com. While it is not in JIRA, it has all of the details that our typical ticket would have. Please use the information below to complete the task.

This repository contains a demo Rails 7 application as a starter. Please do not modify the Docker or Docker Compose files. Please also leave all Database names/urls the same, as it helps when we review your code. You can of course add additional gems as needed.

. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .

This week has been crazy and we need you to help us knock out a simple application to clear our backlog and make one of our new customers happy. Are you up for the challenge?

We are in major crisis mode and only have 4 hours to deliver a POC (Proof of Concept) application to manage users, teams and roles. Keep in mind this is a POC and we want you to knock out as much as you can while ensuring it is functional and is presentable. Security and Functionality should be observed throughout the application.

<br>

**Ticket Summary:**

Create a rails 7 application that allows an admin user to login and manage users, teams and roles via a UI.

<br>

**Description:**

As an admin user,
I would like to have a system that I can login into and create & manage users, teams and roles from a UI,
So that I can easily maintain our list of users and their perspective roles for the application.

<br>

**Acceptance Criteria:**

- Must adhere to our Best Practices listed above.
- Must be able to register an account on the site.
	- Must enforce the user to enter the following information:
		- First Name
		- Last Name
		- Username (only alpha-numeric characters)
		- Valid Email Address
		- Password
		- Password Verification
- Must be able to reset password via email and a secure token.
- Must be able to login to the site via email address or username.
- Must be redirected to a Dashboard page placeholder upon login.
- must be able to setup a specific redirect variable in the URL. The user must be directed to this URL instead of the dashboard if set. Once directed it must be cleared for future attempts.
- Must ensure that email address is unique.
- Must ensure that username is unique.
- Must be able to select a team from a dropdown in the top nav bar.
	- Must only present teams you are a member or owner of.
	- Must store Active Team so that additional resources can be built off of this.
	- Must have current_team helper available anywhere current_user is available.
- Must be able to manage Users
	- Must provide ability to have an avatar.
	- Must have a first name.
	- Must have a last name.
	- Must be able to edit own profile (first name, last name, email address & username)
	- As an admin must be able to create, edit and destroy all users.
	- As an admin must be able to assign roles to the user on a team level.
- Must be able to manage Teams
	- Must have a name.
	- Must have a description.
	- Must have a single owner that is a user.
	- Must have multiple users with different roles per team.
	- Must be able to create, edit and destroy own teams.
	- As an admin must be able to create, edit and destroy all teams.
- Must be able to manage Roles
	- Must have a name.
	- Must have a description.
	-  Must have granular permissions that can be used in the code.
	- Must be able to create, edit and destroy own roles.
	- As an admin must be able to create, edit and destroy all roles.
- Must ensure unit tests are written in Rspec.
	- Must ensure proper specs are written and passing.

<br>

**Bonus Points:**

- Configure GitHub actions to run `standardrb` and `rspec` tests automatically.

---
