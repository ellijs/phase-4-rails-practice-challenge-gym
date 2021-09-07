class ClientsController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
    rescue_from ActiveRecord::RecordInvalid, with: :render_invalid_response
    
    def index
        clients = Client.all
        render json: clients, except: [:created_at, :updated_at]
    end
    
    def show
        client = Client.find(params[:id])
        render json: client, except: [:created_at, :updated_at], methods: :total_amount
    end

    def create
        client = Client.create!(client_params)
        render json: client, status: :created
    end

    def update
        client = Client.find(params[:id])
        client.update!(client_params)
        render json: client, status: :accepted
    end

    def destroy
        client = Client.find(params[:id])
        client.destroy
        head :no_content, status: :deleted
    end
    
    private

    def client_params
        params.permit(:name, :age)
    end
    
    def render_not_found_response
        render json: { error: "Client not found" }, status: :not_found
    end
    
    def render_invalid_response invalid
        render json: { errors: invalid.record.errors }, status: :unprocessable_entity
    end
end
