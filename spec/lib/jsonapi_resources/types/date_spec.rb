# frozen_string_literal: true

require 'rails_helper'

describe JSONAPI::Server::Types::Date do
  describe '#deserialize' do
    subject { described_class.new.deserialize(value) }

    context 'when value is nil' do
      let(:value) { nil }
      it { is_expected.to eq(nil) }
    end

    context 'when value is string' do
      let(:value) { 'test' }
      it { is_expected_block.to raise_exception(JSONAPI::Server::Exceptions::InvalidType) }

      context 'when the string is empty' do
        let(:value) { '' }
        it { is_expected.to eq(nil) }
      end

      context 'when the string is integer' do
        let(:value) { '123' }
        it { is_expected_block.to raise_exception(JSONAPI::Server::Exceptions::InvalidType) }
      end

      context 'when the string is float' do
        let(:value) { '123.123' }
        it { is_expected_block.to raise_exception(JSONAPI::Server::Exceptions::InvalidType) }
      end

      context 'when the string is a date' do
        let(:value) { '10-10-1990' }
        it { is_expected_block.to raise_exception(JSONAPI::Server::Exceptions::InvalidType) }
      end

      context 'when the string is a date in iso8601' do
        let(:value) { '1990-10-10' }
        it { is_expected.to eq(Date.parse('1990-10-10')) }
      end

      context 'when the string is a datetime in iso8601' do
        let(:value) { '1990-10-10T19:20:20' }
        it { is_expected.to eq(Date.parse('1990-10-10')) }
      end
    end

    context 'when value is boolean' do
      context 'when the boolean is true' do
        let(:value) { true }
        it { is_expected_block.to raise_exception(JSONAPI::Server::Exceptions::InvalidType) }
      end

      context 'when the boolean is false' do
        let(:value) { false }
        it { is_expected_block.to raise_exception(JSONAPI::Server::Exceptions::InvalidType) }
      end
    end

    context 'when value is array' do
      let(:value) { ['test'] }
      it { is_expected_block.to raise_exception(JSONAPI::Server::Exceptions::InvalidType) }

      context 'when the array is empty' do
        let(:value) { [] }
        it { is_expected_block.to raise_exception(JSONAPI::Server::Exceptions::InvalidType) }
      end
    end

    context 'when value is hash' do
      let(:value) { { test: 'works' } }
      it { is_expected_block.to raise_exception(JSONAPI::Server::Exceptions::InvalidType) }

      context 'when the hash is empty' do
        let(:value) { {} }
        it { is_expected_block.to raise_exception(JSONAPI::Server::Exceptions::InvalidType) }
      end
    end

    context 'when value is number' do
      context 'when the number is integer' do
        let(:value) { 123 }
        it { is_expected_block.to raise_exception(JSONAPI::Server::Exceptions::InvalidType) }
      end

      context 'when the number is float' do
        let(:value) { 123.456 }
        it { is_expected_block.to raise_exception(JSONAPI::Server::Exceptions::InvalidType) }
      end
    end
  end
end
