
module Google
  import com.google.appengine.api.datastore.DatastoreServiceFactory
  import com.google.appengine.api.datastore.Entity
  import com.google.appengine.api.datastore.KeyFactory
  import com.google.appengine.api.datastore.Key
  import com.google.appengine.api.datastore.EntityNotFoundException
end

class CGI #:nodoc:all
  class Session
    class BigTableServletStore
      DATASTORE = Google::DatastoreServiceFactory.datastore_service
      RAILS_SESSION_ENTITY = "__current_rails_session"
      RAILS_SESSION_KEY = "__rails_session_data"
      
      def initialize(session, option=nil)
        @session_id = session.session_id
        @key = Google::KeyFactory.create_key(RAILS_SESSION_ENTITY, @session_id)
        @data = {}
      end
      def marshal(data)   ActiveSupport::Base64.encode64(Marshal.dump(data)) if data end
      def unmarshal(data) Marshal.load(ActiveSupport::Base64.decode64(data)) if data end

      # Restore session state from the big table session
      def restore
        begin
          entity = DATASTORE.get(@key)
          if entity.has_property(RAILS_SESSION_KEY)
            @data = unmarshal(entity.get_property(RAILS_SESSION_KEY))
          end
        rescue Google::EntityNotFoundException
        end
        
        @data
      end

      def update
        entity = Google::Entity.new(RAILS_SESSION_ENTITY, @session_id)
        entity.set_property(RAILS_SESSION_KEY, marshal(@data))
        DATASTORE.put(entity)
      end

      def close
        update
      end

      def delete
        DATASTORE.delete(@key)
      end
    end
  end
end
