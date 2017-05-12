return if node['certbot'].nil?

include_recipe 'certbot'
include_recipe 'site-certbot::bootstrap'

config_dir = node['certbot']['config_dir']

node['site-certbot']['sites'].each do |site|
  primary_domain = site['domains'].first
  public_path = site['public_path'] || 'current/public'

  cert_dir = "#{config_dir}/live/#{primary_domain}"
  cert_file = "#{cert_dir}/fullchain.pem"

  directory cert_dir do
    action :delete
    only_if { Certbot::Util.self_signed_certificate?(cert_file) }
  end

  certbot_certonly_webroot primary_domain do
    webroot_path "/var/www/#{site['name']}/#{public_path}"
    email node['site-certbot']['email']
    domains site['domains']
    agree_tos node['site-certbot']['agree_tos']
    expand node['site-certbot']['expand']
    notifies :restart, "service[nginx]"
    not_if { ::File.exist?(cert_file) }
  end
end
