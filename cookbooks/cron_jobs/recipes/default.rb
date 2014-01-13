#
# Cookbook Name:: cron_jobs
# Recipe:: default
#

page_job = "/usr/local/bin/bundle exec rails runner -e production 'Messenger.send_page_messages'"
delay_job = "/usr/local/bin/bundle exec rails runner -e production 'Messenger.send_delay_messages'"
remind_job = "/usr/local/bin/bundle exec rails runner -e production 'Messenger.send_reminder_messages'"
late_job = "/usr/local/bin/bundle exec rails runner -e production 'Messenger.send_late_messages'"

if node[:name] =~ /delayed_job/
  cron "minute tasks" do
    minute '*'
    user 'deploy'
    command "/usr/bin/lockrun --lockfile=/tmp/jobname.lockrun -- sh -c 'cd /data/clockwisemd_staging/current && #{page_job} && #{remind_job} && #{late_job}'"
  end

  cron "2 minute tasks" do
    minute '*/2'
    user 'deploy'
    command "/usr/bin/lockrun --lockfile=/tmp/jobname.lockrun -- sh -c 'cd /data/clockwisemd_staging/current && #{delay_job}'"
  end
end