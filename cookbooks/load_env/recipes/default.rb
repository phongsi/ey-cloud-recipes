#
# Cookbook Name:: load_env
# Recipe:: default
#

execute "load vars and set environment" do
  command <<-EOH
    source /data/clockwisemd_staging/shared/config/env.custom
    echo ENCRYPTION_PASSWORD=$ENCRYPTION_PASSWORD >> /etc/environment
    echo MAILER_URL=$MAILER_URL >> /etc/environment
    echo SENDGRID_PASSWORD=$SENDGRID_PASSWORD >> /etc/environment
    echo SENDGRID_USERNAME=$SENDGRID_USERNAME >> /etc/environment
    echo TWILIO_AUTH=$TWILIO_AUTH >> /etc/environment
    echo TWILIO_SID=$TWILIO_SID >> /etc/environment
  EOH
end