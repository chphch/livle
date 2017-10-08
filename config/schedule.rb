# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
# set :output, "/path/to/my/cron_log.log"
#
# every 2.hours do
#   command "/usr/bin/some_great_command"
#   runner "MyModel.some_method"
#   rake "some:great:rake:task"
# end
#
# every 4.days do
#   runner "AnotherModel.prune_old_records"
# end

# Learn more: http://github.com/javan/whenever

# set :environment, "development"
home_path = "/var/app/current"
set :output, {error: "#{home_path}/log/cron_error_log.log", standard: "#{home_path}/log/cron_log.log"}

# Code is in lib/tasts/update_ranks.rake
every 6.hours do
  rake 'update_ranks:feed_ranks'
  rake 'update_ranks:upcoming_ranks'
end
