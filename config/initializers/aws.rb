CarrierWave.configure do |config|
  config.fog_provider = 'fog/aws'                                         # required
  config.fog_credentials = {
      provider:              'AWS',                                       # required
      aws_access_key_id:     ENV["AWS_Access_Key"],                       # required
      aws_secret_access_key: ENV["AWS_Secret_Access_Key"],                # required
      region:                'ap-northeast-2',                            # optional, defaults to 'us-east-1'
  }
  config.fog_directory  = 'livle'                                         # required
  config.fog_public     = false
end