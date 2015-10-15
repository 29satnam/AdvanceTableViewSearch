//
//  ViewController.swift
//  searchShit
//
//  Created by Satnam Sync on 24/08/15.
//  Copyright (c) 2015 Satnam Sync. All rights reserved.
//

import UIKit

class GreetingNewViewController: UIViewController, UISearchResultsUpdating, UISearchBarDelegate {
    
    @IBOutlet weak var collectionView: UITableView!
    @IBOutlet weak var searchbarView: UIView!
    
    var resultSearchController = UISearchController()
    var searchButton: UIBarButtonItem!
    
    
    var items:[String: [AnyObject]]!
    var filteredItems: [String: [AnyObject]]!
    var dataSource: MultiSectionCollectionViewDataSource!
    
    var dvcData: AnyObject! //  data for destinationViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.items = GreetingObjectHandler(filename: CAConstant.GreetingJSONFileName).getGreetingsAsAnyObjects()

        filteredItems = items

        self.dataSource = MultiSectionCollectionViewDataSource(items: filteredItems, cellIdentifier: CAConstant.GreetingNewViewControllerCell, viewController: self, segueIdentifier: CAConstant.GreetingNewViewControllerSegue, configureBlock: { (cell, item) -> () in
            let actualCell = cell as! CollectionViewCell
            actualCell.configureForItem(item)
            actualCell.backgroundColor = UIColor.whiteColor()
        })
        
        self.collectionView.reloadData()
        
        collectionView.dataSource = dataSource
        collectionView.delegate = dataSource
        
        addSearchBar()
        
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        //if let dvc = segue.destinationViewController as? SelectedFreelancerViewController {
         //   dvc.data = dvcData
       // }
    }
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        self.navigationItem.titleView = nil
        self.navigationItem.rightBarButtonItem = searchButton
    }
    
    func showSearch() {
        self.navigationItem.rightBarButtonItem = nil
        self.navigationItem.titleView = resultSearchController.searchBar
        resultSearchController.searchBar.becomeFirstResponder()
    }
    
    
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        
        let searchText = searchController.searchBar.text
        
        if searchText == nil || searchText == "" {
            filteredItems = items
        } else {
            
            var tempArray = items[CAConstant.GreetingOBJHandlerSectionKey]
            // Be careful when to cast the data. Here it must be at the right side, or it will not work.
            tempArray = (tempArray as! [Greeting]).filter{ $0.language.lowercaseString.rangeOfString(searchController.searchBar.text!) != nil || $0.greetingText.lowercaseString.rangeOfString(searchController.searchBar.text!) != nil }
            
            filteredItems[CAConstant.GreetingOBJHandlerSectionKey] = tempArray
            
        }
        
        dataSource.updateItems(filteredItems)
        
        self.collectionView.reloadData()
        
    }
    
    func addSearchBar() {
        searchButton = UIBarButtonItem(barButtonSystemItem: .Search, target: self, action: "showSearch")
        navigationItem.rightBarButtonItem = searchButton
        self.resultSearchController = {
            let controller = UISearchController(searchResultsController: nil)
            controller.searchResultsUpdater = self
            controller.dimsBackgroundDuringPresentation = false
            controller.hidesNavigationBarDuringPresentation = false  // default true
            controller.searchBar.sizeToFit()
            return controller
            }()
        
        self.resultSearchController.searchBar.delegate = self
    }
    
}

struct CAConstant {
    static let GreetingNewViewControllerCell = "coCell"
    static let GreetingNewViewControllerSegue = "showGreetingDetail"
    static let GreetingJSONFileName = "greetings"
    static let GreetingOBJHandlerSectionKey = "section0"
}