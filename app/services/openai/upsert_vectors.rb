class Openai::UpsertVectors
  require 'httparty'
  require 'net/http'
  require 'uri'

  def initialize
    @headers =  {
      "accept" => "application/json",
      "content-type" => "application/json",
      "Api-Key" =>  ENV["PINECONE_API_KEY"],
      "X-Pinecone-API-Version" => "2025-01"
    }
    @pinecone_db_url = ENV["PINECONE_DB_URl"]
  end

  def vectors(vectors_data_arr)
    endpoint = "#{@pinecone_db_url}/vectors/upsert"
    body = {
      "vectors" => vectors_data_arr
    }
    response = HTTParty.post(endpoint, :headers => @headers, :body => body.to_json)
    @data = JSON.parse response.body
  end
end