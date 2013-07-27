require 'spec_helper'

describe TogglStats::WhichProject do
  context "#workspace_users" do
    it "knows who works here" do
      which_project_instance.workspace_users.size.should be > 5
    end

    it "only gets the names of the users and I'm one of them" do
      users = which_project_instance.workspace_users

      users.select{|user| user["fullname"] == "Zamith"}.should_not be_empty
    end
  end

  context "#current_projects" do
    it "knows the project I'm working on" do
      project_name = "GB Personal"
      interface_double = double(time_entries: [{"project" => {"name" => project_name}}])
      Toggl.stub(:new).and_return(interface_double)
      user_double = {"api_token" => "random", "fullname" => "Zamith"}
      which_project_instance.stub(:workspace_users).and_return([user_double])

      which_project_instance.current_projects["Zamith"].should eq project_name
    end
  end

  def which_project_instance
    @_which_project_instance ||= TogglStats::WhichProject.new
  end
end
