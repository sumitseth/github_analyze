RSpec.describe GithubAnalyze do
  it 'has a version number' do
    expect(GithubAnalyze::VERSION).not_to be nil
  end

  describe GithubAnalyze::Client do
    subject(:client) do
      GithubAnalyze::Client.new(
        github_authentication_token: ENV['GITHUB_AUTHENTICATION_TOKEN']
      )
    end

    describe '#repositories' do
      subject(:repositories) do
        VCR.use_cassette('google_lookup') do
          client.repositories(organization: 'github')
        end
      end

      it 'returns all repositories' do
        expect(repositories.count).to eq 304
      end
    end

    describe '#language_analysis' do
      subject(:language_analysis) do
        VCR.use_cassette('google_lookup') do
          client.language_analysis(organization: 'github')
        end
      end

      it 'aggregates languages' do
        expect(language_analysis).to eq '{}'
      end
    end
  end
end
