require 'spec_helper'

describe GitHubV3API::OrgsAPI do
  describe '#list' do
    it 'returns the public and private orgs for the authenticated user' do
      connection = mock(GitHubV3API)
      connection.should_receive(:get).with('/user/orgs').and_return([:org_hash1, :org_hash2])
      api = GitHubV3API::OrgsAPI.new(connection)
      GitHubV3API::Org.should_receive(:new).with(api, :org_hash1).and_return(:org1)
      GitHubV3API::Org.should_receive(:new).with(api, :org_hash2).and_return(:org2)
      orgs = api.list
      orgs.should == [:org1, :org2]
    end
  end

  describe '#get' do
    it 'returns a fully-hydrated Org object for the specified org login' do
      connection = mock(GitHubV3API)
      connection.should_receive(:get).with('/orgs/octocat').and_return(:org_hash)
      api = GitHubV3API::OrgsAPI.new(connection)
      GitHubV3API::Org.should_receive(:new_with_all_data).with(api, :org_hash).and_return(:org)
      api.get('octocat').should == :org
    end
  end
end
