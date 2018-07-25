//
//  VCSearchBarExtension.swift
//  Beeer-Beeer
//
//  Created by Sayantan Chakraborty on 25/07/18.
//  Copyright © 2018 Personal. All rights reserved.
//

import Foundation
import UIKit

extension ViewController:UISearchResultsUpdating{
    
    // MARK: - UISearchResultsUpdating Delegate
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
    
    
    fileprivate func searchBarIsEmpty() -> Bool {
        // Returns true if the text is empty or nil
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    /// searches for the matching terms in the search bar from 2 different fields.
    fileprivate func filterContentForSearchText(_ searchText: String, scope: String = "All") {
        filteredbeerList = self.beerList.filter({( beer : BeerS) -> Bool in
            if (beer.name?.lowercased().contains(searchText.lowercased()))!{
                return true
            }else if (beer.style?.lowercased().contains(searchText.lowercased()))!{
                return true
            }else{
                return false
            }
            
        })
        
        tableView.reloadData()
    }
    
    /// keeps a track whether the search bar is active or not.
    func isFiltering() -> Bool {
        return searchController.isActive && !searchBarIsEmpty()
    }
}
