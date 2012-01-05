Gem::Specification.new do |gem|
	gem.name    = "github-cli"
	gem.version = "3"

	gem.authors     = ["Martin Knoll"]
	gem.email       = "martinknoll@me.com"
	gem.homepage    = "https://github.com/maknoll/github-cli"
	gem.summary     = "Github Command Line Interface"
	gem.description = "This allows using Github via shell commands similar to the Heroku CLI"
	gem.executables = "github"

	gem.files = 
		["bin/github", "README.md", "lib/github-cli.rb"] +
		Dir['lib/github-cli/*.rb']
	gem.add_dependency "json"
end
