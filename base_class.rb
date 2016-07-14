require 'pg'

class Base

DB_NAME = 'Users'
DB_USER = 'abrakad_22'

	class << self
		def open_connection(table_name)
			@con = PG.connect :dbname => "#{DB_NAME}" , :user => "#{DB_USER}"
			@table_name = table_name
		end

		def add(**options)
			query = "INSERT INTO #{@table_name} VALUES("
			options.each{ |k,v| 
				query = query << "#{v}" <<','}
			query = query.chomp(",")
			@con.exec "#{query<<')'}"
			close_connection
		end  

		def select(logic_operation=nil, **options)
			query = "SELECT * FROM #{@table_name} WHERE"
			options.each{ | k,v |
				query = query << " #{k}" << " = " << "'#{v}'" << " #{logic_operation}" }
			query = query.chomp(logic_operation)
			return @con.exec "#{query.chomp(logic_operation)}"
			close_connection		
		end

		def update(logic_operation=',',name, **options ) 
			query = "UPDATE #{@table_name} SET" 
			options.each{ | k,v |
				query = query << " #{k}" << " = " << "'#{v}'" << " #{logic_operation}" }
			query = query.chomp(logic_operation)
			query = query << "WHERE "<< "name='#{name}'" 
			@con.exec "#{query}"
			close_connection
				
		end

		def delete(**options)
			query = "DELETE FROM #{@table_name} WHERE"
			options.each{ | k,v |
				query = query << " #{k}" << " = " << "'#{v}'"}
			@con.exec "#{query}"
			close_connection
		end
		
		def close_connection
			@con.close
		end
	end
end

