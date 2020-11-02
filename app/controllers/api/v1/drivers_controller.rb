class Api::V1::DriversController < ApplicationController

  skip_before_action :verify_authenticity_token

  def register
    driver = Driver.new driver_params
    if driver.save
      render json: { id: driver.id,
                     name: driver.name,
                     email: driver.email,
                     phone_number: driver.phone_number,
                     license_number: driver.license_number,
                     car_number: driver.car_number
                    }, status: 201
    else
      render json: { status: "failure",
                     reason: driver.errors.full_messages
                    }, status: 400
    end
  rescue StandardError => e # rescue if any exception occurs
    render json: { status: "failure",
                   reason: "#{e}"
                  }, status: 400
  end

  def send_location
    driver = Driver.where(id: params[:id]).first
    if driver.present? && params[:latitude].present? && params[:longitude].present?
      driver.latitude = params[:latitude]
      driver.longitude = params[:longitude]
      if driver.save
        render json: { status: "success"
                      }, status: 202
      else
        render json: { status: "failure",
                       reason: driver.errors.full_messages
                      }, status: 400
      end
    else
      render json: { status: "failure",
                     reason: "Either the id provided is wrong or something is missing in params"
                    }, status: 400
    end
  rescue StandardError => e # rescue if any exception occurs
    render json: { status: "failure",
                   reason: "#{e}"
                  }, status: 400
  end
  
  private
    # Only allow a list of trusted parameters through.
    def driver_params
      params.permit(:name, :email, :phone_number, :license_number, :car_number, :latitude, :longitude)
    end
end
