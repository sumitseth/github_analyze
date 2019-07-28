RSpec.describe GithubAnalyze::Organization do
  let(:client) do
    GithubAnalyze::Client.new(
      github_authentication_token: ENV['GITHUB_AUTHENTICATION_TOKEN']
    )
  end

  subject(:organization) do
    VCR.use_cassette('github_lookup') { client.organization(name: 'github') }
  end

  describe '#repositories' do
    it 'returns all repositories' do
      expect(organization.repositories.count).to eq 304
    end
  end

  describe '#languages' do
    it 'aggregates languages' do
      expect(organization.languages).to eq(
        {
          'C' => 17,
          'C#' => 6,
          'C++' => 2,
          'CSS' => 6,
          'Clojure' => 1,
          'CoffeeScript' => 6,
          'Go' => 19,
          'HTML' => 9,
          'Haskell' => 2,
          'Java' => 6,
          'JavaScript' => 63,
          'Objective-C' => 10,
          'Perl' => 1,
          'PowerShell' => 1,
          'Puppet' => 3,
          'Python' => 9,
          'Ragel in Ruby Host' => 1,
          'Ruby' => 98,
          'Scala' => 1,
          'Shell' => 15,
          'Swift' => 3,
          'TypeScript' => 2
        }
      )
    end
  end

  describe '#most_common_languages' do
    it 'returns most common' do
      expect(organization.most_common_languages).to eq(
        %w[Ruby JavaScript Go C Shell]
      )
    end
  end

  describe '#least_common_languages' do
    it 'returns least common' do
      expect(organization.least_common_languages).to eq(
        ['Clojure', 'Perl', 'PowerShell', 'Ragel in Ruby Host', 'Scala']
      )
    end
  end

  describe '#ranked_languages' do
    it 'returns all languages ranked' do
      expect(organization.ranked_languages).to eq(
        [
          'Ruby',
          'JavaScript',
          'Go',
          'C',
          'Shell',
          'Objective-C',
          'HTML',
          'Python',
          'C#',
          'CSS',
          'CoffeeScript',
          'Java',
          'Puppet',
          'Swift',
          'C++',
          'Haskell',
          'TypeScript',
          'Clojure',
          'Perl',
          'PowerShell',
          'Ragel in Ruby Host',
          'Scala'
        ]
      )
    end
  end
end
