//
//  Order.swift
//  Project_9_Cupcake_Corner
//
//  Created by Thomas George on 16/09/2021.
//

import Foundation


class Order: ObservableObject, Codable {
    enum CodingKeys: CodingKey {
        case type, quantity, extraFrosting, addSprinkles, name, streetAddress, city, zip
    }
    
    static let types: [String] = ["Vanilla", "Strawberry", "Chocolate", "Rainbow"]
    
    @Published var type: Int = 0
    @Published var quantity: Int = 3
    @Published var isSpecialRequest: Bool = false {
        didSet {
            if isSpecialRequest == false {
                isExtraFrosting = false
                isAddSprinkles = false
            }
        }
    }
    @Published var isExtraFrosting: Bool = false
    @Published var isAddSprinkles: Bool = false
    
    @Published var name: String = ""
    @Published var streetAddress: String = ""
    @Published var city: String = ""
    @Published var zip: String = ""
    var hasValidAddress: Bool {
        let name: String = name.trimmingCharacters(in: .whitespaces)
        let streetAddress: String = streetAddress.trimmingCharacters(in: .whitespaces)
        let city: String = city.trimmingCharacters(in: .whitespaces)
        let zip: String = zip.trimmingCharacters(in: .whitespaces)
        
        if name.isEmpty || streetAddress.isEmpty || city.isEmpty || zip.isEmpty {
            return false
        }
        
        return true
    }
    
    var cost: Double {
        // $2 per cake
        var cost = Double(quantity) * 2

        // complicated cakes cost more
        cost += (Double(type) / 2)

        // $1/cake for extra frosting
        if isExtraFrosting {
            cost += Double(quantity)
        }

        // $0.50/cake for sprinkles
        if isAddSprinkles {
            cost += Double(quantity) / 2
        }

        return cost
    }
    
    init() { }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        type = try container.decode(Int.self, forKey: .type)
        quantity = try container.decode(Int.self, forKey: .quantity)

        isExtraFrosting = try container.decode(Bool.self, forKey: .extraFrosting)
        isAddSprinkles = try container.decode(Bool.self, forKey: .addSprinkles)

        name = try container.decode(String.self, forKey: .name)
        streetAddress = try container.decode(String.self, forKey: .streetAddress)
        city = try container.decode(String.self, forKey: .city)
        zip = try container.decode(String.self, forKey: .zip)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(type, forKey: .type)
        try container.encode(quantity, forKey: .quantity)

        try container.encode(isExtraFrosting, forKey: .extraFrosting)
        try container.encode(isAddSprinkles, forKey: .addSprinkles)

        try container.encode(name, forKey: .name)
        try container.encode(streetAddress, forKey: .streetAddress)
        try container.encode(city, forKey: .city)
        try container.encode(zip, forKey: .zip)
    }
}
