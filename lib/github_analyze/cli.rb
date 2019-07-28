require 'thor'
require 'csv'
require 'github_analyze'

module GithubAnalyze
  class Cli < Thor
    desc 'stats ORGANIZATION', 'report language stats for said organization'
    def stats(organization)
      languages = []
      languages << ['Rank', 'Language', 'Repo Count']
      
      client
        .organization(name: organization)
        .ranked_languages
        .each.with_index { |l, i| languages << [i, l[0], l[1]] }
        
      print_table languages
    end

    desc 'csv ORGANIZATION ABSOLUTE_FILE_PATH','generate CSV of most common languages by repo count'
    def csv(organization, file_path)
      CSV.open(file_path, 'wb') do |csv|
        csv << ['Repository', 'Language', 'Created At']
        client.organization(name: organization).repositories.each do |repository|
          primary_language = repository.primary_language
          csv <<
            [
              repository.name,
              (primary_language ? primary_language.name : 'None'),
              repository.created_at
            ]
        end
      end
    end

    private

    def client
      if ENV['GITHUB_AUTHENTICATION_TOKEN']
        GithubAnalyze::Client.new(
          github_authentication_token: ENV['GITHUB_AUTHENTICATION_TOKEN']
        )
      else
        say(
          "You must set GITHUB_AUTHENTICATION_TOKEN environment variable\ne.g. GITHUB_AUTHENTICATION_TOKEN=token github_analyze #{ARGV.join(' ')}",
          Thor::Shell::Color::RED
        )
        exit
      end
    end
  end
end
