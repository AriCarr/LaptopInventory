module UsersHelper

  def holdout_emails(holdouts)
    holdouts.pluck(:email).join(", ")
  end

end
