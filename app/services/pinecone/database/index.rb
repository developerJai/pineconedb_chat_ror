class Pinecone::Database::Index
  require 'httparty'
  require 'net/http'
  require 'uri'

  def initialize
    @headers =  {
      "accept" => "application/json",
      "content-type" => "application/json",
      "Api-Key" =>  ENV["PINECONE_API_KEY"]
    }
  
    @index_endpoint = ENV["PINECONE_DB_URl"]
  end

  def query query_vector_arr
    endpoint = "#{@index_endpoint}/query"
     body = {
      "vector" => query_vector_arr,
      "topK" => 50,
      "includeValues" => false,
      "includeMetadata": true
    }
    response = HTTParty.post(endpoint, :headers => @headers, :body => body.to_json)
    data = JSON.parse response.body
    data['matches']
  end
end