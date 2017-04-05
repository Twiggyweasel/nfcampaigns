json.array!(@images) do |image|
  json.title image.name
  json.value root_url+image.image.url
end