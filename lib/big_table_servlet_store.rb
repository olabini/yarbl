# $servlet_context.log("LOOOOOOOOOOOOOOOOOOOOOOOOOOOADING BigTableServletStore")

# include_class "com.google.appengine.api.datastore.DatastoreServiceFactory"

# class CGI #:nodoc:all
#   class Session
#     class BigTableServletStore
#       DATASTORE = DatastoreServiceFactory.datastore_service
      
#       def initialize(session, option=nil)
#         $servlet_context.log("BigTableServletStore.initialize")
#       end

#       def restore
#         $servlet_context.log("BigTableServletStore.restore")
#       end

#       def update
#         $servlet_context.log("BigTableServletStore.update")
#       end

#       def close
#         $servlet_context.log("BigTableServletStore.close")
#       end

#       def delete
#         $servlet_context.log("BigTableServletStore.delete")
#       end

#       def data
#         $servlet_context.log("BigTableServletStore.data")
#       end

#       def []=(k, v)
#         $servlet_context.log("BigTableServletStore.[]=")
#       end

#       def [](k)
#         $servlet_context.log("BigTableServletStore.[]")
#       end

#       def each(&b)
#         $servlet_context.log("BigTableServletStore.each")
#       end

#       private
#       # Attempts to redirect any messages to the data object.
#       def method_missing(name, *args, &block)
#       end
#     end
#   end
# end
