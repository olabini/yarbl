
require 'java'

module Bumble
  module DS
    import com.google.appengine.api.datastore.DatastoreServiceFactory
    import com.google.appengine.api.datastore.Entity
    import com.google.appengine.api.datastore.KeyFactory
    import com.google.appengine.api.datastore.Key
    import com.google.appengine.api.datastore.EntityNotFoundException
    Service = DatastoreServiceFactory.datastore_service
  end

  module InstanceMethods
    def initialize(*args)
      super
      @__entity = DS::Entity.new(self.class.name)
    end

    def key
      __ds_key.get_id
    end
    
    def save!
      DS::Service.put(@__entity)
    end
    
    def delete!
      DS::Service.delete(__ds_key)
    end

    def __ds_key
      @__entity.key
    end
    
    def __ds_get(name)
      name = name.to_s
      if @__entity.has_property(name)
        @__entity.get_property(name)
      else
        nil
      end
    end
    
    def __ds_set(name, value)
      @__entity.set_property(name.to_s, value)
    end
  end

  module ClassMethods
    # defines zero or more data store attributes - will create attribute accessors for these
    def ds(*names)
      names.each do |name|
        self.class_eval <<DEF
  def #{name}
    __ds_get(#{name.inspect})
  end

  def #{name}=(value)
    __ds_set(#{name.inspect}, value)
  end
DEF
      end
    end

    def get(key)
      ent = DS::Service.get(DS::KeyFactory.create_key(self.name, key))
      obj = self.new
      obj.instance_variable_set :@__entity, ent
      obj
    end
  end
  
  def self.included(base)
    base.send :include, InstanceMethods
    base.send :extend,  ClassMethods
  end
end
