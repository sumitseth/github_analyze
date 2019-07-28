require 'graphlient'
require 'pry'

module GithubAnalyze
  class Client
    def initialize(github_authentication_token:)
      @github_authentication_token = github_authentication_token
    end

    def organization(name:)
      GithubAnalyze::Organization.new(name: name, client: graphql_client)
    end

    private

    def graphql_client
      Graphlient::Client.new(
        'https://api.github.com/graphql',
        {
          headers: {
            'Authorization' => "bearer #{@github_authentication_token}"
          }
        }
      )
    end
  end
end
