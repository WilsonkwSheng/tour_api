require 'rails_helper'

RSpec.describe Customer, type: :model do
  it { should validate_presence_of :name }
  it { should validate_presence_of :email }
  it { should validate_presence_of :password }

  describe '#uniqueness' do
    context 'email' do
      let!(:customer) { create(:customer) }
      let!(:customer_2) { create(:customer) }

      it do
        customer_2.update(email: customer.email)

        expect(customer_2.valid?).to eq(false)
        expect(customer_2.errors.full_messages).to eq(['Email has already been taken'])
      end
    end
  end

  describe '#email format' do
    context 'invalid' do
      let!(:customer) { create(:customer) }

      it do
        customer.update(email: 'invalid')

        expect(customer.valid?).to eq(false)
        expect(customer.errors.full_messages).to eq(['Email is invalid'])
      end
    end
  end
end
