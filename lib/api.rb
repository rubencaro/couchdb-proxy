
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

      # conflict-solving get
      def get(db_name, id)
        # get winner plus conflicts list
        result = request :get, "/#{db_name}/#{id}", :timeout => @timeout
        # if conflicts, fetch all versions
        # rescue if any failure, retry from the beginning, maybe the
        #     conflicting version is already been resolved by another client
        # invoke resolving block for all versions
        # return resolved version
      end

      # straight forward get, no conflict solving
      def simple_get(db_name, id)
        request :get, "/#{db_name}/#{id}", :timeout => @timeout
      end

      # "all_or_nothing" post, no conflict solving
      def save(db_name, docs)
        docs = [docs] if not docs.is_a? Array
        request :post, "/#{db_name}/_bulk_docs", :body => JSON.dump({ :all_or_nothing => true, :docs => docs })
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
