require 'spec_helper'

describe Thorwald::Exporter do
  let(:subject) { described_class.new(Document, parameters, options) }
  let(:options) { {} }
  let(:parameters) { {} }

  describe '#as_json' do
    context 'when there are no documents' do
      it 'returns the documents found as json' do
        expect(subject.as_json).to be_empty
      end
    end
  end
end
