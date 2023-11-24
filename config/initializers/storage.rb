CarrierWave.configure do |config|
  config.fog_credentials = {
      provider:              'AWS',
      aws_access_key_id:     ENV["S3_ACCESS_KEY"],
      aws_secret_access_key: ENV["S3_SECRET_KEY"],
      region: 'eu-central-1'
  }
  config.storage = :fog
  config.fog_directory  = "nardomen"
  config.fog_public     = false
end



