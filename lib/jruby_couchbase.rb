require "java"
require "jruby-couchbase_jars"
require "multi_json"

java_import com.couchbase.client.java.CouchbaseCluster
java_import com.couchbase.client.java.document.RawJsonDocument
java_import com.couchbase.client.java.document.json.JsonArray
java_import com.couchbase.client.java.view.ViewQuery
java_import com.couchbase.client.java.env.DefaultCouchbaseEnvironment
java_import java.util.concurrent.TimeUnit

class Couchbase

  def initialize(cluster, credentials, bucket, timeouts = {})
    env = DefaultCouchbaseEnvironment.builder().connect_timeout(timeouts[:connection] || 5000).build()
    @connected_cluster = CouchbaseCluster.create(env, cluster)
    @connected_cluster.authenticate(credentials[:username], credentials[:password])
    @connected_bucket = @connected_cluster.open_bucket(bucket, timeouts[:open_bucket] || 5000, TimeUnit::MILLISECONDS)
  end

  def get_document(key)
    doc = @connected_bucket.get(key, RawJsonDocument.java_class)
    return nil if doc.nil?
    MultiJson.load(doc.content)
  end

  def query(query, view)
    view_query = ViewQuery.from(query, view)
    transform_view_result(@connected_bucket.query(view_query))
  end

  def query_with_keys(design, view, keys)
    view_query = ViewQuery.from(design, view).keys(JsonArray.from(keys.to_java))
    transform_view_result(@connected_bucket.query(view_query))
  end

  def close
    @connected_bucket.close
    @connected_cluster.disconnect
  end

  private

    def transform_view_result(view_result)
      {}.tap do |response|
        view_result.each do |view_row|
          doc = view_row.document(RawJsonDocument.java_class)
          response[view_row.id] = doc.nil? ? nil : MultiJson.load(doc.content)
        end
      end
    end

end
