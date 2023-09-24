require 'rails_helper'

RSpec.describe LandlordSerializer do
  let(:id) { '6d2b8c95-25fa-403e-81a1-9e2044dd34de' }
  let(:name) { 'John Doe' }
  let(:expected_json) do
    {
      'data': {
        'id': id,
        'type': 'landlord',
        'attributes': {
          'name': name
        }
      }
    }
  end

  let(:landlord) { FactoryBot.build_stubbed(:landlord, id: id , name: name) }

  subject { described_class.new(landlord).serializable_hash.to_json }

  it 'serializes the landlord' do
    expect(subject).to eq(expected_json.to_json)
  end
end