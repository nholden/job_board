module UsersHelper
  def admin_exists?
    Role.find_or_create_by(label:'admin').users.count != 0
  end
end
