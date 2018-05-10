require 'net/http'
include_recipe 'route53'

chef_gem "nokogiri" do
  action :install
  version "1.5.11"
end

route53_record "create a record" do
  name  node[:opsworks][:instance][:hostname] + node[:dns_domain_end]
  value Net::HTTP.get(URI.parse('http://169.254.169.254/latest/meta-data/local-ipv4'))
  type  "A"
  ttl   60
  zone_id               node[:dns_zone_id]
  overwrite true
  action :create
end