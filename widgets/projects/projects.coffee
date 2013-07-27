class Dashing.Projects extends Dashing.Widget

  ready: ->
    @setup()
    @populateColumns @get('products')

  onData: (data) ->
    @setup()
    @membersColumn.empty()
    @projectsColumn.empty()
    @populateColumns data.projects

  setup: ->
    @projectsColumn = $(@node).find('#projects-row')
    @membersColumn = $(@node).find('#members-row')

  populateColumns: (projects) ->
    @projects = JSON.parse projects
    $.each @projects, (member, project) =>
      @membersColumn.append("<img class='member' src='/assets/members/#{member.toLowerCase()}.png'>")
      @projectsColumn.append("<div class='project'>#{project}</div>")

