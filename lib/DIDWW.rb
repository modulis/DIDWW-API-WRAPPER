require "DIDWW/version"
require "DIDWW/configuration"
require 'DIDWW/client'

module DIDWW
  class << self
    attr_reader :configuration
  end

  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.configure
    yield configuration
  end

  def self.reset
    @configuration = Configuration.new
  end

  def self.mode
    configuration.sandbox ? :sandbox : :live
  end

  def self.sandbox?
    configuration.sandbox
  end

  def self.live?
    !configuration.sandbox
  end
end
