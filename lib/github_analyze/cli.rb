require 'thor'
require 'csv'
require 'github_analyze'

module GithubAnalyze
  class Cli < Thor
    desc 'stats ORGANIZATION', 'report language stats for said organization'
    def stats(organization)
      client.organization(name: organization)
        .ranked_languages
        .each
          .with_index { |language, i| puts "#{i + 1} - #{language}" }
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
        raise 'You must set GITHUB_AUTHENTICATION_TOKEN environment variable'
      end
    end
  end
end
