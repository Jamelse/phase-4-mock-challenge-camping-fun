class CampersController < ApplicationController
rescue_from ActiveRecord::RecordNotFound, with: :camper_not_found_error_message
rescue_from ActiveRecord::RecordInvalid, with: :unprocessable_entity_error_message
  def index
    render json: Camper.all
  end

  def show
    camper = Camper.find(params[:id])
    render json: camper, serializer: CamperActivitiesSerializer
  end

  def create
    render json: Camper.create!(camper_params), status: :created
  end

  private 

  def camper_params
    params.permit(:name, :age)
  end

  def camper_not_found_error_message
    render json: { error: "Camper not found" }, status: :not_found
  end

  def unprocessable_entity_error_message(invalid)
    render json: { errors: invalid.record.errors }, status: :unprocessable_entity
  end
end
