Redmine Issue Reminder
==============

[![Join the chat at https://gitter.im/Hopebaytech/redmine_issue_reminder](https://badges.gitter.im/Join%20Chat.svg)](https://gitter.im/Hopebaytech/redmine_issue_reminder?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge)

[Plugin page on redmine.org](http://www.redmine.org/plugins/redmine_mail_reminder)

Compatible with redmine 3.0, 2.6, 2.5, 2.0 (on branch master, redmine2.6, redmine2.5, redmine2.0 respectively)

Plugin provides an easy to use interface to set up automatic email reminder to every project. 
Every reminder uses a custom query with all their filter options to select issues 
and performs periodical email transmission on a role basis.

Following intervals are possible:
 - Daily (Selecting interval from every 1st day until every 6th day)
 - Weekly (Selecting weekday)
 - Monthly (Selecting day of the month)

## Screenshots

![image](http://farm7.static.flickr.com/6109/6294745006_49986ec541_b.jpg)
![image](https://lh3.googleusercontent.com/-A-s0giWSvvk/VNiFf7PnSfI/AAAAAAAACHI/6DA5JDDmF2U/s2048/2015-02-09%25252018_01_30-2015-02-09%25252017_52_56-Redmine%252520Issue%252520Reminder%252520-%252520jethro.yu%252540happygorgi.com%252520-%252520%2525E5%252592%25258C%2525E6%2525B2%25259B%2525E7%2525A7%252591%2525E6%25258A%252580%2525E8%252582%2525A1%2525E4%2525BB%2525BD%2525E6%25259C%252589%2525E9%252599%252590.png)
![image](https://cloud.githubusercontent.com/assets/84070/7959114/ceb99b22-0a28-11e5-94f9-f4169423d0cf.png)
![image](https://cloud.githubusercontent.com/assets/84070/7959130/f794f6cc-0a28-11e5-93c9-16d56ca9c6ea.png)


## Migrate from redmine_issue_reminder to redmine_mail_reminder

At 2015/05/13 (2.6/3.0 Branch) this plugin is renamed from redmine_issue_reminder to redmine_mail_reminder, in order to avoid conflict with [existed redmine_issue_reminder](http://www.redmine.org/plugins/redmine_issue_reminder).

* Rename your redmine_issue_reminder directory (redmine/plugins/redmine_issue_reminder) to redmine_mail_reminder

* Connect to your redmine's SQL database, run the following SQL script
	```sql
	update schema_migrations set version=replace(version, 'redmine_issue_reminder', 'redmine_mail_reminder') where version like '%redmine_issue_reminder%';
	update settings set name=replace(name, 'issue', 'mail') where name =  'plugin_redmine_issue_reminder';
	```

* Pull new version source from github

* Install dependencies and migrate database
	```console
	cd redmine/
	bundle install
	RAILS_ENV=production rake redmine:plugins:migrate
	```
7. Restart your web server (usually /etc/init.d/apache2 restart)

## Installation - Linux

* Clone this repository into ```redmine/plugins/redmine_mail_reminder```
* Install dependencies and migrate database
	```console
	cd redmine/
	bundle install
	RAILS_ENV=production rake redmine:plugins:migrate
	```

* Setup cronjob for daily transmission. RVM users see [Using RVM with Cron](https://rvm.io/deployment/cron).
	```
	crontab -e
	# Check reminders at 06:00 every day, send emails by schedule
	0 6 * * * cd redmine/ && rake reminder:exec RAILS_ENV="production" > /dev/null 2>&1
	# Or, Check reminders at 08:30 on work days 1-6, send emails by schedule
	30 8 * * 1-6 cd redmine/ && rake reminder:exec RAILS_ENV="production" > /dev/null 2>&1
	```

* Restart your Redmine web server (e.g. mongrel, thin, mod_rails)

## Installation - Windows

Enviroment : Winxp + Redmine 1.2.X + Mysql 5.X
 
* Write a bat file such as these
	```bat
	echo on
	cd redmine\
	rake reminder:exec RAILS_ENV="production"
	```

* Config a schedule following  http://www.iopus.com/guides/winscheduler.htm
* Restart redmine server.

## Configuration

* Active `Issue reminder` module in project settings
* Configure `View issue reminder` in "Administration > Roles and permissions"
* Create a [custom query](http://www.redmine.org/projects/redmine/wiki/RedmineIssueList#Custom-queries) of what you want to send in email.
* Create reminder with custom query in "Project > Issues Reminder"
 
## Testing redminder mail

Send test mail without affecting inverval of schedule

```rake reminder:exec[test] RAILS_ENV="production"```

* The behavior of `rake reminder:exec` is to send email only if it is time to send a new email, regarding the interval parameters. If you execute `rake reminder:exec` manually, it will affact next scheduled transmission.
* `rake reminder:exec[test]` is supposed to have exactly the same behavior as `rake reminder:exec`, except two things:
	* It does always send emails to issue assignees (no matter when the last execution was)
	* It does not affecting the next schedule of `rake reminder:exec`.

## Troubleshouting

### How can i customize the queries?

Take a look at the official documentation about custom queries: 
http://www.redmine.org/projects/redmine/wiki/RedmineIssueList#Custom-queries

### I don't see the Reminder Settings

Add permission to Your user.

### The issue reminder doesn't send mails

We use redmine internal mail send functions, therefore the outgoing email settings 
has to be set in config/emai.yml or config/configuration.yml

### I can not use the windows scheduler (WinXP related)

You need to have a user password set for your windows user in order to use the windows scheduler. See also here: http://technet.microsoft.com/en-us/library/cc785125(WS.10).aspx 

## Translations

- de by Michael Kling
- en by Boško Ivanišević
- sr-YU by Boško Ivanišević
- sr by Boško Ivanišević

Thanks for the contribution. 

## To-Do List

- Fix: changing interval type updates interval value @ "New reminder"
- Fix: cancel button @ "Edit"
- Fix: load value per reminder @ "Edit"
- Feature: `rake reminder:exec[reset_scheduler]`

## Changelog

### 2014/6/3

 - Inline CSS from site setting, What You See Is What You Get. Require `$ bundle install`

### 2014/5/23

 - Add a way to test by rake command
 - User can use all queries viviable at redmine page to set reminder.
 - Fix async_smtp can't
 - Fix compatibility with Redmine 2.5.1
