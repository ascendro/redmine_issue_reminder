Redmine Issue Reminder
==============

Plugin provides an easy to use interface to set up automatic email reminder to every project. 
Every reminder uses a custom query with all their filter options to select issues 
and performs periodical email transmission on a role basis.

Following intervals are possible:
 - Daily (Selecting interval from every 1st day until every 6th day)
 - Weekly (Selecting weekday)
 - Monthly (Selecting day of the month)

## Installation - Linux (Tested on Ubuntu by Me)

Download the sources and put them to your vendor/plugins folder.

    $ cd {REDMINE_ROOT}
    $ git clone git://github.com/ascendro/redmine_issue_reminder.git vendor/plugins/redmine_issue_reminder

Migrate database.

    $ rake db:migrate:plugins

(See also http://www.redmine.org/projects/redmine/wiki/Plugins )    

For the periodical transmission a daily cron job has to be created:
      
    $sudo crontab -e
    0 6 * * * cd {REDMINE_ROOT} && rake reminder:exec RAILS_ENV="production" > /dev/null 2>&1
    
Restart Redmine

Run Redmine and have a fun!

The reminder functionality can be activated in each project as module and can be configured through the project menu entry "Reminder Settings".
A special right needs to be configured in order to allow project member to edit reminder.

## Installation - Windows (Tested on WinXP by Steven Wong)

Enviroment : Winxp + Redmine 1.2.X + Mysql 5.X
 
 1. Write a bat file such as these

 ########################################
 
 echo on
 
 cd {REDMINE_ROOT}
 
 rake reminder:exec RAILS_ENV="production"
 
 ########################################
 
 2. config a schedule just follow this
 http://www.iopus.com/guides/winscheduler.htm
 
 3. then start the redmine server.
 
## Troubleshouting

### How can i customize the queries?

Take a look at the official documentation about custom queries: 
http://www.redmine.org/projects/redmine/wiki/RedmineIssueList#Custom-queries

### I don't see the Reminder Settings

Add permission to Your user.

## Translations

- de by Michael Kling
- en by Boško Ivanišević
- sr-YU by Boško Ivanišević
- sr by Boško Ivanišević

Thanks for the contribution. 

## Changelog

### 0.0.1

 - initial release
 - matches the basic requirements
 
## Screenshots

![](http://farm7.static.flickr.com/6109/6294745006_49986ec541_b.jpg)