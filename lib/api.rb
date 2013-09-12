
module CouchDB
  class Proxy
    module API

      # DB API

      def get_all_dbs
        request :get, "/_all_dbs/", :timeout => @timeout
      end

      def create_db(db_name)
        request :put, "/#{db_name}/"
      end

      def get_db(db_name)
        request :get, "/#{db_name}/", :timeout => @timeout
      end

      def delete_db(db_name)
        request :delete, "/#{db_name}/"
      end

      def compact(db_name)
        request :post, "/#{db_name}/_compact"
      end

      # Document API

      def get(db_name, id)
        request :get, "/#{db_name}/#{id}", :timeout => @timeout
      end

      def save(db_name, doc)
        request :post, "/#{db_name}/", :body => JSON.dump(doc)
      end

      def update(db_name, old_doc, new_doc)
        new_doc['_rev'] = old_doc['_rev']
        new_doc['_id'] = old_doc['_id']
        request :put, "/#{db_name}/#{id}", :body => JSON.dump(new_doc)
      end

      def delete(db_name, doc)
        request :delete, "/#{db_name}/#{doc['_id']}?rev=#{doc['_rev']}"
      end

    end
  end
end
