# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

SIZE = 20

for i in 1..SIZE
  User.create(email: i.to_s + "@a.com", password: "12341234", provider: "local", nickname: Faker::HarryPotter.character, profile_img: "image_profile.jpeg")
end

for i in 1..SIZE
  Artist.create(name: Faker::Book.author, image_url: "image_artist.jpg")
end

for i in 1..SIZE
  curation = Curation.create(user_id: rand(1..SIZE), title: Faker::Demographic.race, content: Faker::Hacker.say_something_smart, count_share: rand(1..100), count_view: rand(1..100))
  for i in 1..SIZE
    CurationArtist.create(curation_id: curation.id, artist_id: rand(1..SIZE))
    CurationLike.create(curation_id: curation.id, user_id: rand(1..SIZE))
    CurationComment.create(curation_id: curation.id, user_id: rand(1..SIZE), content: Faker::Hacker.say_something_smart)
  end
end

for i in 1..SIZE
  feed = Feed.create(user_id: rand(1..SIZE), title: Faker::Demographic.race, youtube_id: "https://youtu.be/Xvjnoagk6GU", count_view: rand(1..100), count_share: rand(1..100))
  for i in 1..SIZE
    FeedComment.create(feed_id: feed.id, user_id: rand(1..SIZE), content: Faker::Hacker.say_something_smart)
    FeedArtist.create(feed_id: feed.id, artist_id: rand(1..SIZE))
    FeedLike.create(feed_id: feed.id, user_id: rand(1..SIZE))
  end
end

for i in 1..SIZE
  upcoming = Upcoming.create(title: Faker::Space.agency, place: Faker::Space.galaxy, main_youtube_id: "https://youtu.be/Xvjnoagk6GU", start_date: Date.new(2017,rand(1..12),rand(1..12)), end_date: Date.new(2017,rand(1..12),rand(1..12)),
                             ticket_url: 'www.naver.com', count_view: rand(1..100), count_share: rand(1..100))
  for i in 1..SIZE
    UpcomingArtist.create(upcoming_id: upcoming.id, artist_id: rand(1..SIZE))
    UpcomingComment.create(upcoming_id: upcoming.id, user_id: rand(1..SIZE), content: Faker::Hacker.say_something_smart)
    UpcomingLike.create(upcoming_id: upcoming.id, user_id: rand(1..SIZE))
  end
end
