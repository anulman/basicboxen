# Cookbook Name:: site-certbot
# Attribute::default

default['certbot']['site'] = {
  'webroot_path' => '/var/www/certbot',
  'email' => nil, # must be overridden explicitly by user
  'domains' => ['domain1.com'],
  'agree_tos' => false # must be overridden explicitly by user
}
