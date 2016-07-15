require 'pg'

class Base

DB_NAME = 'Users'
DB_USER = 'abrakad_22'

	class << self

		def connection
			PG.connect :dbname => "#{DB_NAME}" , :user => "#{DB_USER}"
		end

		def add(**options)
			query = "INSERT INTO #{table_name} VALUES("
			options.each{ |k,v| 
				query = query << "'#{v}'" <<','}
			query = query.chomp(",")
			connection.exec "#{query<<')'}"
			close_connection
		end  

		def select(logic_operation=nil, **options)
			query = "SELECT * FROM #{table_name} WHERE"
			options.each{ | k,v |
				query = query << " #{k}" << " = " << "'#{v}'" << " #{logic_operation}" }
			query = query.chomp(logic_operation)
			return connection.exec "#{query}"
			close_connection		
		end

		def update(name, **options ) 
			query = "UPDATE #{table_name} SET" 
			options.each{ | k,v |
				query = query << " #{k}" << " = " << "'#{v}'" << " , " }
			query = query.chomp(' , ')
			query = query << "WHERE "<< "name='#{name}'" 
			connection.exec "#{query}"
			close_connection
				
		end

		def delete(**options)
			query = "DELETE FROM #{table_name} WHERE"
			options.each{ | k,v |
				query = query << " #{k}" << " = " << "'#{v}'"}
			response = connection.exec "#{query}"
			close_connection
		end
		
		def close_connection
			connection.close
		end

		def table_name
			self.name
		end
	end
end

