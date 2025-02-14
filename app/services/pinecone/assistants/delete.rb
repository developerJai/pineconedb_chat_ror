class Pinecone::Assistants::Delete
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
    @assistant_delete = ENV["ASSISTANT_URL"]
    @assistant_name = ENV["ASSISTANT_NAME"]
  end

  def delete(file_id)
    endpoint = "#{@assistant_delete}/#{@assistant_name}/#{file_id}"
    response = HTTParty.delete(endpoint, :headers => @headers)
    data = JSON.parse response.body
  end
end
