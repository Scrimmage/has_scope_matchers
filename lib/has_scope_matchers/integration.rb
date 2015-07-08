module HasScopeMatchers
  module Integration

    if defined?(RSpec)
      require 'has_scope_matchers/integration/rspec'
    end
  end
end
