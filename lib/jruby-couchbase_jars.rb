begin
  require 'jar_dependencies'
rescue LoadError
  require 'io/reactivex/rxjava/1.1.5/rxjava-1.1.5.jar'
  require 'com/couchbase/client/java-client/2.3.1/java-client-2.3.1.jar'
  require 'com/couchbase/client/core-io/1.3.1/core-io-1.3.1.jar'
end

if defined? Jars
  require_jar( 'io.reactivex', 'rxjava', '1.1.5' )
  require_jar( 'com.couchbase.client', 'java-client', '2.3.1' )
  require_jar( 'com.couchbase.client', 'core-io', '1.3.1' )
end
