class ShowSerializer
  include JSONAPI::Serializer

  attributes :id, :artist, :location, :image_url
end
