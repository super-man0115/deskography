ActiveStorage::AnalyzeJob.queue_adapter = :inline
ActiveStorage::PurgeJob.queue_adapter = :inline

10.times do
  User.create!(
    user_name: Faker::Name.name,
    email: Faker::Internet.email,
    password: 'password',
    password_confirmation: 'password'
  )
end

20.times do |index|
  post = Post.new(
    user: User.offset(rand(User.count)).first,
    title: "タイトル#{index}",
    description: "説明#{index}",
    business_attribute: rand(0..10),
    age_group: rand(0..5)
  )

  post.main_image.attach(
    io: File.open('app/assets/images/default.png'),
    filename: 'default.png'
  )
  post.save
end
