require 'spec_helper'

describe Thorwald::Exporter do
  let(:subject) { described_class.new(Document, parameters, options) }
  let(:options) { {} }
  let(:parameters) { {} }
  let(:documents) do
    Timecop.freeze(2.days.ago) do
      3.times { Document.create }
    end
    Document.all.order(:id)
  end

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
        documents
      end

      context 'but no paramters where given' do
        it 'returns only the last document' do
          expect(subject.as_json).to eq([documents.last.as_json])
        end
      end

      context 'and last record parameter is given as the first element' do
        let(:parameters) { { last_record: Document.first.id } }

        it 'returns all documents but the first' do
          expect(subject.as_json).to eq(documents.offset(1).limit(2).as_json)
        end

        context 'and count is given' do
          let(:parameters) { { last_record: Document.first.id, count: 1 } }

          it 'returns a limited set' do
            expect(subject.as_json).to eq([documents.second.as_json])
          end
        end
      end

      context 'when givin options for attribute fetch' do
        let(:options) { { attribute: :updated_at } }
        let(:second) { documents.second }

        before do
          second.update(name: :new_name)
          second.reload
        end

        it 'returns the document updated' do
          expect(subject.as_json).to eq([second.as_json])
        end

        context 'wben passing another target time' do
          let(:parameters) { { last_record: documents.third.updated_at.to_s} }
          let(:third) { documents.third }

          before do
            second.update(name: :new_name)
            third.update(name: :new_name)
            second.reload
            third.reload
          end

          it 'returns the document updated after the last one' do
            expect(subject.as_json).to eq(documents.offset(1).as_json)
          end
        end
      end
    end
  end
end
