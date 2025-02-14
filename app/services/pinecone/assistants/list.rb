class Pinecone::Assistants::List
  require 'net/http'
  require 'uri'
  require 'json'

  def initialize
  	@headers =  {
      "accept" => "application/json",
      "content-type" => "application/json",
      "Api-Key" =>  ENV["PINECONE_API_KEY"],
      "X-Pinecone-API-Version" => "2025-01"
    }
    @assistant_endpoint = ENV["ASSISTANT_LIST_URl"]
  end

  def list
    endpoint = "#{@assistant_endpoint}"
    response = HTTParty.get(endpoint, :headers => @headers)
    data = JSON.parse response.body
  end
end

