class Github::Repository

	attr_accessor :name, :description, :homepage, :private, :ssh_url

	def initialize repository
		case repository
		when String
			@ssh_url = repo
			@owner, @name = repo.scan(/:(.*)\/(.*).git/)[0]
		when Hash
			repository.each {|k,v| instance_variable_set("@#{k}",v)}
		end
	end

	def to_json
		{:name=>@name}.to_json
	end
end
