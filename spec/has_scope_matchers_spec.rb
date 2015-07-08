require 'spec_helper'

describe HasScopeMatchers do

  class TreesController < ActionController::Base
    has_scope :color, :unless => :show_all_colors?
    has_scope :only_tall, :type => :boolean, :only => :index, :if => :restrict_to_only_tall_trees?
    has_scope :shadown_range, :default => 10, :except => [ :index, :show, :new ]
    has_scope :root_type, :as => :root, :allow_blank => true
    has_scope :planted_before, :default => proc { Date.today }
    has_scope :planted_after, :type => :date
    has_scope :calculate_height, :default => proc {|c| c.session[:height] || 20 }, :only => :new
    has_scope :paginate, :type => :hash
    has_scope :args_paginate, :type => :hash, :using => [:page, :per_page]
    has_scope :categories, :type => :array
    has_scope :title, :in => :q
    has_scope :content, :in => :q
    has_scope :conifer, type: :boolean, :allow_blank => true

    has_scope :only_short, :type => :boolean do |controller, scope|
      scope.only_really_short!(controller.object_id)
    end

    has_scope :by_category do |controller, scope, value|
      scope.by_given_category(controller.object_id, value + "_id")
    end
  end

  subject { TreesController }

  it 'has a version number' do
    expect(HasScopeMatchers::VERSION).not_to be nil
  end

  it { is_expected.to_not define_scope(:trees_are_not_cool) }
  it { is_expected.to define_scope(:color).unless(:show_all_colors?) }
  it { is_expected.to define_scope(:only_tall).type(:boolean).only(:index).if(:restrict_to_only_tall_trees?) }
  it { is_expected.to define_scope(:root_type).as(:root).allow_blank(true) }
end
