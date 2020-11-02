  class Api::V1::DriversController < ApplicationController
  
  private
    # Only allow a list of trusted parameters through.
    def driver_params
      params.require(:driver).permit(:name, :email, :phone_number, :license_number, :car_number)
    end
end
