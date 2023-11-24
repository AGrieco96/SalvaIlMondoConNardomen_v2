Koala.configure do |config|
  config.access_token = ENV['KOALA_TOKEN']
  config.app_access_token = '445360272621130|riYSQFSHCuogQWYNzK7l2twfX0U'
  config.app_id = '445360272621130'
  config.app_secret = ENV["FB_SECRET_KEY"]
  # See Koala::Configuration for more options, including details on how to send requests through
  # your own proxy servers.
end