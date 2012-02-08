namespace :db do
  desc "Fill database with sample data"
  task :populate => :environment do
    Rake::Task['db:reset'].invoke
    admin = User.create!(:name => "Example User",
                         :email => "user@example.com",
                         :password => "foobar",
                         :password_confirmation => "foobar")
    admin.toggle!(:admin)
    # Create 99 users (in addition to the admin above)
    99.times do |n|
      name  = Faker::Name.name
      email = "example-#{n+1}@railstutorial.org"
      password  = "password"
      User.create!(:name => name,
                   :email => email,
                   :password => password,
                   :password_confirmation => password)
       if n == 3  # make user #5 an admin.
         User.last.toggle!(:admin)
       end
    end
    # Create microposts for the first six users.
    50.times do
      User.all(:limit => 6).each do |user|
        user.microposts.create!(:content => Faker::Lorem.sentence(5))
      end
    end
  end
end