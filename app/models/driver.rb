class Driver < ApplicationRecord
	validates :name, presence: true
	validates :email, presence: true, uniqueness: true
	validates :phone_number, presence: true, uniqueness: true, length: { is: 10 }
	validates :license_number, presence: true, uniqueness: true
	validates :car_number, presence: true, uniqueness: true
end
