# this is a generated file, to avoid over-writing it just delete this comment
begin
  require 'jar_dependencies'
rescue LoadError
  require 'com/couchbase/client/core-io/1.6.0/core-io-1.6.0.jar'
  require 'com/fasterxml/jackson/core/jackson-annotations/2.7.0/jackson-annotations-2.7.0.jar'
  require 'com/couchbase/client/java-client/2.6.0/java-client-2.6.0.jar'
  require 'com/fasterxml/jackson/core/jackson-core/2.7.9/jackson-core-2.7.9.jar'
  require 'io/opentracing/opentracing-api/0.31.0/opentracing-api-0.31.0.jar'
  require 'com/couchbase/client/encryption/1.0.0/encryption-1.0.0.jar'
  require 'com/fasterxml/jackson/core/jackson-databind/2.7.9.3/jackson-databind-2.7.9.3.jar'
  require 'io/reactivex/rxjava/1.3.7/rxjava-1.3.7.jar'
end

if defined? Jars
  require_jar 'com.couchbase.client', 'core-io', '1.6.0'
  require_jar 'com.fasterxml.jackson.core', 'jackson-annotations', '2.7.0'
  require_jar 'com.couchbase.client', 'java-client', '2.6.0'
  require_jar 'com.fasterxml.jackson.core', 'jackson-core', '2.7.9'
  require_jar 'io.opentracing', 'opentracing-api', '0.31.0'
  require_jar 'com.couchbase.client', 'encryption', '1.0.0'
  require_jar 'com.fasterxml.jackson.core', 'jackson-databind', '2.7.9.3'
  require_jar 'io.reactivex', 'rxjava', '1.3.7'
end
