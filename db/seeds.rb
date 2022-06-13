# User One

user_one = User.create!(email: 'example@example.com',
                        password: '1234567890',
                        password_confirmation: '1234567890',
                        confirmed_at: Time.now.utc)

10.times do |n|
  user_one.categories.create!(name: "Category-u1 #{n}")
end

category_one = user_one.categories.first

10.times do |n|
  category_one.tasks.create!(name: "Task-u1 #{n}", details: "Description-u1 #{n}", deadline: Date.current)
end


# User Two

user_two = User.create!(email: '123re@example.com',
                        password: '1234567890',
                        password_confirmation: '1234567890',
                        confirmed_at: Time.now.utc)
10.times do |n|
  user_two.categories.create!(name: "Category-u2 #{n}")
end

category_two = user_two.categories.first

10.times do |n|
  category_two.tasks.create!(name: "Task-u2 #{n}", details: "Description-u2 #{n}", deadline: Date.current)
end
