require_relative 'base_class'

class Cars < Base

TABLE_NAME = 'cars'

	def open_connection
		Base.open_connection(TABLE_NAME)
	end

	def add_car
		print "Enter id: "
		id = gets
		print "Enter name: "
		name = gets
		print "Enter price:  "
		price = gets
		print "Enter power: "
		power = gets
		Base.add(id: id, 
	 		name: "'#{name}'",
	 		price: "'#{price}'",
	 		power: "'#{power}'")
	end
	
	def find_car
		response = Base.select('or', name: 'Volvo', price: '250000', power: '250')
		p response
		response.each do |row|
			p row
		end		
	end
	
	def update_car
		Base.update('Skoda',price: '220000')	
	end

	def delete_car 
		print "Enter name lines: "
		name = gets.chomp()
		Base.delete(name: "#{name}")
	end
end
