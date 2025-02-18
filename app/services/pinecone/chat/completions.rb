class Pinecone::Chat::Completions
  require 'net/http'
  require 'uri'
  require 'json'
  require 'httparty'

  def initialize
    @headers =  {
      "accept" => "application/json",
      "content-type" => "application/json",
      "Api-Key" => ENV["PINECONE_API_KEY"]
    }
  end

  def list_and_generate_response(query)
    json_data = ProductData.file_content_json
    body = {
      "messages" => [
        { "role" => "user", "content" => query },
        { "role" => "assistant", "content" => "Here are the best products I found based on your query:" }
      ],
      "functions" => [
        {
          "name" => "generate_response",
          "parameters" => {
            "products" => json_data,
            "query" => query
          }
        }
      ]
    }
    endpoint = "https://prod-1-data.ke.pinecone.io/assistant/chat/#{ENV["ASSISTANT_NAME"]}/chat/completions"
    response = HTTParty.post(endpoint, headers: @headers, body: body.to_json)
    data = JSON.parse(response.body)
  end
end
