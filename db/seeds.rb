# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

SIZE_1 = 20
SIZE_2 = 5

for i in 1..SIZE_1
  User.create(
    email: i.to_s + "@a.com",
    password: "12341234",
    provider: "local",
    nickname: Faker::HarryPotter.character,
    profile_img: "image_profile.jpeg"
  )
end

for i in 1..SIZE_1
  Artist.create(
    name: "artist_" + i.to_s,
    image_url: "image_artist.jpg"
  )
end

for i in 1..SIZE_1
  curation = Curation.create(
    user_id: rand(1..SIZE_1),
    title: "curation_" + i.to_s,
    content: Faker::Hacker.say_something_smart,
    youtube_id: "https://youtu.be/Xvjnoagk6GU",
    count_share: rand(1..100),
    count_view: rand(1..100)
  )
  for i in 1..SIZE_2
    arr = Array.new(SIZE_1) {|i| i}.sample(5)
    CurationArtist.create(
      curation_id: curation.id,
      artist_id: arr[i]
    )
    CurationLike.create(
      curation_id: curation.id,
      user_id: arr[i]
    )
    CurationComment.create(
      curation_id: curation.id,
      user_id: rand(1..SIZE_1),
      content: Faker::Hacker.say_something_smart
    )
  end
end

for i in 1..SIZE_1
  feed = Feed.create(
    user_id: rand(1..SIZE_1),
    title: "feed_" + i.to_s,
    youtube_id: "https://youtu.be/Xvjnoagk6GU",
    count_view: rand(1..100),
    count_share: rand(1..100)
  )
  for i in 1..SIZE_2
    arr = Array.new(SIZE_1) {|i| i}.sample(5)
    FeedComment.create(
      feed_id: feed.id,
      user_id: arr[i],
      content: Faker::Hacker.say_something_smart
    )
    FeedArtist.create(
      feed_id: feed.id,
      artist_id: arr[i]
    )
    FeedLike.create(
      feed_id: feed.id,
      user_id: rand(1..SIZE_1)
    )
  end
end

for i in 1..SIZE_1
  upcoming = Upcoming.create(
    title: "upcoming_" + i.to_s,
    place: Faker::Space.galaxy,
    main_youtube_id: "https://youtu.be/Xvjnoagk6GU",
    start_date: Date.new(2017,rand(1..12),rand(1..12)),
    end_date: Date.new(2017,rand(1..12),rand(1..12)),
    ticket_url: 'www.naver.com',
    count_view: rand(1..100),
    count_share: rand(1..100)
  )
  for i in 1..SIZE_2
    arr = Array.new(SIZE_1) {|i| i}.sample(5)
    UpcomingArtist.create(
      upcoming_id: upcoming.id,
      artist_id: arr[i]
    )
    UpcomingComment.create(
      upcoming_id: upcoming.id,
      user_id: rand(1..SIZE_1),
      content: Faker::Hacker.say_something_smart
    )
    UpcomingLike.create(
      upcoming_id: upcoming.id,
      user_id: arr[i]
    )
  end
end
