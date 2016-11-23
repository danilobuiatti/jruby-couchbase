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

  def initialize(cluster, bucket, bucket_password, connect_timeout_ms = 5000, open_bucket_timeout_ms = 5000)
    env = DefaultCouchbaseEnvironment.builder().connectTimeout(connect_timeout_ms).build()
    @connected_cluster = CouchbaseCluster.create(env, cluster)
    @connected_bucket = @connected_cluster.openBucket(bucket, bucket_password, open_bucket_timeout_ms, TimeUnit::MILLISECONDS)
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

  def query_with_keys(query, view, keys)
    view_query = ViewQuery.from(query, view).keys(JsonArray.from(keys.to_java))
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
