//
//  NetworkQueries.swift
//  Git-it
//
//  Created by Sayantan Chakraborty on 24/11/17.
//  Copyright © 2017 Sayantan Chakraborty. All rights reserved.
//

import Foundation

// Runs query data task, and stores results in array of Tracks
class NetworkQueries {
    
    typealias JSONDictionary = [String: Any]
    typealias QueryResult = (BeerS?, String) -> ()
    typealias QueryResultRepos = ([BeerS]?,String)-> ()
    
    var beer: BeerS?
    var errorMessage = ""
    var beers: [BeerS] = []
    
    let urlSession = URLSession(configuration: .default)
    var dataTask:URLSessionDataTask?

    /// calls the http method to fetch records asynchronously. Handles errors and passes off to other method to parse the data.
    func fetchBeerRepos(completion: @escaping QueryResultRepos) {
        
        dataTask?.cancel()
        if var urlComponents = URLComponents(string: "http://starlord.hackerearth.com/beercraft"){
            //urlComponents.query = "media=music&entity=song&term=\(searchTerm)"
            
            guard let url = urlComponents.url else {return}
            
            dataTask = urlSession.dataTask(with: url, completionHandler: { (data, response, error) in
                defer {self.dataTask = nil}
                
                if let error = error {
                    self.errorMessage += "DataTask error: " + error.localizedDescription + "\n"
                }else if let data = data,let response = response as? HTTPURLResponse, response.statusCode == 200{
                    self.formBeerModels(data)
                    
                    DispatchQueue.main.async {
                        completion(self.beers, self.errorMessage)
                    }
                }
            })
            dataTask?.resume()
        }
    }
    
    ///parses the data to for the Beer Models to be used. 
    fileprivate func formBeerModels(_ data: Data) {
        var response: [Any]?
        do {
            response = try JSONSerialization.jsonObject(with: data, options: []) as? [Any]
        } catch let parseError as NSError {
            errorMessage += "JSONSerialization error: \(parseError.localizedDescription)\n"
            return
        }
        
        guard let allData = response else {
            errorMessage += "Response could not be parsed\n"
            return
        }
        
        for item in allData{
            if let dict = item as? [String:Any]{
                var abv = dict["abv"] as? String
                if abv == nil || abv == ""{
                    abv = "0"
                }
                let ibu = dict["ibu"] as? String
                let id = dict["id"] as? Int
                let name = dict["name"] as? String
                let style = dict["style"] as? String
                let ounces = dict["ounces"] as? Int
                
                let repo = BeerS(Abv: abv, Ibu: ibu, id: id, name: name, style: style, ounces: ounces)
                self.beers.append(repo)
            }
        }
        
    }
    
}
