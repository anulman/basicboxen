# Cookbook Name:: site-certbot
# Attribute::default

default['site-certbot'] = {
  'agree_tos' => false, # must be overridden explicitly by user
  'email' => nil, # must be overridden explicitly by user
  'sites' => [{
    'name' => 'certbot',
    'domains' => ['domain1.com']
  }]
}
