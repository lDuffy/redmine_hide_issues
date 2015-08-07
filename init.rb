Redmine::Plugin.register :redmine_hide_issues do
  name 'Hide Issues plugin'
  author 'Author name'
  description 'This is a plugin for Redmine'
  version '0.0.1'
  url 'http://example.com/path/to/plugin'
  author_url 'http://example.com/about'
end

# overriding methods in gantt.rb helper to include custom functionality
Rails.configuration.to_prepare do
  # require 'custom_fields_helper'
  Redmine::Helpers::Gantt.send     :include, GanttViewHelper
end

