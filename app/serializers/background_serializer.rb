class BackgroundSerializer
  include FastJsonapi::ObjectSerializer
  set_id :object_id
  attributes :image_url
end
