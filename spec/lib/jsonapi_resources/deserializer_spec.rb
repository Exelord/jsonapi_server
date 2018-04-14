# frozen_string_literal: true

require 'rails_helper'

describe JSONAPI::Server::Deserializer do
  let(:types) { {} }
  let(:resources) { {} }
  let(:attributes) { {} }
  let(:relationships) { {} }

  let(:deserializer) do
    described_class.new(resources: resources, attributes: attributes, relationships: relationships, types: types)
  end

  describe '.initialize' do
    let(:types) { { integer: true } }
    let(:resources) { { my_resource: true } }
    let(:attributes) { { attr: true } }
    let(:relationships) { { rel: true } }

    it 'expose correct readers' do
      expect(deserializer.types).to eq(types)
      expect(deserializer.resources).to eq(resources)
      expect(deserializer.attributes).to eq(attributes)
      expect(deserializer.relationships).to eq(relationships)
    end
  end

  describe '#deserialize_relationship' do
    let(:payload) { {} }

    subject(:params) { deserializer.deserialize_relationship(payload) }

    context 'when payload is invalid JSONAPI object' do
      it { is_expected_block.to raise_exception(JSONAPI::Server::Exceptions::InvalidPayload) }
    end

    context 'id' do
      subject { params[:id] }

      let(:types) { { integer: JSONAPI::Server::Types::Integer } }
      let(:resources) { { user: { model_name: 'User' } } }
      let(:payload) { { data: { id: '23', type: 'user' } } }

      it { is_expected.to eq 23 }

      context 'when id is empty string' do
        let(:payload) { { data: { id: '', type: 'user' } } }

        it { is_expected.to eq nil }
      end
    end

    context 'type' do
      subject { params[:type] }

      context 'when resource exists in API' do
        let(:resources) { { user: { model_name: 'User' } } }
        let(:payload) { { data: { id: '1', type: 'user' } } }

        it { is_expected.to eq 'User' }
      end

      context 'when resource not exists in API' do
        let(:payload) { { data: { id: '1', type: 'user' } } }

        it { is_expected_block.to raise_exception(JSONAPI::Server::Exceptions::InvalidResourceType) }
      end
    end
  end

  describe '#deserialize' do
    let(:payload) { {} }

    subject(:params) { deserializer.deserialize(payload) }

    context 'when payload is invalid JSONAPI object' do
      it { is_expected_block.to raise_exception(JSONAPI::Server::Exceptions::InvalidPayload) }
    end

    context 'id' do
      subject { params[:id] }

      let(:types) { { integer: JSONAPI::Server::Types::Integer } }
      let(:resources) { { user: { model_name: 'User' } } }
      let(:payload) { { data: { id: '23', type: 'user' } } }

      it { is_expected.to eq 23 }

      context 'when id is empty string' do
        let(:payload) { { data: { id: '', type: 'user' } } }

        it { is_expected.to eq nil }
      end
    end

    context 'type' do
      subject { params[:type] }

      context 'when resource exists in API' do
        let(:resources) { { user: { model_name: 'User' } } }
        let(:payload) { { data: { type: 'user' } } }

        it { is_expected.to eq 'User' }
      end

      context 'when resource not exists in API' do
        let(:payload) { { data: { type: 'user' } } }

        it { is_expected_block.to raise_exception(JSONAPI::Server::Exceptions::InvalidResourceType) }
      end
    end

    context 'attributes' do
      let(:types) do
        {
          string: JSONAPI::Server::Types::String,
          date: JSONAPI::Server::Types::Date
        }
      end

      let(:resources) do
        {
          user: { model_name: 'User' }
        }
      end

      let(:attributes) do
        {
          name: { name: :name, type: :string },
          birthday: { name: :birthday, type: :date }
        }
      end

      let(:payload) do
        {
          data: {
            type: 'users',
            attributes: {
              name: 'Ember Hamster',
              birthday: Date.parse('01.04.2018').iso8601,
              filterred: true
            }
          }
        }
      end

      let(:expected_attributes) do
        {
          name: 'Ember Hamster',
          birthday: Date.parse('01.04.2018')
        }
      end

      subject { deserializer.deserialize(payload)[:attributes] }

      it { is_expected.to eq(expected_attributes) }
    end

    context 'relationships' do
      let(:types) { { integer: JSONAPI::Server::Types::Integer } }

      let(:resources) do
        {
          user: { model_name: 'User' },
          account: { model_name: 'Account' },
          user_profile: { model_name: 'Profile' }
        }
      end

      let(:relationships) do
        {
          active_accounts: {},
          profile: {}
        }
      end

      let(:payload) do
        {
          data: {
            type: 'users',
            relationships: {
              active_accounts: {
                data: [
                  { type: 'accounts', id: '1' },
                  { type: 'accounts', id: '2' }
                ]
              },
              profile: {
                data: { type: 'user-profiles', id: '3' }
              },
              filltered: {
                data: { type: 'none', id: '4' }
              }
            }
          }
        }
      end

      let(:expected_relationships) do
        {
          active_accounts: [{ id: 1, type: 'Account' }, { id: 2, type: 'Account' }],
          profile: { id: 3, type: 'Profile' }
        }
      end

      subject { deserializer.deserialize(payload)[:relationships] }

      it { is_expected.to eq(expected_relationships) }
    end
  end
end
