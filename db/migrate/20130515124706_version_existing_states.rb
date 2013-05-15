class VersionExistingStates < ActiveRecord::Migration
  def change
    say_with_time "setting initial version for states" do
      State.find_each(&:touch)
    end
  end
end
