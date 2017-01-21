require 'spec_helper'

describe Thorwald::Exporter do
  let(:subject) { described_class.new(Document, parameters, options) }
  let(:options) { {} }
  let(:parameters) { {} }

  before do
    Document.delete_all
  end

  describe '#as_json' do
    context 'when there are no documents' do
      it 'returns the documents found as json' do
        expect(subject.as_json).to be_empty
      end
    end

    context 'when there are documents' do
      before do
        3.times { Document.create }
      end

      context 'but no paramters where given' do
        it 'returns only the last document' do
          expect(subject.as_json).to eq([Document.last.as_json])
        end
      end

      context 'and last record parameter is given' do
        let(:parameters) { { last_record: Document.first.id } }

        it 'returns all documents but the first' do
          expect(subject.as_json).to eq(Document.all.offset(1).limit(2).as_json)
        end
      end
    end
  end
end
