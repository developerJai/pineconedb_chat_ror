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
            { "price_title": "1. National (Base) Price", "unit_price": "4.25" },
            { "price_title": "5. Motherhood Catalog Price", "unit_price": "4.25" },
            { "price_title": "Online Price (MAP)", "unit_price": "15.26" },
            { "price_title": "2. National Path Price", "unit_price": "3.83" }
          ]
        },
        {
          "id": 223,
          "name": "Swig Insulated Mug 18oz DISC",
          "description": "Swig Insulated Mug 18oz DISC DISC",
          "base_price": "13.05",
          "unit_price": [
            { "price_title": "2. National Path Price", "unit_price": "11.75" },
            { "price_title": "Online Price (MAP)", "unit_price": "28.76" },
            { "price_title": "5. Motherhood Catalog Price", "unit_price": "13.05" },
            { "price_title": "1. National (Base) Price", "unit_price": "13.05" }
          ]
        },
        {
          "id": 225,
          "name": "DISC Vanilla Syrup 16oz",
          "description": "DISC Vanilla Syrup 16oz",
          "base_price": "27.73",
          "unit_price": [
            { "price_title": "Online Price (MAP)", "unit_price": "24.56" },
            { "price_title": "1. National (Base) Price", "unit_price": "27.73" },
            { "price_title": "1. National (Base) Price", "unit_price": "27.73" },
            { "price_title": "2. National Path Price", "unit_price": "23.71" },
            { "price_title": "Online Price (MAP)", "unit_price": "24.56"},
            { "price_title": "2. National Path Price", "unit_price": "24.96"}
          ]
        },
        {
          "id": 226,
          "name": "Rose Gold Swig Insulated Wine Tumbler 12oz DISC",
          "description": "Rose Gold Swig Insulated Wine Tumbler 12oz DISC",
          "base_price": "21.95",
          "unit_price": [
            { "price_title": "Online Price (MAP)", "unit_price": "19.76" },
            { "price_title": "Online Price (MAP)", "unit_price": "19.76" },
            { "price_title": "2. National Path Price", "unit_price": "19.76" },
            { "price_title": "2. National Path Price", "unit_price": "18.77" },
            { "price_title": "1. National (Base) Price", "unit_price": "21.95" },
            { "price_title": "1. National (Base) Price", "unit_price": "21.95" }
          ]
        },
        {
          "id": 227,
          "name": "Swig Mug Infuser 1ct DISC",
          "description": "Swig Mug Infuser 1ct DISC DISC",
          "base_price": "5.85",
          "unit_price": [
            { "price_title": "1. National (Base) Price", "unit_price": "5.85" },
            { "price_title": "2. National Path Price", "unit_price": "5.27" },
            { "price_title": "Online Price (MAP)", "unit_price": "10.24" },
            { "price_title": "5. Motherhood Catalog Price", "unit_price": "5.85" }
          ]
        },
        {
          "id": 228,
          "name": "Lemon Ginger Tea 20bags",
          "description": "Lemon Ginger Tea 20bags",
          "base_price": "5.81",
          "unit_price": [
            { "price_title": "3. Local Base Price", "unit_price": "4.2" },
            { "price_title": "3. Local Base Price", "unit_price": "4.2" },
            { "price_title": "3. Local Base Price", "unit_price": "4.2" },
            { "price_title": "3. Local Base Price", "unit_price": "4.2" },
            { "price_title": "4. Local Path Price", "unit_price": "3.78" },
            { "price_title": "4. Local Path Price", "unit_price": "3.78" },
            { "price_title": "4. Local Path Price", "unit_price": "3.59" },
            { "price_title": "4. Local Path Price", "unit_price": "3.59" },
            { "price_title": "Online Price (MAP)", "unit_price": "4.41" },
            { "price_title": "Online Price (MAP)", "unit_price": "4.41" },
            { "price_title": "Online Price (MAP)", "unit_price": "4.41" },
            { "price_title": "2. National Path Price", "unit_price": "5.23" },
            { "price_title": "2. National Path Price", "unit_price": "5.23" },
            { "price_title": "2. National Path Price", "unit_price": "4.97" },
            { "price_title": "2. National Path Price", "unit_price": "4.97" },
            { "price_title": "1. National Path Price", "unit_price": "5.81" },
            { "price_title": "1. National Path Price", "unit_price": "5.81" },
            { "price_title": "1. National Path Price", "unit_price": "4.81" },
            { "price_title": "1. National Path Price", "unit_price": "4.81" },
            { "price_title": "Online Price (MAP)", "unit_price": "4.71" }
          ]
        },
        {
          "id": 230,
          "name": "Stainless Steel Turner 1ct DISC",
          "description": "Stainless Steel Turner 1ct DISC DISC",
          "base_price": "10.21",
          "unit_price": [
            { "price_title": "Online Price (MAP)", "unit_price": "17.87" },
            { "price_title": "2. National Path Price", "unit_price": "9.19" },
            { "price_title": "1. National (Base) Price", "unit_price": "10.21" },
            { "price_title": "5. Motherhood Catalog Price", "unit_price": "10.21" }
          ]
        },
        {
          "id": 231,
          "name": "Basting Brush 1ct DISC",
          "description": "Basting Brush 1ct DISC DISC",
          "base_price": "7.6",
          "unit_price": [
            { "price_title": "5. Motherhood Catalog Price", "unit_price": "7.6" },
            { "price_title": "1. National (Base) Price", "unit_price": "7.6" },
            { "price_title": "2. National Path Price", "unit_price": "6.84" },
            { "price_title": "Online Price (MAP)", "unit_price": "13.19" }
          ]
        },
        {
          "id": 233,
          "name": "Kitchen Towels 6ct DISC",
          "description": "Kitchen Towels 6ct DISC",
          "base_price": "14.49",
          "unit_price": [
            { "price_title": "1. National (Base) Price", "unit_price": "14.49" },
            { "price_title": "2. National Path Price", "unit_price": "13.04" },
            { "price_title": "Online Price (MAP)", "unit_price": "13.04" },
            { "price_title": "5. Motherhood Catalog Price", "unit_price": "14.49" }
          ]
        },
        {
          "id": 236,
          "name": "Garlic Parmesan Popcorn Seasoning 5.25oz DISC",
          "description": "Garlic Parmesan Popcorn Seasoning 5.25oz DISC DISC",
          "base_price": "1.95",
          "unit_price": [
            { "price_title": "1. National (Base) Price", "unit_price": "1.95" },
            { "price_title": "2. National Path Price", "unit_price": "1.76" },
            { "price_title": "Online Price (MAP)", "unit_price": "3.42" },
            { "price_title": "5. Motherhood Catalog Price", "unit_price": "1.95" }
          ]
        },
        {
          "id": 237,
          "name": "Natural Bath Bomb (Love Me) 1ct DISC",
          "description": "Natural Bath Bomb (Love Me) 1ct DISC DISC",
          "base_price": "2.7",
          "unit_price": [
            { "price_title": "5. Motherhood Catalog Price", "unit_price": "2.7" },
            { "price_title": "Online Price (MAP)", "unit_price": "4.73" },
            { "price_title": "1. National (Base) Price", "unit_price": "2.7" },
            { "price_title": "2. National Path Price", "unit_price": "2.43" }
          ]
        },
        {
          "id": 238,
          "name": "Natural Bath Salts (Lavender) 16oz DISC",
          "description": "Natural Bath Salts (Lavender) 16oz DISC DISC",
          "base_price": "4.5",
          "unit_price": [
            { "price_title": "5. Motherhood Catalog Price", "unit_price": "4.5" },
            { "price_title": "Online Price (MAP)", "unit_price": "7.88" },
            { "price_title": "2. National Path Price", "unit_price": "4.05" },
            { "price_title": "1. National (Base) Price", "unit_price": "4.5" }
          ]
        },
        {
          "id": 239,
          "name": "Hair Wrap Towel 1ct DISC",
          "description": "Hair Wrap Towel 1ct DISC DISC",
          "base_price": "19.99",
          "unit_price": [
            { "price_title": "Online Price (MAP)", "unit_price": "18.12" },
            { "price_title": "2. National Path Price", "unit_price": "17.99" },
            { "price_title": "1. National (Base) Price", "unit_price": "19.99" },
            { "price_title": "5. Motherhood Catalog Price", "unit_price": "10.35" }
          ]
        },
        {
          "id": 240,
          "name": "Desert Essence Cucumber Charcoal Face Mask 3.4oz DISC",
          "description": "Desert Essence Cucumber Charcoal Face Mask 3.4oz DISC DISC",
          "base_price": "4.42",
          "unit_price": [
            { "price_title": "Online Price (MAP)", "unit_price": "7.73" },
            { "price_title": "5. Motherhood Catalog Price", "unit_price": "4.42" },
            { "price_title": "2. National Path Price", "unit_price": "3.98" },
            { "price_title": "1. National (Base) Price", "unit_price": "4.42" }
          ]
        },
        {
          "id": 243,
          "name": "Raw Steel Beard & Stache Oil 2oz DISC",
          "description": "Raw Steel Beard & Stache Oil 2oz DISC DISC",
          "base_price": "5.4",
          "unit_price": [
            { "price_title": "1. National (Base) Price", "unit_price": "5.4" },
            { "price_title": "2. National Path Price", "unit_price": "4.86" },
            { "price_title": "Online Price (MAP)", "unit_price": "9.45" },
            { "price_title": "5. Motherhood Catalog Price", "unit_price": "5.4" }
          ]
        },
        {
          "id": 247,
          "name": "Vitamin B-12 Energy Booster Spray .85oz",
          "description": "Vitamin B-12 Energy Booster Spray .85oz",
          "base_price": "23.55",
          "unit_price": [
            { "price_title": "1. National (Base) Price", "unit_price": "23.55" },
            { "price_title": "1. National (Base) Price", "unit_price": "23.55" },
            { "price_title": "Online Price (MAP)", "unit_price": "20.87" },
            { "price_title": "2. National Path Price", "unit_price": "21.2" },
            { "price_title": "Online Price (MAP)", "unit_price": "20.87" },
            { "price_title": "2. National Path Price", "unit_price": "20.14" }
          ]
        },
        {
          "id": 248,
          "name": "Extra Strength Carnitine Liquid, 16 oz DISC",
          "description": "Extra Strength Carnitine Liquid, 16 oz DISC",
          "base_price": "27.73",
          "unit_price": [
            { "price_title": "1. National (Base) Price", "unit_price": "27.73" },
            { "price_title": "1. National (Base) Price", "unit_price": "27.73" },
            { "price_title": "2. National Path Price", "unit_price": "23.71" },
            { "price_title": "2. National Path Price", "unit_price": "24.96" },
            { "price_title": "Online Price (MAP)", "unit_price": "24.56" },
            { "price_title": "Online Price (MAP)", "unit_price": "24.56" }
          ]
        },
        {
          "id": 249,
          "name": "Gaba, 100 caps",
          "description": "Gaba, 100 caps",
          "base_price": "6.69",
          "unit_price": [
            { "price_title": "1. National (Base) Price", "unit_price": "9.69" },
            { "price_title": "1. National (Base) Price", "unit_price": "9.69" },
            { "price_title": "2. National Path Price", "unit_price": "8.28" },
            { "price_title": "2. National Path Price", "unit_price": "8.72" },
            { "price_title": "Online Price (MAP)", "unit_price": "8.54" },
            { "price_title": "Online Price (MAP)", "unit_price": "8.54" }
          ]
        },
        {
          "id": 250,
          "name": "GL-Lysine 500mg, 100 caps",
          "description": "L-Lysine 500mg, 100 caps",
          "base_price": "8.44",
          "unit_price": [
            { "price_title": "1. National (Base) Price", "unit_price": "8.44" },
            { "price_title": "1. National (Base) Price", "unit_price": "8.44" },
            { "price_title": "2. National Path Price", "unit_price": "7.22" },
            { "price_title": "2. National Path Price", "unit_price": "7.6" },
            { "price_title": "Online Price (MAP)", "unit_price": "7.37" },
            { "price_title": "Online Price (MAP)", "unit_price": "7.37" }
          ]
        },
        {
          "id": 251,
          "name": "Beard Care kIt DISC",
          "description": "Beard Care kIt DISC DISC",
          "base_price": "13.05",
          "unit_price": [
            { "price_title": "1. National (Base) Price", "unit_price": "13.05" },
            { "price_title": "5. Motherhood Catalog Price", "unit_price": "13.05" },
            { "price_title": "Online Price (MAP)", "unit_price": "0" },
            { "price_title": "2. National Path Price", "unit_price": "11.75" }
          ]
        },
        {
          "id": 252,
          "name": "Vitamin A 25,000 IU 250sg",
          "description": "GVitamin A 25,000 IU 250sg",
          "base_price": "15.24",
          "unit_price": [
            { "price_title": "1. National (Base) Price", "unit_price": "15.24" },
            { "price_title": "1. National (Base) Price", "unit_price": "15.24" },
            { "price_title": "2. National Path Price", "unit_price": "13.03" },
            { "price_title": "2. National Path Price", "unit_price": "13.72" },
            { "price_title": "Online Price (MAP)", "unit_price": "17.71" },
            { "price_title": "Online Price (MAP)", "unit_price": "17.71" }
          ]
        }
      ]
    }
  end
end
