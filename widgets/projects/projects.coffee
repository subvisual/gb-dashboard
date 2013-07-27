class Dashing.Projects extends Dashing.Widget
  ready: ->
    @projectsRow = $(@node).find('#projects-row')
    @membersRow = $(@node).find('#members-row')
    @projects = JSON.parse @get('projects')
    $.each @projects, (member, project) =>
      @membersRow.append("<img class='member' src='/assets/members/#{member.toLowerCase()}.png'>")
      @projectsRow.append("<div class='project'>#{project}</div>")

  onData: (data) ->
    @currentIndex = 0
