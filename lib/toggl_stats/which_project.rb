require 'pry'
module TogglStats
  class WhichProject
    def workspace_users
      $toggl_interface.users_for_workspace(workspace_id)#.map{|user| user["fullname"]}
    end

    def current_projects
      @user_to_project = {}
      workspace_users.each do |user|
        get_last_task toggl_user: user
      end
      user_to_project
    end

    private
    attr_reader :user_to_project

    def get_last_task(toggl_user: nil)
      user_toggl_interface = Toggl.new toggl_user["api_token"]
      last_task = user_toggl_interface.time_entries.last
      if last_task
        @user_to_project[toggl_user["fullname"]] = last_task["project"]["name"]
      end
    end

    def user_agent
      "contact@groupbuddies.com"
    end

    def workspace_id
      workspace_id = $toggl_interface.workspaces.first["id"]
    end
  end
end

