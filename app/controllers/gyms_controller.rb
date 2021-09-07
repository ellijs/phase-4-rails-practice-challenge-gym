class GymsController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
    rescue_from ActiveRecord::RecordInvalid, with: :render_invalid_response
    
    def index
        gyms = Gym.all
        render json: gyms, except: [:created_at, :updated_at]
    end
    
    def show
        gym = Gym.find(params[:id])
        render json: gym, except: [:created_at, :updated_at]
    end

    def create
        gym = Gym.create!(gym_params)
        render json: gym, status: :created
    end

    def update
        gym = Gym.find(params[:id])
        gym.update!(gym_params)
        render json: gym, status: :accepted
    end

    def destroy
        gym = Gym.find(params[:id])
        gym.destroy
        head :no_content, status: :deleted
    end
    
    private

    def gym_params
        params.permit(:name, :address)
    end
    
    def render_not_found_response
        render json: { error: "Gym not found" }, status: :not_found
    end
    
    def render_invalid_response invalid
        render json: { errors: invalid.record.errors }, status: :unprocessable_entity
    end
end
