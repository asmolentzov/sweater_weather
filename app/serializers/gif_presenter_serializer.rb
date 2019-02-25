class GifPresenterSerializer
  include FastJsonapi::ObjectSerializer
  set_id :object_id
  attributes :images
end
