require 'rails_helper'

describe API::V1::Users::Resource do
  describe '#find' do
    let(:user) { User.create }

    subject { described_class.find(user.id) }

    it 'does something' do
      is_expected.to be_an(described_class)
    end
  end

  describe '#all' do
    subject { described_class.all }

    it 'does something' do
      expect(subject.count).to eq(2)
    end
  end
end
