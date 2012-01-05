require 'yaml'
require 'json'
require 'net/http'

class Github::Client

	def self.open file
		credentials = YAML::load_file file
		self.new credentials['user'], credentials['password']
	end

	def initialize user, password
		@user = user
		@password = password
	end

	def create repository
		response = request :post, "/user/repos", repository.to_json

		response.code == '201' and 
			Github::Repository.new(JSON.parse response.body) or
			raise "repository already exists"
	end


	private

	def request method, resource, payload = nil
		uri = URI('https://api.github.com' + resource)
		request = case method
		when :get
			Net::HTTP::Get.new(uri.request_uri)
		when :post
			Net::HTTP::Post.new(uri.request_uri)
		when :patch
			Net::HTTP::Patch.new(uri.request_uri)
		when :delete
			Net::HTTP::Delete.new(uri.request_uri)
		else
			raise "method not supported"
		end
		request.basic_auth @user, @password
		request.body = payload

		response = Net::HTTP.start(uri.host, uri.port, 
							  :use_ssl => uri.scheme == 'https') do |http|
			http.request(request)
		end
		response

	end
end
