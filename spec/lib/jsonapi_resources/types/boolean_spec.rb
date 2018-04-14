# frozen_string_literal: true

require 'rails_helper'

describe JSONAPI::Server::Types::Boolean do
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

      context 'when the string is f' do
        let(:value) { 'f' }
        it { is_expected.to eq(false) }
      end

      context 'when the string is t' do
        let(:value) { 't' }
        it { is_expected.to eq(true) }
      end

      context 'when the string is F' do
        let(:value) { 'F' }
        it { is_expected.to eq(false) }
      end

      context 'when the string is T' do
        let(:value) { 'T' }
        it { is_expected.to eq(true) }
      end

      context 'when the string is false' do
        let(:value) { 'false' }
        it { is_expected.to eq(false) }
      end

      context 'when the string is true' do
        let(:value) { 'true' }
        it { is_expected.to eq(true) }
      end

      context 'when the string is FALSE' do
        let(:value) { 'FALSE' }
        it { is_expected.to eq(false) }
      end

      context 'when the string is TRUE' do
        let(:value) { 'TRUE' }
        it { is_expected.to eq(true) }
      end

      context 'when the string is off' do
        let(:value) { 'off' }
        it { is_expected.to eq(false) }
      end

      context 'when the string is on' do
        let(:value) { 'on' }
        it { is_expected.to eq(true) }
      end

      context 'when the string is OFF' do
        let(:value) { 'OFF' }
        it { is_expected.to eq(false) }
      end

      context 'when the string is ON' do
        let(:value) { 'ON' }
        it { is_expected.to eq(true) }
      end

      context 'when the string is integer' do
        let(:value) { '123' }
        it { is_expected_block.to raise_exception(JSONAPI::Server::Exceptions::InvalidType) }

        context 'when the integer is 0' do
          let(:value) { '0' }
          it { is_expected.to eq(false) }
        end

        context 'when the integer is 1' do
          let(:value) { '0' }
          it { is_expected.to eq(false) }
        end
      end

      context 'when the string is float' do
        let(:value) { '123.123' }
        it { is_expected_block.to raise_exception(JSONAPI::Server::Exceptions::InvalidType) }
      end
    end

    context 'when value is boolean' do
      context 'when the boolean is true' do
        let(:value) { true }
        it { is_expected.to eq(true) }
      end

      context 'when the boolean is false' do
        let(:value) { false }
        it { is_expected.to eq(false) }
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
