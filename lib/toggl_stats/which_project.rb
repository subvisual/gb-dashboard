module TogglStats
  class WhichProject
    def workspace_users
      workspace_id = $toggl_interface.workspaces.first["id"]

      $toggl_interface.users_for_workspace(workspace_id).map{|user| user["fullname"]}
    end
  end
end

