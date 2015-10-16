describe Qiita::Team::Services::Hooks::Webhook, :versioning do
  let(:hook) do
    described_class.new(properties)
  end

  let(:properties) do
    {
      "url" => url,
      "token" => token,
    }
  end

  let(:url) do
    FFaker::Internet.http_url
  end

  let(:token) do
    described_class.generate_token
  end

  let(:event) do
    Qiita::Team::Services::Events.create(event_name, resource, user, team)
  end

  let(:user) do
    build(:user)
  end

  let(:team) do
    build(:team)
  end

  describe "#item_created" do
    subject do
      hook.item_created(event)
    end

    let(:event_name) do
      "item_created"
    end

    let(:resource) do
      build(:item)
    end

    it "sends webhook" do
      request = stub_request(:post, url).with(
        body: {
          action: "created",
          model: "item",
          item: hash_including(
            "body" => kind_of(String),
            "coediting" => false,
            "comment_count" => kind_of(Integer),
            "created_at_as_seconds" => kind_of(Integer),
            "created_at_in_words" => kind_of(String),
            "created_at" => kind_of(String),
            "id" => kind_of(Integer),
            "lgtm_count" => kind_of(Integer),
            "raw_body" => kind_of(String),
            "stock_count" => kind_of(Integer),
            "stock_users" => [],
            "tags" => [
              {
                "name" => kind_of(String),
                "url_name" => kind_of(String),
                "versions" => kind_of(Array),
              },
            ],
            "title" => kind_of(String),
            "updated_at" => kind_of(String),
            "updated_at_in_words" => kind_of(String),
            "url" => kind_of(String),
            "user" => {
              "id" => kind_of(Integer),
              "profile_image_url" => kind_of(String),
              "url_name" => kind_of(String),
            },
            "uuid" => kind_of(String),
          ),
          user: {
            "id" => kind_of(Integer),
            "profile_image_url" => kind_of(String),
            "url_name" => kind_of(String),
          },
        },
        headers: {
          "Content-Type" => "application/json",
          "User-Agent" => "Qiita:Team",
          "X-Qiita-Event-Model" => "item",
          "X-Qiita-Token" => token,
        },
      )
      subject
      expect(request).to have_been_made
    end
  end

  describe "#item_updated" do
    subject do
      hook.item_updated(event)
    end

    let(:event_name) do
      "item_updated"
    end

    let(:resource) do
      build(:item)
    end

    it "sends webhook" do
      request = stub_request(:post, url).with(
        body: {
          action: "updated",
          message: kind_of(String),
          model: "item",
          item: kind_of(Hash),
          user: kind_of(Hash),
        },
      )
      subject
      expect(request).to have_been_made
    end
  end

  describe "#item_destroyed" do
    subject do
      hook.item_destroyed(event)
    end

    let(:event_name) do
      "item_destroyed"
    end

    let(:resource) do
      build(:item)
    end

    it "sends webhook" do
      request = stub_request(:post, url).with(
        body: {
          action: "destroyed",
          model: "item",
          item: kind_of(Hash),
        },
      )
      subject
      expect(request).to have_been_made
    end
  end

  describe "#item_comment_created" do
    subject do
      hook.item_comment_created(event)
    end

    let(:event_name) do
      "item_comment_created"
    end

    let(:resource) do
      build(:comment)
    end

    it "sends webhook" do
      request = stub_request(:post, url).with(
        body: {
          action: "created",
          model: "comment",
          comment: kind_of(Hash),
          item: kind_of(Hash),
        },
      )
      subject
      expect(request).to have_been_made
    end
  end

  describe "#item_comment_updated" do
    subject do
      hook.item_comment_updated(event)
    end

    let(:event_name) do
      "item_comment_updated"
    end

    let(:resource) do
      build(:comment)
    end

    it "sends webhook" do
      request = stub_request(:post, url).with(
        body: {
          action: "updated",
          model: "comment",
          comment: kind_of(Hash),
          item: kind_of(Hash),
        },
      )
      subject
      expect(request).to have_been_made
    end
  end

  describe "#item_comment_destroyed" do
    subject do
      hook.item_comment_destroyed(event)
    end

    let(:event_name) do
      "item_comment_destroyed"
    end

    let(:resource) do
      build(:comment)
    end

    it "sends webhook" do
      request = stub_request(:post, url).with(
        body: {
          action: "destroyed",
          model: "comment",
          comment: kind_of(Hash),
          item: kind_of(Hash),
        },
      )
      subject
      expect(request).to have_been_made
    end
  end

  describe "#project_comment_created" do
    subject do
      hook.project_comment_created(event)
    end

    let(:event_name) do
      "project_comment_created"
    end

    let(:resource) do
      build(:comment)
    end

    it "sends webhook" do
      request = stub_request(:post, url).with(
        body: {
          action: "created",
          model: "comment",
          comment: kind_of(Hash),
          item: kind_of(Hash),
        },
      )
      subject
      expect(request).to have_been_made
    end
  end

  describe "#project_comment_updated" do
    subject do
      hook.project_comment_updated(event)
    end

    let(:event_name) do
      "project_comment_updated"
    end

    let(:resource) do
      build(:comment)
    end

    it "sends webhook" do
      request = stub_request(:post, url).with(
        body: {
          action: "updated",
          model: "comment",
          comment: kind_of(Hash),
          item: kind_of(Hash),
        },
      )
      subject
      expect(request).to have_been_made
    end
  end

  describe "#project_comment_destroyed" do
    subject do
      hook.project_comment_destroyed(event)
    end

    let(:event_name) do
      "project_comment_destroyed"
    end

    let(:resource) do
      build(:comment)
    end

    it "sends webhook" do
      request = stub_request(:post, url).with(
        body: {
          action: "destroyed",
          model: "comment",
          comment: kind_of(Hash),
          item: kind_of(Hash),
        },
      )
      subject
      expect(request).to have_been_made
    end
  end

  describe "#team_member_added" do
    subject do
      hook.team_member_added(event)
    end

    let(:event_name) do
      "team_member_added"
    end

    let(:resource) do
      build(:user)
    end

    it "sends webhook" do
      request = stub_request(:post, url).with(
        body: {
          action: "added",
          model: "member",
          user: kind_of(Hash),
        },
      )
      subject
      expect(request).to have_been_made
    end
  end

  describe "#team_member_removed" do
    subject do
      hook.team_member_added(event)
    end

    let(:event_name) do
      "team_member_removed"
    end

    let(:resource) do
      build(:user)
    end

    it "sends webhook" do
      request = stub_request(:post, url).with(
        body: {
          action: "added",
          model: "member",
          user: kind_of(Hash),
        },
      )
      subject
      expect(request).to have_been_made
    end
  end

  describe "#project_created" do
    subject do
      hook.project_created(event)
    end

    let(:event_name) do
      "project_created"
    end

    let(:resource) do
      build(:project)
    end

    it "sends webhook" do
      request = stub_request(:post, url).with(
        body: {
          action: "created",
          model: "project",
          project: kind_of(Hash),
          user: kind_of(Hash),
        },
      )
      subject
      expect(request).to have_been_made
    end
  end

  describe "#project_updated" do
    subject do
      hook.project_updated(event)
    end

    let(:event_name) do
      "project_updated"
    end

    let(:resource) do
      build(:project)
    end

    it "sends webhook" do
      request = stub_request(:post, url).with(
        body: {
          action: "updated",
          model: "project",
          message: kind_of(String),
          project: kind_of(Hash),
          user: kind_of(Hash),
        },
      )
      subject
      expect(request).to have_been_made
    end
  end

  describe "#project_destroyed" do
    subject do
      hook.project_destroyed(event)
    end

    let(:event_name) do
      "project_destroyed"
    end

    let(:resource) do
      build(:project)
    end

    it "sends webhook" do
      request = stub_request(:post, url).with(
        body: {
          action: "destroyed",
          model: "project",
          project: kind_of(Hash),
        },
      )
      subject
      expect(request).to have_been_made
    end
  end

  describe "#ping" do
    subject do
      hook.ping
    end

    it "enqueues job to send event" do
      request = stub_request(:post, url).with(
        body: {
          action: "requested",
          message: "ping",
          model: "ping",
        },
      )
      subject
      expect(request).to have_been_made
    end
  end
end
