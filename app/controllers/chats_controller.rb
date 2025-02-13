class ChatsController < ApplicationController
  skip_before_action :verify_authenticity_token
  
  def chat
    unless params[:message].present?
      render json: { error: "No message provided" }, status: :bad_request
      return
    end

    embedding = Openai::Embedding.new
    results = embedding.create(params[:message])
    render json: { results: results }
    
  rescue StandardError => e
    Rails.logger.error("Error in chat: #{e.message}")
    render json: { error: "Internal server error" }, status: :internal_server_error
  end
end