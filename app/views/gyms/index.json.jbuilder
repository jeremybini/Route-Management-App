json.array!(@gyms) do |gym|
  json.extract! gym, :id, :name, :location, :gym_image
  json.url gym_url(gym, format: :json)
end
