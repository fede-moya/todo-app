# frozen_string_literal: true

# Mixin module, adds the ability to persist a Singleton class in a
# local file and also de ability to load the Singleton class from that file.
# In order to work properply the class that include this modules must also
# include the ruby module Singleton
module SingletonStorer
  # This module allows to embed class methods as part of the mixin.
  module ClassMethods
    def dump
      instance._dump
    end

    def load
      instance._load
    end
  end

  def self.included(base)
    base.extend(ClassMethods)
  end

  def _load
    return unless File.exist?(persistence_file_name)

    attributes = Marshal.load(File.read(persistence_file_name))
    attributes.each do |attr, value|
      instance_variable_set("@#{attr}".to_sym, value)
    end
  end

  def _dump
    File.write(persistence_file_name, Marshal.dump(attrs_to_hash))
  end

  def persistence_file_name
    "#{self.class.name.downcase}.mp"
  end

  def attrs_to_hash
    attrs = {}
    self.class::PERSISTED_ATTRIBUTES.each do |attr|
      attrs[attr] = send(attr)
    end

    attrs
  end
end
