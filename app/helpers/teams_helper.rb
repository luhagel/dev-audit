module TeamsHelper
  def public?(team)
    if team.is_public != nil
      team.is_public
    else 
      false
    end
  end

  def owner?(team)
    current_user == team.user && current_user != nil
  end
end
