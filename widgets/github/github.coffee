class Dashing.Github extends Dashing.Widget
  ready: ->

  onData: (data) ->
    recent_repos = new Batman.Set
    recent_repos.add.apply(recent_repos, data.recent_repos)
    @set 'recent_repos', recent_repos

  @accessor 'total_repos', Dashing.AnimatedValue
