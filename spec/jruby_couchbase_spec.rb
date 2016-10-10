# encoding: utf-8
require "rspec"
require "jruby-couchbase_jars"
require "jruby_couchbase"

describe Couchbase do

  context "Connection:" do

    before :all do
      @couchbase = Couchbase.new("127.0.0.1", "apis", "")
    end

    after :all do
      @couchbase.close
    end

    it "should be able to connect and retrieve some document" do
      doc = @couchbase.get_document("gateway/1/1/1")
      expect(doc).to include("entrypoint")
    end

    it "should be able to retrieve a document using a view" do
      rows = @couchbase.query_with_keys("api", "by_resource", ["gateway/143/311/1"])
      expect(rows.keys.first).to eq("gateway/180/180/1")
    end

  end
end
