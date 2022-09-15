class AddAdmin < ActiveRecord::Migration[6.1]
  def change
    User.find_by(email: 'kruglov081289@gmail.com')&.update(admin: true)
  end
end
