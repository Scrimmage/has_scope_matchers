module HasScopeMatchers
  module DefineScopeMatcher

    def define_scope(scope_name)
      DefineScopeMatcher.new(scope_name)
    end

    class DefineScopeMatcher

      def initialize(scope_name)
        @scope_name = scope_name
      end

      def matches?(subject)
        @subject = subject

        scope_exists? &&
          as_correct? &&
          type_correct? &&
          only_correct? &&
          if_correct? &&
          unless_correct? &&
          allow_blank_correct? &&
          using_correct?
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

      def as(value)
        @as = value
        self
      end

      def type(value)
        @type = value
        self
      end

      def using(value)
        @using = value
        self
      end

      def only(value)
        @only = value
        self
      end

      def except(value)
        @except = value
        self
      end

      def unless(condition)
        @unless_condition = condition
        self
      end

      def if(condition)
        @if_condition = condition
        self
      end

      def allow_blank(value)
        @allow_blank = value
        self
      end

      private

      def scopes_configuration
        @subject.scopes_configuration
      end

      def configuration
        scopes_configuration[@scope_name]
      end

      def scope_exists?
        if configuration
          @negated_failure_message = "#{@subject} defines #{@scope_name} when it should not"
          true
        else
          @failure_message = "#{@subject} does not define #{@scope_name}"
          false
        end
      end

      def as_correct?
        return true if @as.nil?

        if configuration[:as] != @as
          @failure_message = "expected scope to be defined as #{@as}, got #{configuration[:as] || 'nil'}"
          false
        else
          true
        end
      end

      def type_correct?
        return true if @type.nil?

        if configuration[:type] != @type
          @failure_message = "expected scope to have type #{@type}, got #{configuration[:type] || 'nil'}"
          false
        else
          true
        end
      end

      def using_correct?
        return true if @using.nil?

        if configuration[:using] != @using
          @failure_message = "expected scope to use #{@using}, got #{configuration[:using] || 'nil'}"
          false
        else
          true
        end
      end

      def only_correct?
        return true if @only.nil?

        if configuration[:only] != [ @only ]
          @failure_message = "expected scope to only allow #{@only} actions, got #{configuration[:only] || 'nil'}"
          false
        else
          true
        end
      end

      def except_correct?
        return true if @except.nil?

        if configuration[:except] != [ @except ]
          @failure_message = "expected scope to not allow #{@except} actions, got #{configuration[:except] || 'nil'}"
          false
        else
          true
        end
      end

      def if_correct?
        return true if @if_condition.nil?

        if configuration[:if] != @if_condition
          @failure_message = "expected if condition #{@if_condition}, got #{configuration[:if] || 'nil'}"
          false
        else
          true
        end
      end

      def unless_correct?
        return true if @unless_condition.nil?

        if configuration[:unless] != @unless_condition
          @failure_message = "expected unless condition #{@unless_condition}, got #{configuration[:unless] || 'nil'}"
          false
        else
          true
        end
      end

      def allow_blank_correct?
        return true if @allow_blank.nil?

        if configuration[:allow_blank] != @allow_blank
          @failure_message = "expected allow_balnk to be #{@allow_blank}, got #{configuration[:allow_blank] || 'nil'}"
          false
        else
          true
        end
      end
    end
  end
end
