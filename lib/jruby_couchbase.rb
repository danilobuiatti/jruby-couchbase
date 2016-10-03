require "java"
require "jruby-couchbase_jars"
require "multi_json"

java_import com.couchbase.client.java.CouchbaseCluster
java_import com.couchbase.client.java.document.RawJsonDocument
java_import com.couchbase.client.java.view.ViewQuery

class Couchbase

  def initialize(cluster, bucket, bucket_password)
    @connected_cluster = CouchbaseCluster.create(cluster)
    @connected_bucket = @connected_cluster.openBucket(bucket, bucket_password)
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
