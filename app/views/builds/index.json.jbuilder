json.array!(@builds) do |build|
  json.extract! build, :id
  json.url build_url(build, format: :json)
end
