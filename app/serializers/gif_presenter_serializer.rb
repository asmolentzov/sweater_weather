class GifPresenterSerializer
  include FastJsonapi::ObjectSerializer
  set_id :object_id
  
  attribute :images do |object|
    object.images
  end
  
  attributes :copyright
end
