# frozen_string_literal: true

require 'rails_helper'

describe Api::V1::Server do
  let(:server) { described_class.new }

  describe '.create' do
    let(:account) { create(:account) }
    let(:payload) do
      {
        'data': {
          'type': 'users',
          'attributes': {
            'name': 'Ember Hamster',
            'email': 'ember@hamster.com'
          },
          'relationships': {
            'account': {
              'data': { 'type': 'account', 'id': account.id.to_s }
            }
          }
        }
      }
    end

    subject { server.create('users', payload) }

    it { expect { subject }.to change { User.count }.by(1) }
    it { is_expected.to be_instance_of(Api::V1::Users::Resource) }

    it 'creates user with correct data' do
      subject
      user = User.last

      expect(user).to be_persisted
      expect(user).to be_valid
      expect(user.name).to eq('Ember Hamster')
      expect(user.email).to eq('ember@hamster.com')
      expect(user.account_id).to eq(account.id)
    end
  end
end
