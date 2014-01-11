#
# Cookbook Name:: cron_jobs
# Recipe:: default
#

page_job = 'RAILS_ENV=production /usr/local/bin/bundle exec rake sms_callback_patients --trace'
delay_job = 'RAILS_ENV=production /usr/local/bin/bundle exec rake sms_delay_patients'
remind_job = 'RAILS_ENV=production /usr/local/bin/bundle exec rake sms_reminder_patients'
late_job = 'RAILS_ENV=production /usr/local/bin/bundle exec rake sms_late_patients'

if node[:name] =~ /delayed_job/
  cron "minute tasks" do
    minute '*'
    user 'deploy'
    command "cd /data/clockwisemd_staging/current && #{page_job} && #{remind_job} && #{late_job}"
  end

  cron "2 minute tasks" do
    minute '*/2'
    user 'deploy'
    command "cd /data/clockwisemd_staging/current && #{delay_job}"
  end
end