if Rails.env.production?

  ENV["ELASTICSEARCH_URL"] = "https://search-livle-ctg6jm3f65tpyzgtdoymtuo3s4.ap-northeast-2.es.amazonaws.com"

  Searchkick.aws_credentials = {
    access_key_id: ENV["AWS_EB_KEY"],
    secret_access_key: ENV["AWS_EB_SECRET"],
    region: "ap-northeast-2"
  }

end
