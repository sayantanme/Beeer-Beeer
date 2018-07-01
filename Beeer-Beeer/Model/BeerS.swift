//
//  GitHubUser.swift
//  Git-it
//
//  Created by Sayantan Chakraborty on 24/11/17.
//  Copyright © 2017 Sayantan Chakraborty. All rights reserved.
//

import Foundation.NSURL

// Query service creates Track objects
struct BeerS {
    
    let Abv: String?
    let Ibu: String?
    let id: Int?
    let name: String?
    let style: String?
    let ounces: Int?
 
    
    init(Abv: String?, Ibu: String?, id: Int?, name: String?, style: String?, ounces: Int?) {
        self.name = name
        self.Abv = Abv
        self.id = id
        self.Ibu = Ibu
        self.style = style
        self.ounces = ounces
    }
    
}
