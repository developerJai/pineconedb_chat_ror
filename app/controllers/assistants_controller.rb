class AssistantsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    assistants = Pinecone::Assistants::List.new
    results = assistants.list
    render json: { results: results }
  rescue StandardError => e
    Rails.logger.error("Error: #{e.message}")
    render json: { error: "Internal server error" }, status: :internal_server_error
  end

  def upload 	
  	assistant = Pinecone::Assistants::Upload.new
    results = assistant.upload_file
    render json: { results: results }
  rescue StandardError => e
    Rails.logger.error("Error: #{e.message}")
    render json: { error: "Internal server error" }, status: :internal_server_error
  end

  def delete
    unless params[:file_id].present?
      render json: { error: "No file_id provided" }, status: :bad_request
      return
    end

    assistant = Pinecone::Assistants::Delete.new
    results = assistant.delete(params[:file_id])
    render json: { results: results }
    
  rescue StandardError => e
    Rails.logger.error("Error: #{e.message}")
    render json: { error: "Internal server error" }, status: :internal_server_error
  end
end
