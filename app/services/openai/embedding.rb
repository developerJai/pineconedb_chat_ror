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

  def create
    json_data = ProductData.file_content_json

    json_data[:products].each do |product|
      body = {
        "input": product[:name],
        "model": @model[:name],  
        "encoding_format": "float"
      }

      response = HTTParty.post(@endpoint, :headers => @headers, :body => body.to_json)
      @data = JSON.parse response.body
      embedding = @data['data'][0]['embedding']

      pinecone_vectors = {
          "id" => product[:id].to_s,
          "values" => embedding,
          "metadata" => {
            "product" => "#{product}"
          }
        }
      upsert = Openai::UpsertVectors.new
      upsert.vectors([pinecone_vectors])
    end  
  end
end
