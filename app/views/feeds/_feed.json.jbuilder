json.extract! feed, :id, :title, :content, :image, :created_at, :updated_at
json.url feed_url(feed, format: :json)
