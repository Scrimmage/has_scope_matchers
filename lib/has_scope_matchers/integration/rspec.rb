require 'has_scope_matchers/define_scope_matcher'

module HasScopeMatchers
  module Integration
    module RSpec

      ::RSpec.configure do |config|
        config.include(HasScopeMatchers::DefineScopeMatcher)
      end

    end
  end
end
