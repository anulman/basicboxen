return if node['certbot'].nil?

config_dir = node['certbot']['config_dir']

node['site-certbot']['sites'].each do |site|
  primary_domain = site['domains'].first

  # certbot defaults
  cert_dir = "#{config_dir}/live/#{primary_domain}"
  cert_file = "#{cert_dir}/fullchain.pem"
  key_file = "#{cert_dir}/privkey.pem"

  directory cert_dir do
    owner 'www-data'
    group 'www-data'
    mode '0755'
    recursive true
    action :create
  end

  openssl_x509 cert_file do
    common_name primary_domain
    org 'Foo'
    org_unit 'Bar'
    country 'US'
    key_file key_file
    owner 'www-data'
    group 'www-data'
    notifies :restart, "service[nginx]", :immediate
    not_if { ::File.exist?(cert_file) }
  end
end
