class Api::V1::PassengersController < ApplicationController
	def available_cabs
    if params[:latitude].present? && params[:longitude].present?
			cabbies = cabbies_around_me(params[:latitude].to_f, params[:longitude].to_f, 4000)
      if cabbies.present?
        render json: { available_cabs: cabbies.map { |cabbie| {
												name: cabbie.name,
												car_number: cabbie.car_number,
												phone_number: cabbie.phone_number
												}
											 }
                      }, status: 200
      else
        render json: { message: "No cabs available!"
                      }, status: 200
      end
    else
      render json: { status: "failure",
                     reason: "Both latitude and longitude need to be provided in params"
                    }, status: 400
    end
  rescue StandardError => e # rescue if any exception occurs
    render json: { status: "failure",
                   reason: "#{e}"
                  }, status: 400
	end
	
	private
		def	cabbies_around_me(latitude, longitude, max_reach)
			distance_finder = DistanceFinder.new
			cabbies = Driver.all
			cabbies_around_me = cabbies.select { |c| distance_finder.distance([latitude, longitude], [c.latitude, c.longitude]) < max_reach }
		end
end
