require 'rails_helper'

describe Warehouse do 
  context '.all' do
    it 'deve retornar todos os galpões' do 
      json_data = File.read(Rails.root.join('spec/support/json/warehouses.json'))
      fake_response = double("faraday::response", status: 200, body: json_data)
      allow(Faraday).to receive(:get).with("http://localhost:4000/api/v1/warehouses").and_return(fake_response)  

      result = Warehouse.all

      expect(result.length).to eq 2
      expect(result[0].name).to eq 'Galpão Rio de Janeiro'
      expect(result[0].code).to eq 'SDU'
      expect(result[0].city).to eq 'Rio de Janeiro'
      expect(result[0].area).to eq 60000
      expect(result[0].address).to eq 'Avenida Atlantica, 10'
      expect(result[0].cep).to eq '20000-000'
      expect(result[0].description).to eq 'Galpão do aeroporto do Rio'
      expect(result[0].state).to eq 'RJ'
      expect(result[1].name).to eq 'Galpão São Paulo'
      expect(result[1].code).to eq 'GRU'
      expect(result[1].city).to eq 'Guarulhos'
      expect(result[1].area).to eq 100000
      expect(result[1].address).to eq 'Aeroporto de Guarulhos, 2000'
      expect(result[1].cep).to eq '18000-000'
      expect(result[1].description).to eq 'Galpão do aeroporto de São Paulo'
      expect(result[1].state).to eq 'SP'
    end
    it 'deve retornar vazio se a API' do
      fake_response = double("faraday::response", status: 500, body: "{ 'error': 'Erro ao obter dados'}")
      allow(Faraday).to receive(:get).with("http://localhost:4000/api/v1/warehouses").and_return(fake_response)  

      result = Warehouse.all

      expect(result).to eq []
    end
  end
end