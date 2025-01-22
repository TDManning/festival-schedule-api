class ShowSerializer
  include JSONAPI::Serializer

  attributes :id, :artist, :location, :time_slot, :image_url
end
