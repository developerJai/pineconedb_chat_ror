class ChatsController < ApplicationController
  skip_before_action :verify_authenticity_token
  
  def embed_upsert
    embedding = Openai::Embedding.new
    results = embedding.create
    render json: { results: results }
    
  rescue StandardError => e
    Rails.logger.error("Error: #{e.message}")
    render json: { error: "Internal server error" }, status: :internal_server_error
  end

  def search
    unless params[:text].present?
      render json: { error: "No text provided" }, status: :bad_request
      return
    end
    search_text = Pinecone::Database::SearchEmbedding.new
    results = search_text.create(params[:text])
    render json: { results: results }
    
  rescue StandardError => e
    Rails.logger.error("Error: #{e.message}")
    render json: { error: "Internal server error" }, status: :internal_server_error
  end

  def openai_chat_completions
    unless params[:text].present?
      render json: { error: "No text provided" }, status: :bad_request
      return
    end

    chat_completion = Openai::ChatCompletions.new
    results = chat_completion.create(params[:text])
    render json: { results: results }
    
  rescue StandardError => e
    Rails.logger.error("Error: #{e.message}")
    render json: { error: "Internal server error" }, status: :internal_server_error
  end

  def pine_chat_completions

    unless params[:text].present?
      render json: { error: "No text provided" }, status: :bad_request
      return
    end

    pinecone_chat = Pinecone::Chat::Completions.new
    results = pinecone_chat.list_and_generate_response(params[:text])
    render json: { results: results }
    
  rescue StandardError => e
    Rails.logger.error("Error: #{e.message}")
    render json: { error: "Internal server error" }, status: :internal_server_error
  end
end