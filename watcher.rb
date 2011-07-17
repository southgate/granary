require 'shopify_api'
require 'watchr'

KEY = 'acfb01e15f8b623f3a5cc0aa7d81cb64'
SECRET = 'a6c0fd6135a2d1663e63149dbe042995'
DOMAIN = 'community-grains-store'

['templates/.*\.liquid', 'layout/.*\.liquid', 'assets/.*'].each do |pattern|
  watch(pattern) do |match|
    puts "Updating #{match[0].inspect}..."
    upload_template(match.to_s)
  end
end

def upload_template(file)
  ShopifyAPI::Base.site = "http://#{KEY}:#{SECRET}@#{DOMAIN}.myshopify.com/admin/"

  asset = ShopifyAPI::Asset.find(file)
  asset.value = File.read(file)
  asset.save
end
