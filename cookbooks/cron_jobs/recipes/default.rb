#
# Cookbook Name:: cron_jobs
# Recipe:: default
#

page_job = 'Messenger.send_page_messages'
delay_job = 'Messenger.send_delay_messages'
remind_job = 'Messenger.send_reminder_messages'
late_job = 'Messenger.send_late_messages'

if node[:name] =~ /delayed_job/
  cron "minute tasks" do
    minute '*'
    user 'deploy'
    command "cd /data/clockwisemd_staging/current && RAILS_ENV=production /usr/local/bin/bundle exec rake sms_callback_patients"
  end

  cron "2 minute tasks" do
    minute '*/2'
    user 'deploy'
    command "cd /data/clockwisemd_staging/current && RAILS_ENV=production /usr/local/bin/bundle exec rake sms_delay_patients"
  end
end