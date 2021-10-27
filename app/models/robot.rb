class Robot < ApplicationRecord

	def execute_commands(robot, moves)
		x, y = robot.x_position, robot.y_position
		face = robot.facing
		moves.first.split(", ").each do |move|
			if move == "MOVE" && face == "NORTH"
				y+=1
				y.negative? || y > robot.max_y ? y-=-1 : y
			elsif move == "LEFT" && face == "NORTH"
				face = "WEST"
			elsif move == "RIGHT" && face == "NORTH"
				face= "EAST"
			elsif move == "MOVE" && face == "EAST"
				x+=1
				x.negative? || x > robot.max_x ? x-=-1 : x
			elsif move == "LEFT" && face == "EAST"
				face = "NORTH"
			elsif move == "RIGHT" && face == "EAST"
				face = "SOUTH"
			elsif move == "RIGHT" && face == "SOUTH"
				face = "EAST"
			elsif move == "LEFT" && face == "SOUTH"
				face = "WEST"
			elsif move == "MOVE" && face == "WEST"
				x-=1
				x.negative? || x > robot.max_x ? x-=-1 : x 
			elsif move == "MOVE" && face == "SOUTH"
				y-= 1
				y.negative || y > robot.max_y ? y-=-1 : y
			end
		end
		if (y.negative? || x.negative?) || (y > robot.max_y || x > robot.max_x) 
			false
		else
			robot.update_attributes(x_position: x, y_position: y, facing: face)
			true
		end
	end
end
