
ds = com.google.appengine.api.datastore.DatastoreServiceFactory.datastore_service
ent = com.google.appengine.api.datastore.Entity.new("foo", "foo42")
key = ent.get_key
ent.set_property("hello", "bar") 
ent.set_property("goodbye", "blarg") 
ds.put(ent)
ent2 = ds.get(key)
ent2.get_properties.to_string
