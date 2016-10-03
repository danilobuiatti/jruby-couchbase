# encoding: utf-8
require "rspec"
require "jruby-couchbase_jars"
require "jruby_couchbase"

describe Couchbase do

  context "Connection:" do

    before :all do
      @couchbase = Couchbase.new("127.0.0.1", "zup", "")
    end

    after :all do
      @couchbase.close
    end

    it "should be able to connect and retrieve some document" do
      doc = @couchbase.get_document("test-document")
      expect(doc).to include("developers")
    end

    it "should be able to retrieve a document using a view" do
      documents = @couchbase.query("dev_design_document", "view_name")
      expect(documents).to include("test-document")
    end

  end
end
