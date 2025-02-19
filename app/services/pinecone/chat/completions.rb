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
    @assistant_name = "chat-completion" #"testing-pdf-data" 
  end

  def list_and_generate_response(query)
    json_data = ProductData.file_content_json
  
     prompt = <<~PROMPT
      You are an AI assistant helping customers find the most relevant products. Based on the customers message below, generate a structured response:

      User Message: "#{query}"

      Relevant Products:
      #{json_data}

      Generate a JSON response with:
      - "product_ids": List of relevant product IDs.
      - "formatted_message": A customer-friendly response summarizing the products.

      Response:
    PROMPT

    body = {
      model: "gpt-4o",
      messages: [
        { role: "user", content: prompt }
      ],
      response_format: "json"
    }

    endpoint = "https://prod-1-data.ke.pinecone.io/assistant/chat/#{@assistant_name}/chat/completions"
    response = HTTParty.post(endpoint, headers: @headers, body: body.to_json)

    parsed_response = JSON.parse(response.body)
    p "parsed_response================="
    p parsed_response
    if parsed_response["choices"] && parsed_response["choices"][0] && parsed_response["choices"][0]["message"]["content"]
      content = parsed_response["choices"][0]["message"]["content"]
      content = content.gsub(/```json|```/, "").strip

      JSON.parse(content) # Extract JSON
    else
      { error: "Invalid response from API" }
    end
  rescue JSON::ParserError => e
    puts "JSON Parsing Error: #{e.message}"
    { error: "Invalid response from API" }
  end
end
