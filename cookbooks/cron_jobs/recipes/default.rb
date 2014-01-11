#
# Cookbook Name:: cron_jobs
# Recipe:: default
#

queue_page_job = "Delayed::Job.enqueue(DelayedRake.new('sms_callback_patients', nil))"

if node[:name] =~ /delayed_job/
  cron "task_name" do
    minute '*/1'
    user 'deploy'
    command "source /data/clockwisemd_staging/shared/config/env.custom && cd /data/clockwisemd_staging/current && rails runner -e production '#{queue_page_job}'"
  end
end