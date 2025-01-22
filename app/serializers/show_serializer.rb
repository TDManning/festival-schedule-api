class ShowSerializer
  include JSONAPI::Serializer

  attributes :id, :artist, :location, :time_slot, :image_url, :favorited

  attribute :favorited do |show, params|
    params[:user]&.favorites&.exists?(show.id) || false
  end
end