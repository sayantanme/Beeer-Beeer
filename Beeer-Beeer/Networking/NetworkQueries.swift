//
//  NetworkQueries.swift
//  Git-it
//
//  Created by Sayantan Chakraborty on 24/11/17.
//  Copyright © 2017 Sayantan Chakraborty. All rights reserved.
//

import Foundation

// Runs query data task, and stores results in array of Tracks
struct NetworkQueries {
    
    func load<A>(_ resource: Resource<A>, completion: @escaping ([A]?) -> ()){
        let urlSession = URLSession(configuration: .default)
        var dataTask:URLSessionDataTask?
        
        dataTask = urlSession.dataTask(with: resource.url, completionHandler: { (data, response, error) in
            defer {dataTask = nil}
            
            guard error == nil else{
                completion(nil)
                return
            }
            completion(data.flatMap(resource.parse))
            
        })
        dataTask?.resume()
    }
    
}
