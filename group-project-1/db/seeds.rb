#
# # 75 users in total
# 50.times do
#   User.create(
#     name: Faker::Name.name,
#     email: Faker::Internet.email,
#     phone_number: Faker::Number.number(10),
#     password: Faker::Internet.password
#   )
# end
#
# 50.times do
#   Task.create(
#     name: Faker::Name.name,
#     description: Faker::Hipster.sentence,
#     user_id: Faker::Number.between(1, 74),
#     event_id: Faker::Number.between(1, 50),
#     complete: Faker::Boolean.boolean
#   )
# end
#
# 50.times do
#   Event.create(
#     name: Faker::Name.name,
#     host: Faker::Number.between(1, 50),
#     address: Faker::Address.street_address,
#     start_date: Faker::Time.forward(23, :all),
#     end_date: Faker::Time.forward(23, :all),
#     description: Faker::Hacker.say_something_smart
#   )
# end
