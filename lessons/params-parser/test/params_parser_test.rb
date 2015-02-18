require_relative "../lib/params_parser"

RSpec.describe "params_parser" do
  let(:routes) do
    [
      ["GET", "/"],
      ["GET", "/toasters"],
      ["GET", "/toasters/new"],
      ["GET", "/toasters/:toaster_id"],
      ["GET", "/users/sign_in"],
      ["POST", "/toasters"],
      ["POST", "/users/sign_in"]
    ]
  end

  describe "GET requests" do
    it "matches the appropriate route" do
      request = "GET / HTTP/1.1"
      results = params_parser(request, routes)

      expect(results[:method]).to eq("GET")
      expect(results[:path]).to eq("/")
    end

    it "returns nil if no match is found" do
      request = "GET /waffle-makers HTTP/1.1"
      results = params_parser(request, routes)

      expect(results).to eq(nil)
    end

    it "chooses the earlier match when multiple available" do
      request = "GET /toasters/new HTTP/1.1"
      results = params_parser(request, routes)

      expect(results[:method]).to eq("GET")
      expect(results[:path]).to eq("/toasters/new")
    end

    it "extracts a parameter from the path" do
      request = "GET /toasters/42 HTTP/1.1"
      results = params_parser(request, routes)

      expect(results[:method]).to eq("GET")
      expect(results[:path]).to eq("/toasters/42")
      expect(results[:params][:toaster_id]).to eq("42")
    end
  end
end
