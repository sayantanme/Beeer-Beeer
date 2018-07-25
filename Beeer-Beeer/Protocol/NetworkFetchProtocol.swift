//
//  NetworkQueriesProtocol.swift
//  Beeer-Beeer
//
//  Created by Sayantan Chakraborty on 24/07/18.
//  Copyright © 2018 Personal. All rights reserved.
//

import Foundation
protocol NetworkFetchProtocol {
    //var url: URL { get set}
    associatedtype T:Codable
    func getData(from resource:Resource<T>,completionHandler:([Codable]?) -> Void)
}


extension NetworkFetchProtocol {
    func getData(from resource:Resource<T>,completionHandler:@escaping ([Codable]?) -> Void){
        NetworkQueries().load(resource) { (beers) in
            guard let beers = beers else {
                return completionHandler(nil)
            }
            return completionHandler(beers)
        }
    }
}
