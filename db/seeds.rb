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

admins = graph.groups.select{|g| g.mail == ENV['ADMIN_SOURCE']}.first.members.map { |m| m.mail  }
users.each do |u|
  new_user = User.find_or_create_by(name: u.display_name, email: u.mail)
  new_user.active = true
  new_user.is_admin = admins.include? new_user.email.downcase
  new_user.save!
end

loaner = User.find_or_create_by(name: 'Loaner', email: 'loaner@fsenet.com')
loaner.active = true
loaner.save!
