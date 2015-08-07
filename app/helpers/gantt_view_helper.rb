# We need to override the render_project method in the Redmine::Helpers::Gantt calss to display
# issues only when the correct options hash is passed
# This can only be done using 'alias_method_chaining'



module GanttViewHelper
  module InstanceMethods
    def render_project_with_message(project, options={})
      # exact copy of gantt.rb method with extra options conditional
      render_object_row(project, options)
      increment_indent(options) do
        # render issue that are not assigned to a version
        if options[:issues]
          issues = project_issues(project).select { |i| i.fixed_version.nil? }
          render_issues(issues, options)
        end
        # then render project versions and their issues
        versions = project_versions(project)
        self.class.sort_versions!(versions)
        versions.each do |version|
          render_version(project, version, options)
        end
      end
    end

  end

  def self.included(receiver)
    receiver.send :include, InstanceMethods

    receiver.class_eval do
      alias_method_chain :render_project, :message

    end
  end
end
