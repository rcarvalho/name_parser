require 'parsely/person/name_constants'

module Parsely
  module Person
    class Name
      include NameConstants
    
      attr_reader :sanitized
      attr_reader :original
      attr_reader :couple
      attr_reader :proper
      
      alias :couple? :couple
      alias :proper? :proper
      
      def initialize(name, opts={})
        @original  = name
        @sanitized = name.dup
        
        @couple    = opts[:couple].nil? ? false : opts[:couple]
        @proper    = opts[:proper].nil? ? true  : opts[:proper]
        
        sanitize
      end
      
      def name
      end
      alias :to_s :name
      
      def first
        # thinking something like:
        # @first ||= parse_first_name
      end
      
      def middle
      end
      
      def last
      end
      
      def titles
      end
      
      def suffixes
      end
      
      private
      
        def sanitize
          remove_repeating_spaces
          remove_illegal_characters
          clean_marriage_titles
          reverse_last_first_names
          remove_commas
          strip_spaces
          format_for_multiple_names if couple?
        end
        
        def remove_illegal_characters
          sanitized.gsub!(ILLEGAL_CHARACTERS, '')
        end
   
        def remove_repeating_spaces
          sanitized.gsub!(/  +/, ' ')
          sanitized.gsub!(REPEATING_SPACES, ' ')
        end
        
        def strip_spaces
          sanitized.strip!
        end
        
        def clean_marriage_titles
          sanitized.gsub!(/Mr\.? \& Mrs\.?/i, 'Mr. and Mrs.')
        end
        
        def reverse_last_first_names
          sanitized.gsub!(/(.+),(.+)/, "\\2 ;\\1")
        end
        
        def remove_commas
          sanitized.gsub!(/,/, '')
        end
        
        def format_for_multiple_names
          sanitized.gsub!(/ +and +/i, " \& ")
        end
    
    end
  end
end