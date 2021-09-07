class MembershipsController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
    rescue_from ActiveRecord::RecordInvalid, with: :render_invalid_response
    
    def index
        memberships = Membership.all
        render json: memberships, except: [:created_at, :updated_at]
    end
    
    def show
        membership = Membership.find(params[:id])
        render json: membership, except: [:created_at, :updated_at]
    end

    def create
            membership = Membership.create!(membership_params)
            render json: membership, status: :created
    end

    def update
        membership = Membership.find(params[:id])
        membership.update!(membership_params)
        render json: membership, status: :accepted
    end

    def destroy
        membership = Membership.find(params[:id])
        membership.destroy
        head :no_content, status: :deleted
    end
    
    private

    def membership_params
        params.permit(:gym_id, :client_id, :charge)
    end
    
    def render_not_found_response
        render json: { error: "Membership not found" }, status: :not_found
    end
    
    def render_invalid_response invalid
        render json: { errors: invalid.record.errors }, status: :unprocessable_entity
    end
end
