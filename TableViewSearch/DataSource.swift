//
//  MultiSectionCollectionViewDataSource.swift
//  searchShit
//
//  Created by Satnam Sync on 24/08/15.
//  Copyright (c) 2015 Satnam Sync. All rights reserved.
//

import UIKit


typealias CollectionViewCellConfigureBlock = (cell:UITableViewCell, item:AnyObject?) -> ()

class MultiSectionCollectionViewDataSource: NSObject, UITableViewDataSource, UITableViewDelegate {
    
    var items: [[AnyObject]]!
    var keys:[String]!
    
    var itemIdentifier:String?
    var configureCellBlock:CollectionViewCellConfigureBlock?
    
    var viewController: AnyObject!
    var segueIdentifier: String!
    
    init(items: [String: [AnyObject]], cellIdentifier: String, viewController: AnyObject, segueIdentifier:String, configureBlock: CollectionViewCellConfigureBlock) {
        
        self.itemIdentifier = cellIdentifier
        self.viewController = viewController
        self.segueIdentifier = segueIdentifier
        self.configureCellBlock = configureBlock
        
        for (K,V) in items {
            if keys == nil {
                self.items = [V]
                self.keys = [K]
            } else {
                self.keys.append(K)
                self.items.append(V)
            }
        }
        
    }
    
    func updateItems(items:[String: [AnyObject]]){
        self.items = nil
        self.keys = nil
        
        for (K,V) in items {
            if keys == nil {
                self.items = [V]
                self.keys = [K]
            } else {
                self.keys.append(K)
                self.items.append(V)
            }
        }
        
    }
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items[section].count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        //let cell = collectionView.dequeueReusableCellWithReuseIdentifier(self.itemIdentifier!, forIndexPath: indexPath) as UICollectionViewCell
        let cell = tableView.dequeueReusableCellWithIdentifier(self.itemIdentifier!, forIndexPath: indexPath) 
        let item: AnyObject = self.itemAtIndexPath(indexPath)
        
        if (self.configureCellBlock != nil) {
            self.configureCellBlock!(cell: cell, item: item)
        }
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if let vc = viewController as? GreetingNewViewController {
            vc.dvcData = items[indexPath.section][indexPath.row]
            print(vc.dvcData)
            vc.performSegueWithIdentifier("toSelectedFreelancer", sender: viewController)
            
        } else {
            print("can not convert view controller")
        }
    }
    
    func itemAtIndexPath(indexPath: NSIndexPath) -> AnyObject {
        return self.items[indexPath.section][indexPath.row]
    }
    
    
}