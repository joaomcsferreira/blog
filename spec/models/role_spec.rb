require 'rails_helper'

RSpec.describe Role, type: :model do
  subject(:role) { build :role }

  describe "validations" do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:description) }
  end
end
