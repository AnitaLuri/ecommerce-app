require 'rails_helper'

describe 'Usuário visita tela inicial' do
  it 'e ve galpões' do
    json_data = File.read(Rails.root.join('spec/support/json/warehouses.json'))
    fake_response = double("faraday::response", status: 200, body: json_data)
    allow(Faraday).to receive(:get).with('http://localhost:4000/api/v1/warehouses').and_return(fake_response)

    visit root_path

    expect(page).to have_content 'E-Commerce App'
    expect(page).to have_content 'Galpão Rio de Janeiro'
    expect(page).to have_content 'São Paulo'
    expect(page).not_to have_content 'Nenhum galpão encontrado'
  end
  it 'e não existem galpões' do
    fake_response = double("faraday::response", status: 200, body: "{}")
    allow(Faraday).to receive(:get).with('http://localhost:4000/api/v1/warehouses').and_return(fake_response)

    visit root_path

    expect(page).to have_content 'Nenhum galpão encontrado'
  end
  it 'e vê detalhes de galpão' do
    json_data = File.read(Rails.root.join('spec/support/json/warehouses.json'))
    fake_response = double("faraday::response", status: 200, body: json_data)
    allow(Faraday).to receive(:get).with("http://localhost:4000/api/v1/warehouses").and_return(fake_response)
    
    json_data = File.read(Rails.root.join('spec/support/json/warehouse.json'))
    fake_response = double("faraday::response", status: 200, body: json_data)
    allow(Faraday).to receive(:get).with("http://localhost:4000/api/v1/warehouses/2").and_return(fake_response)

    visit root_path
    click_on "Galpão São Paulo"

    expect(page).to have_content 'Galpão São Paulo - GRU'
    expect(page).to have_content 'Guarulhos'
    expect(page).to have_content '100000m²'
    expect(page).to have_content 'Aeroporto de Guarulhos, 2000'
    expect(page).not_to have_content 'Não foi possível carregar o galpão'
  end
  it 'e não é possível carregar o galpão' do
    json_data = File.read(Rails.root.join('spec/support/json/warehouses.json'))
    fake_response = double("faraday::response", status: 200, body: json_data)
    allow(Faraday).to receive(:get).with("http://localhost:4000/api/v1/warehouses").and_return(fake_response)
    
    error_response = double("faraday::response", status: 500, body: "{}")
    allow(Faraday).to receive(:get).with("http://localhost:4000/api/v1/warehouses/2").and_return(error_response)

    visit root_path
    click_on "Galpão São Paulo"

    expect(page).to have_content 'Não foi possível carregar o galpão'
    expect(current_path).to eq root_path
  end
end