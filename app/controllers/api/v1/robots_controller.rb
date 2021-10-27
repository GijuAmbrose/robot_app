class Api::V1::RobotsController < ApplicationController

	def index 
		@robots = Robot.all
	end

	def create
		@robot = Robot.new(robots_params)
		if @robot.save
			render json: {robot: @robot }, status: 200
		else
			render json: {status: 400}
		end
	end

	def orders
		robot = Robot.find(params[:id])
		placing_bot = params[:commands].first.split(", ")
		if placing_bot.first == "PLACE"
			moving_coordinates = placing_bot.second.split(",")
			x_position = moving_coordinates.first.to_i
			y_position = moving_coordinates.second.to_i
			face = placing_bot.last
			if x_position.negative?  || y_position.negative?
				render json: {error: "Bot will fall in this position", status: 400}
			else
				robot.update_attributes(x_position: x_position, y_position: y_position, facing: face)
				params[:commands].shift
				execute = Robot.new.execute_commands(robot, params[:commands])
				if execute == true && params[:commands].last == "REPORT"
					render json: {location: [robot.x_position, robot.y_position, robot.facing]}, status: 200
				elsif execute == false
					render json: {error: "Bot will fall off, cannot place in this position"}, status: 400
				end
			end
		else
			render json: {error: "Place the bot first"}, status: 400
		end

	end




	private

	def robots_params
		params.require(:robot).permit(:x_position, :y_position, :facing, :max_x, :max_y)
	end
end
