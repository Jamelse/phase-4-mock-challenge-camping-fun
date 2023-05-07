class SignupsController < ApplicationController
rescue_from ActiveRecord::RecordInvalid, with: :unprocessable_entity_error_message

  def create
    new_signup = Signup.create!(signup_params)
    render json: new_signup, status: :created
  end 

  private

  def signup_params
    params.permit(:time, :camper_id, :activity_id)
  end

  def unprocessable_entity_error_message(invalid)
    render json: { errors: invalid.record.erros }, status: :unprocessable_entity
  end
end
