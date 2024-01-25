# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

content = ['今日は暑い！', '今日は寒い！', '今日は涼しいな！', '今日は暖かいな！', "もくもく！\n今日も頑張ろう!"]

10.times do |n|
  user = User.find_or_initialize_by(email: "user#{n + 1}@example.com")
  user.name = "user#{n + 1}"
  user.password = "user#{n + 1}pass"
  user.skip_confirmation!
  user.save!
  user.profile_image.attach(io: Rails.root.join('app/assets/images/default_profile.jpg').open,
                            filename: 'default_profile.jpg')
  user.header_image.attach(io: Rails.root.join('app/assets/images/default_header.jpg').open,
                           filename: 'default_header.jpg')

  user.tweets.create!(content: content.sample)
  user.tweets.create!(content: content.sample)
  if user.id != 1
    user.comments.create!(tweet_id: n, content: content.sample)
    user.comments.create!(tweet_id: n, content: content.sample)
  end
end
