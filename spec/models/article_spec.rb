require 'rails_helper'

RSpec.describe Article, type: :model do
  subject(:article) { build :article }

  describe 'validations' do
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:body) }
  end
end
