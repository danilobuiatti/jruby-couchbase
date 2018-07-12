# encoding: utf-8
require "rspec"
require "jruby-couchbase_jars"
require "jruby_couchbase"

describe Couchbase do

  context "Connection:" do

    before :all do
      @couchbase = Couchbase.new("127.0.0.1", { username: "gateway", password: "gateway" }, "apis")
    end

    after :all do
      @couchbase.close
    end

    it "should be able to connect and retrieve some document" do
      doc = @couchbase.get_document("gateway/demo-zup/v1")
      expect(doc).to include("id")
    end

    it "should be able to retrieve a document using a view" do
      rows = @couchbase.query_with_keys("dev_api", "by_api_version", ["gateway/342/658"])
      expect(rows.keys.first).to eq("gateway/demo-zup/v1")
    end

  end
end
