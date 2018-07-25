//
//  ViewController.swift
//  Beeer-Beeer
//
//  Created by Sayantan Chakraborty on 29/06/18.
//  Copyright © 2018 Personal. All rights reserved.
//

import UIKit

class ViewController: UITableViewController,Notifier {

    var beerList = [BeerS]()
    let searchController = UISearchController(searchResultsController: nil)
    var filteredbeerList = [BeerS]()
    var activityIndicator = UIActivityIndicatorView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        doSetupWork()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150;
    }
    
    //MARK: - Table View Data Source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering(){
            return filteredbeerList.count
        }else{
            return beerList.count
        }
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "beerCell", for: indexPath) as! BeerCells
        
        let beer: BeerS
        if isFiltering(){
            beer = filteredbeerList[indexPath.row]
        }else{
            beer = beerList[indexPath.row]
        }
        
        cell.beerName.text = beer.name
        cell.beerType.text = beer.style
        cell.beerAlContent.text = "Alcohol Content:\(beer.Abv ?? "")"
        if let ibu = beer.Ibu {
            let intibu = Int(ibu)
            if let IBU = intibu{
                if IBU > 80{
                    cell.beerEmotion.text = "😥"
                }else{
                    cell.beerEmotion.text = "😁"
                }
            }
        }
            

        
        return cell
    }
    
    //MARK: - Button Actions
    
    //Action method sorts the list of Beers ascending or descending
    @IBAction func sortOrFilter(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "Sort", message: "Alcohol Content", preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "Ascending", style: .default , handler:{ (UIAlertAction)in
            //filteredbeerList = filteredbeerList.sort{Int($0.Abv!)! > Int($1.Abv!)!}
            self.beerList = self.beerList.sorted(by: {Double($0.Abv!)! < Double($1.Abv!)!})
            self.tableView.reloadData()
        }))
        
        alert.addAction(UIAlertAction(title: "Descending", style: .default , handler:{ (UIAlertAction)in
            self.beerList = self.beerList.sorted(by: {Double($0.Abv!)! > Double($1.Abv!)!})
            self.tableView.reloadData()
        }))
        
        
        alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler:{ (UIAlertAction)in
            print("User click Dismiss button")
        }))
        
        self.present(alert, animated: true, completion: {
            self.tableView.reloadData()
        })
    }
    
}

/// Extension to set up the View Controller
extension ViewController {
    
    
    /// Setup work calls the http method to fetch list of bears asynchronously
    fileprivate func doSetupWork(){
        activityIndicator.startAnimating()
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        
        // Setup the Search Controller
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Beers by Name or Style"
        navigationItem.searchController = searchController
        definesPresentationContext = true
        
        self.navigationItem.title = "Beeer-Cheer"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        self.view.addSubview(activityIndicator)
        
        tableView.refreshControl = UIRefreshControl()
        
        tableView.refreshControl?.addTarget(self, action: #selector(fetchDataFromNetwork), for: UIControl.Event.valueChanged)
        
        
        fetchDataFromNetwork()
        
    }
    
    @objc fileprivate func fetchDataFromNetwork(){
        
        if let url = URL(string: "http://starlord.hackerearth.com/beercraft") {
            let beerResource = Resource<BeerS>(url:url)
            NetworkQueries().load(beerResource) { (beers) in
                if let beerss = beers{
                    self.beerList = beerss
                    self.filteredbeerList=beerss
                    DispatchQueue.main.async{
                        self.activityIndicator.stopAnimating()
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        self.tableView.refreshControl?.endRefreshing()
                        self.tableView.reloadData()
                    }
                }
            }
        }
    }
}


