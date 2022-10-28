class Warehouse
  attr_accessor :id, :name, :code, :city, :state, :address, :cep, :area, :description

  def initialize(id:, name:, code:, city:, state:, address:, area:, description:, cep:)
    @id = id
    @name = name
    @code = code
    @city = city
    @area = area
    @address = address
    @cep = cep
    @description = description
    @state = state
  end
  def self.all
    warehouses = [] 
    response = Faraday.get('http://localhost:4000/api/v1/warehouses')
    if response.status == 200
      data = JSON.parse(response.body)
        data.each do |d|
          warehouses << Warehouse.new(id: d["id"], name: d["name"], code: d["code"], city: d["city"], state: d["state"], area: d["area"], address: d["address"], cep: d["cep"], description: d["description"])
      end
    end
    
    warehouses
  end

end 