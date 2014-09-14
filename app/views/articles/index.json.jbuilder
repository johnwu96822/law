json.array!(@articles) do |article|
  json.extract! article, :id, :content, :ancestry, :priority
  json.url article_url(article, format: :json)
end
