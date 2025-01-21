class UserSerializer
  include JSONAPI::Serializer

  attributes :id, :username, :first_name, :last_name

  attribute :schedule do |user|
    user.users_shows.map do |user_show|
      {
        id: user_show.show.id,
        artist: user_show.show.artist,
        location: user_show.show.location,
        # time_slot: user_show.show.time_slot,
        image_url: user_show.show.image_url,
        favorited: user_show.favorited
      }
    end
  end
end
