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
    minute '1'
    user 'deploy'
    command <<-EOH
      cd /data/clockwisemd_staging/current
      rails runner -e production '#{page_job} && #{remind_job} && #{late_job}'
    EOH
  end

  cron "2 minute tasks" do
    minute '2'
    user 'deploy'
    command <<-EOH
      cd /data/clockwisemd_staging/current
      rails runner -e production '#{delay_job}'
    EOH
  end
end