require 'parsely/person_name_constants'

module Parsely
  class PersonName
    include PersonNameConstants

    attr_reader :name
    attr_reader :original
    attr_reader :couple
    alias :couple? :couple

    def initialize(name, opts={})
      @name = name.dup
      @original = name
      @couple = opts[:couple] || false
    end

    def run
      remove_illegal_characters
      remove_repeating_spaces
      strip_spaces
      clean_trailing_suffixes
      clean_marriage_titles
      reverse_last_and_first_names
      remove_commas
      strip_spaces
      couple? ? parse_couple : parse_individual
    end

    def remove_illegal_characters
      name.gsub!(ILLEGAL_CHARACTERS, '')
    end

    def remove_repeating_spaces
      name.gsub!(REPEATING_SPACES, ' ')
    end

    def strip_spaces 
      name.strip!
    end

    def clean_trailing_suffixes
      SUFFIXES.each do |suffix|
        suffix_p = Regexp.new( "(.+), (#{suffix})$", true )
        name.gsub!( suffix_p, "\\1 \\2" )
      end
    end

    def clean_marriage_titles
      name.gsub!( /Mr\.? \& Mrs\.?/i, "Mr. and Mrs." )
    end

    def reverse_last_and_first_names
      name.gsub!(/;/, '')
      name.gsub!(/(.+),(.+)/, "\\2 ;\\1")
    end

    def remove_commas
      name.gsub!(/,/, '')
    end

  end
end
