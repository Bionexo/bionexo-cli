require 'spec_helper'

describe QuoteCreator do
  describe '#create_or_continue' do
    let(:user_answers) do
      {
        title: 'test title',
        address: 'test address',
        email: 'email@test.com',
        phone_number: '(11) 55 98765-4322',
        product_name: 'Test product',
        product_quantity: product_quantity,
        quotation_type: 'private'
      }
    end

    let(:subject) { QuoteCreator.new }
    let(:quotation) { subject.instance_values['quotation'] }
    let(:product_quantity) { 2 }

    before do
      allow(subject).to receive(:exit_application).and_raise
      allow(subject).to receive(:tell)
      allow(subject).to receive(:ask)

      user_answers.each do |k, v|
        allow(subject).to receive(:ask_and_update).with(k.to_s) do
          quotation.update_attribute(k, v)
          subject.send(:validate, k.to_s)
        end
      end
    end

    after { subject.create_or_continue rescue nil }

    context 'with only valid inputs' do
      context 'when create a new quotation' do
        it 'asks for all editables attributes' do
          QuoteCreator::EDITABLE_ATTRS.each do |attr|
            expect(subject).to receive(:ask_and_update).with(attr)
          end
        end
      end

      context 'when continue a quotation' do
        let(:quotation) { Quotation.new(title: 'teste') }
        let(:subject) { QuoteCreator.new quotation }

        it 'not ask for the present attributes' do
          expect(subject).to_not receive(:ask_and_update).with('title')
        end

        it 'asks for the nil attributes' do
          expect(subject).to receive(:ask_and_update).with('address')
        end
      end
    end

    context 'with invalid attributes' do
      let(:product_quantity) { 'invalid' }

      it 'does not ask for the next question' do
        expect(subject).to_not receive(:ask_and_update).with('quotation_type')
      end
    end
  end
end
