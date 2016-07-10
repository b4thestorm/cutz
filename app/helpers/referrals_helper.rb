module ReferralsHelper
  def to_bool(str)
    return true if str=="true"
    return false if str=="false"
  end
end
