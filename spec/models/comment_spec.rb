require 'rails_helper'

RSpec.describe Comment, type: :model do
  subject(:comment) { build :comment }

  it { should validate_presence_of(:body) }
end
