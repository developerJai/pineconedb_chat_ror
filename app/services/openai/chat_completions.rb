class Openai::ChatCompletions
  require 'httparty'
  require 'json'

  def initialize
    @headers = {
      "accept" => "application/json",
      "content-type" => "application/json",
      "Authorization" => "Bearer #{ENV["OPENAI_API_KEY"]}"
    }
  end

  def create(text)
    url = "https://api.openai.com/v1/chat/completions"
    
    json_data = ProductData.file_content_json
    
    body = {
      model: "gpt-4",
      messages: [
        {
          role: "system",
          content: "You are an AI assistant helping customers find the most relevant products. " \
                   "Please respond in a JSON format with 'product_ids' (array of strings) and 'response' (text)."
        },
        {
          role: "user",
          content: <<~PROMPT
            - **Customer Query**: "#{text}"
            - **Retrieved Product Data**:
            
            #{json_data}
            
            - Please return a JSON response with:
              - `product_ids`: An array of product IDs that match the query.
              - `response`: A short message summarizing the recommended products.
          PROMPT
        }
      ],
      temperature: 0.7,
      max_tokens: 500
    }

    response = HTTParty.post(url, headers: @headers, body: body.to_json)

    begin
      result = JSON.parse(response.body)
      response_content = result.dig("choices", 0, "message", "content")

      # Ensure response is valid JSON
      parsed_response = JSON.parse(response_content) rescue {}

      {
        product_ids: parsed_response["product_ids"] || [],
        response: parsed_response["response"] || "No response received"
      }
    rescue JSON::ParserError
      { error: "Invalid JSON format received from OpenAI" }
    rescue StandardError => e
      { error: e.message }
    end
  end
end
