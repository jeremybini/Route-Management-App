json.array!(@walls) do |wall|
  json.extract! wall, :id, :name, :wall_image, :gym
  json.url wall_url(wall, format: :json)
end
