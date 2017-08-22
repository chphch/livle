# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

SIZE_1 = 60
SIZE_2 = 5
youtube_list = ["https://www.youtube.com/watch?v=mHr2-0hCiqg", "https://www.youtube.com/watch?v=6XJjw7sWj84",
                "https://youtu.be/Xvjnoagk6GU", "https://www.youtube.com/watch?v=_gWn2xRfE90", "https://youtu.be/si_TE3iKjEQ"]

for i in 1..SIZE_1
  User.create(
    email: i.to_s + "@naver.com",
    password: "12341234",
    provider: "local",
    nickname: Faker::HarryPotter.character,
    intro: Faker::Hacker.say_something_smart,
    profile_img: nil
  )
end

for i in 1..SIZE_1
  Artist.create(
    name: "artist_" + (i * 5).to_s,
    image_url: "asdfasdf"
  )
end

for i in 1..SIZE_1
  feed = Feed.create(
    user_id: rand(1..SIZE_1),
    is_curation: [false, false, false, true].sample,
    title: "feed_" + i.to_s,
    youtube_id: youtube_list.sample,
    content: Faker::Hacker.say_something_smart,
    count_view: rand(1..100),
    count_share: rand(1..100),
    rank: 0.0
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
    main_youtube_id: youtube_list.sample,
    start_date: Date.new(2017,rand(8..12),rand(1..30)),
    end_date: Date.new(2017,rand(8..12),rand(1..30)),
    ticket_url: 'https://m.facebook.com'
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

for i in 1..SIZE_2
  notice = Notice.create(
     title: "notice_" + i.to_s,
     content: Faker::Hacker.say_something_smart
  )
end