# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# require 'adal'
# require 'microsoft_graph'
# require 'byebug'

# authenticate using ADAL
require 'adal'
username      = ENV['AUTH_EMAIL']
password      = ENV['AUTH_PWD']
client_id     = ENV['OFFICE365_KEY']
client_secret = ENV['OFFICE365_SECRET']
tenant        = ENV['TENANT']
user_cred     = ADAL::UserCredential.new(username, password)
client_cred   = ADAL::ClientCredential.new(client_id, client_secret)
context       = ADAL::AuthenticationContext.new(ADAL::Authority::WORLD_WIDE_AUTHORITY, tenant)
resource      = "https://graph.microsoft.com"
tokens        = context.acquire_token_for_user(resource, client_cred, user_cred)

# add the access token to the request header
callback = Proc.new { |r| r.headers["Authorization"] = "Bearer #{tokens.access_token}" }

graph = MicrosoftGraph.new(
                            base_url: "https://graph.microsoft.com/v1.0",
                            cached_metadata_file: File.join(MicrosoftGraph::CACHED_METADATA_DIRECTORY, "metadata_v1.0.xml"),
                            &callback
)

User.update_all active: false

users = graph.groups.select{|g| g.mail == ENV['DIRECTORY_SOURCE']}.first.members

# admins = graph.groups.select{|g| g.mail == ENV['ADMIN_SOURCE']}.first.members.map { |m| m.mail  }
admins = ENV['ADMIN_LIST'].split('|').map { |s| "#{s}@fsenet.com"}
users.each do |u|
  new_user = User.find_or_create_by(name: u.display_name, email: u.mail)
  new_user.active = true
  new_user.is_admin = admins.include? new_user.email.downcase
  new_user.save!
end

loaner = User.find_or_create_by(name: 'Loaner', email: 'loaner@fsenet.com')
loaner.active = true
loaner.save!
