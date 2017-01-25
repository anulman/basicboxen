return if node['certbot'].nil?

include_recipe 'certbot'

config_dir = node['certbot']['config_dir']
primary_domain = node['certbot']['site']['domains'].first

cert_dir = "#{config_dir}/live/#{primary_domain}"
cert_file = "#{cert_dir}/fullchain.pem"

directory cert_dir do
  action :delete
  only_if { Certbot::Util.self_signed_certificate?(cert_file) }
end

certbot_certonly_webroot primary_domain do
  webroot_path node['certbot']['site']['webroot_path']
  email node['certbot']['site']['email']
  domains node['certbot']['site']['domains']
  agree_tos node['certbot']['site']['agree_tos']
  expand node['certbot']['site']['expand']
  notifies :restart, "service[nginx]"
end
