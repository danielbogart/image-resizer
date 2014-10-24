json.array!(@image_files) do |image_file|
  json.extract! image_file, :id, :name, :height, :width
  json.url image_file_url(image_file, format: :json)
end
