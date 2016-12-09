module TeamsHelper
  def is_public?(team)
    if team.is_public != nil
      team.is_public
    else 
      false
    end
  end

  def is_owner?(team)
    current_user == team.user && current_user != nil
  end
end
