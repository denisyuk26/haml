module Sass
  module Script
    # A SassScript parse node representing a variable.
    class Variable < Node
      # The name of the variable.
      #
      # @return [String]
      attr_reader :name
      attr_reader :prefix

      # @param name [String] See \{#name}
      def initialize(prefix, name)
        @name = name
        @prefix = prefix
      end

      # @return [String] A string representation of the variable
      def inspect
        "#{prefix}#{name}"
      end
      alias_method :to_sass, :inspect

      # Returns an empty array.
      #
      # @return [Array<Node>] empty
      # @see Node#children
      def children
        []
      end

      protected

      # Evaluates the variable.
      #
      # @param environment [Sass::Environment] The environment in which to evaluate the SassScript
      # @return [Literal] The SassScript object that is the value of the variable
      # @raise [Sass::SyntaxError] if the variable is undefined
      def _perform(environment)
        (val = environment.var(name)) && (return val)
        raise SyntaxError.new("Undefined variable: \"#{prefix}#{name}\".")
      end
    end
  end
end
