class GifPresenterSerializer
  include FastJsonapi::ObjectSerializer
  set_id :object_id
  attributes :images
  
  attribute :images do |object|
    object.images
  end
end
