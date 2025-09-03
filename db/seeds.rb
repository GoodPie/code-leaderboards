# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
begin
  puts "Creating default roles"
  Role.create!(name: "owner")
  Role.create!(name: 'admin')
  Role.create!(name: 'member')
  Role.create!(name: 'guest')
rescue ActiveRecord::RecordNotUnique
  puts "Roles already exist"
  puts ""
rescue StandardError => e
  puts "Error creating roles: #{e.message}"
  raise e
end

# Create the first user
default_email = "user@example.com"
default_password = (0...10).map { ('a'..'z').to_a[rand(26)] }.join
begin
  puts "Creating first user"

  User.create!(email_address: default_email, password: default_password)
  puts "Created first user"
  puts "Email: user@example.com"
  puts "Password: #{default_password}"
  puts ""
rescue ActiveRecord::RecordNotUnique
  puts "First user already exists"
  puts ""
end

# Generate the first tenant
begin
  puts "Creating first tenant"
  first_user = User.find_by(email_address: default_email)
  Tenant.create!(name: "Meetup", owner: first_user, slug: "meetup")
  puts "Created first tenant: Meetup"
rescue ActiveRecord::RecordNotUnique
  puts "First tenant already exists"
  puts ""
rescue StandardError => e
  puts "Error creating first tenant: #{e.message}"
  puts ""
end

# Generate the first tenant user and role
begin
  puts "Creating first tenant user"
  first_user = User.find_by(email_address: default_email)
  first_tenant = Tenant.find_by(name: "Meetup")
  first_tenant.add_user(first_user, role: :owner)

  puts "Created first tenant user"
  puts ""
rescue StandardError => e
  puts "Error creating first tenant user: #{e.message}"
  raise e
end
