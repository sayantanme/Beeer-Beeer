//
//  BeerSCodable.swift
//  Beeer-Beeer
//
//  Created by Sayantan Chakraborty on 02/07/18.
//  Copyright © 2018 Personal. All rights reserved.
//

import Foundation

struct BeerS: Codable {
    let Abv: String?
    let Ibu: String?
    let id: Int?
    let name: String?
    let style: String?
    let ounces: Double?
    
    enum CodingKeys: String, CodingKey {
        case Abv = "abv"
        case Ibu = "ibu"
        case id
        case name
        case style
        case ounces
    }
    
    init(from decoder:Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        let _abv = try values.decode(String.self, forKey: .Abv)
        Abv = _abv == "" ? "0": _abv
        Ibu = try values.decode(String.self, forKey: .Ibu)
        id = try values.decode(Int.self, forKey: .id)
        name = try values.decode(String.self, forKey: .name)
        style = try values.decode(String.self, forKey: .style)
        ounces = try values.decode(Double.self, forKey: .ounces)
    }
    
}
