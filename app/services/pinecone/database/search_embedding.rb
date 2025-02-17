class Pinecone::Database::SearchEmbedding
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

  def create(text)
    body = {
        "input": text,
        "model": @model[:name],  
        "encoding_format": "float"
      }

    response = HTTParty.post(@endpoint, :headers => @headers, :body => body.to_json)
    @data = JSON.parse response.body
    embedding = @data['data'][0]['embedding']
    pine = Pinecone::Database::Index.new
    results = pine.query(embedding)
  end
end