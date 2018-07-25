//
//  Resource.swift
//  Beeer-Beeer
//
//  Created by Sayantan Chakraborty on 25/07/18.
//  Copyright © 2018 Personal. All rights reserved.
//

import Foundation

struct Resource<A> where A:Codable{
    let url: URL
    let parse: (Data) -> Array<A> = { data in return try! JSONDecoder().decode(Array<A>.self, from: data) }
    
}
