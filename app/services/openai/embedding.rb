class Openai::Embedding
  require 'httparty'
  require 'net/http'
  require 'uri'

  def initialize
    @headers =  {
      "Content-Type" => "application/json",
      "Authorization" => "Bearer #{ENV["OPENAI_API_KEY"] }"
    }

    @model = {
      name: "text-embedding-ada-002"
    }

    @endpoint = "https://api.openai.com/v1/embeddings"
  end

  def create(message)
    # Generate vector embeddings for message
    body = {
      "input": message,
      "model": @model[:name]
    }

    response = HTTParty.post(@endpoint, :headers => @headers, :body => body.to_json)
    @data = JSON.parse response.body
    embedding = @data['data'][0]['embedding']
    pinecone = Pinecone::Database::Index.new
    results = pinecone.query(embedding)
  end
end