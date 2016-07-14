require_relative 'base_class'

class Users < Base

TABLE_NAME = 'users'

	def open_connection
		Base.open_connection(TABLE_NAME)
	end

	def add_user
		print "Enter id: "
		id = gets
		print "Enter name: "
		name = gets
		print "Enter password:  "
		password = gets
		print "Enter email: "
		email = gets
		print "Enter data: "
		data =  gets
		Base.add(id: id, 
	 		name: "'#{name}'",
	 		password: "'#{password}'",
	 		email: "'#{email}'",
	 		data: "'#{data}'")
	end
	
	def find_user
		response = Base.select('or', name: 'Stark', email: 'abrakad_22', id: '6')
		p response
		response.each do |row|
			p row
		end

			
	end
	
	def update_user
		Base.update('Stark', password: '707', email: 'qwerty')	
	end

	def delete_user 
		print "Enter name lines: "
		name = gets.chomp()
		response = Base.delete(name: "#{name}")
	end
end
