module HasScopeMatchers
  module DefineScopeMatcher

    def define_scope(scope_name)
      DefineScopeMatcher.new(scope_name)
    end

    class DefineScopeMatcher

      def initialize(scope_name)
        @expected_scope_name = scope_name
      end

      def matches?(subject)
        @subject = subject

        @failure_message = "Test Fail"
        false
      end

      def failure_message
        @failure_message
      end

      def failure_message_when_negated
        @negated_failure_message
      end

      def description
        "Tests the scopes defined by the has_scope gem for rails controllers"
      end

    end
  end
end
