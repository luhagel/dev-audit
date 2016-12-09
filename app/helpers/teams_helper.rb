module TeamsHelper
  def is_public?(team)
    team.is_public
  end

  def is_owner?(team)
    current_user == team.user
  end
end
