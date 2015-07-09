#encoding: utf-8

module BotpopPlugins
  module Searchable

    MATCH = lambda do |parent, plugin|
      parent.on :message, /\!(#{CONFIG.keys.join('|')}) .+/ do |m| plugin.exec_search m end
    end
    CONFIG = Botpop::CONFIG['searchable'] || raise(MissingConfigurationZone, 'base')
    ENABLED = CONFIG['enable'].nil? ? true : CONFIG['enable']

    VALUES = CONFIG.values.map{|e|"!"+e}.join(', ')
    KEYS = CONFIG.keys.map{|e|"!"+e}.join(', ')
    HELP = CONFIG.keys.map{|e|"!"+e+" [search]"}

    def self.exec_search m
      msg = Builtin.get_msg m
      url = CONFIG[m.params[1..-1].join(' ').gsub(/\!([^ ]+) .+/, '\1')]
      url = url.gsub('___MSG___', msg)
      m.reply url
    end

  end
end
