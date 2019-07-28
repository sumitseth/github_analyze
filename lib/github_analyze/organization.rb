module GithubAnalyze
  class Organization
    attr_reader :name, :client, :repositories, :languages

    def initialize(name:, client:)
      @name = name
      @client = client
      @languages = Hash.new(0)
      @repositories = []

      process!
    end

    def ranked_languages
      languages.sort_by { |k, v| -v }.map { |k, v| k }
    end

    def most_common_languages
      ranked_languages.first(5)
    end

    def least_common_languages
      ranked_languages.last(5)
    end

    private

    def process!
      start_cursor = nil
      loop do
        result = github_graphql(start_cursor: start_cursor)

        repos = result.data.organization.repositories.nodes

        repos.each do |repository|
          primary_language = repository.primary_language
          languages[primary_language.name] += 1 if primary_language
          repositories << repository
        end

        if result.data.organization.repositories.page_info.has_next_page
          start_cursor =
            result.data.organization.repositories.page_info.end_cursor
        else
          break
        end
      end
    end

    def github_graphql(start_cursor:)
      client.query <<~GRAPHQL
        query {
          organization(login: "#{name}") {
            repositories(first: 100, after: #{start_cursor}) {
              pageInfo {
                hasNextPage
                endCursor
              }
              nodes {
                name
                createdAt
                primaryLanguage {
                  name
                }
              }
            }
          }
        }
      GRAPHQL
    end
  end
end
