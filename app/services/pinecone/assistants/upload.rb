class Pinecone::Assistants::Upload
  require 'httparty'
  require 'json'

  def initialize
    @headers = {
      "accept" => "application/json",
      "content-type" => "application/json",
      "Api-Key" => ENV["PINECONE_API_KEY"],
      "X-Pinecone-API-Version" => "2025-01"
    }
    @assistant_upload = ENV["ASSISTANT_URL"]
    @assistant_name = ENV["ASSISTANT_NAME"]
  end

  def upload_file
    endpoint = "#{@assistant_upload}/#{@assistant_name}"

    file_path = "products.json"
    File.open(file_path, "w") { |file| file.write(file_content.to_json) }

    response = nil

    File.open(file_path, "r") do |file|
      response = HTTParty.post(
        endpoint,
        headers: @headers,
        body: { file: file }
      )
    end

    File.delete(file_path) if File.exist?(file_path)
    JSON.parse(response.body)
  end

  private

  def file_content
    {
      "products": [
        {
          "id": 222,
          "name": "Handheld Frother 1ct DISC",
          "description": "Handheld Frother 1ct DISC DISC",
          "base_price": "4.25",
          "unit_price": [
            { "price_title": "National (Base) Price", "unit_price": "4.25" },
            { "price_title": "Motherhood Catalog Price", "unit_price": "4.25" },
            { "price_title": "Online Price (MAP)", "unit_price": "15.26" },
            { "price_title": "National Path Price", "unit_price": "3.83" }
          ]
        },
        {
          "id": 223,
          "name": "Swig Insulated Mug 18oz DISC",
          "description": "Swig Insulated Mug 18oz DISC DISC",
          "base_price": "13.05",
          "unit_price": [
            { "price_title": "National Path Price", "unit_price": "11.75" },
            { "price_title": "Online Price (MAP)", "unit_price": "28.76" },
            { "price_title": "Motherhood Catalog Price", "unit_price": "13.05" },
            { "price_title": "National (Base) Price", "unit_price": "13.05" }
          ]
        }
      ]
    }
  end
end
