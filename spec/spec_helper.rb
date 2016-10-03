require "jruby-couchbase_jars"

java_import org.couchbase.mock.CouchbaseMock

module SpecHelper

  RSpec.configure do |config|
    config.include SpecHelper

    config.before(:all) do
      @couchbaseMock = CouchbaseMock.new("127.0.0.1", 8091, 1, 512, "default:,protected:secret,cache::memcache")
      @couchbaseMock.start
      @couchbaseMock.waitForStartup
    end

    config.after(:all) do
      @couchbaseMock.stop
    end

  end
end
