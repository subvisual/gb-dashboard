require 'spec_helper'

describe TogglStats::WhichProject do
  context "#workspace_users" do
    it "knows who works here" do
      which_project_instance.workspace_users.size.should be > 5
    end

    it "only gets the names of the users and I'm one of them" do
      users = which_project_instance.workspace_users

      users.should include "Zamith"
    end
  end

  def which_project_instance
    @_which_project_instance ||= TogglStats::WhichProject.new
  end
end
