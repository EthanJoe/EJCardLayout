//
//  SearchViewController.swift
//  TestBridge
//
//  Created by ZhouYiChen on 4/4/15.
//  Copyright (c) 2015 ZhouYiChen. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    var delegate: SearchViewControllerDelegate?
    
    func numberOfSectionInTableView(tableView: UITableView) -> (NSInteger) {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: NSInteger) -> (NSInteger) {
        return 0;
    }
    
    func searchBarTextDidBeginEditing(searchBar: UISearchBar){
        self.searchBar.setShowsCancelButton(true, animated: true)
        var delegate: SearchViewControllerDelegate = self.delegate!
        delegate.searchControllerWillBeginSearch!(self)
    }
    
    func searchBarTextDidEndEditing(searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(false, animated: true)
    }
    
    func searchBarCancelButtionClicked(searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        var delegate: SearchViewControllerDelegate = self.delegate!
        delegate.searchControllerWillEndSearch!(self)
    }
}

@objc protocol SearchViewControllerDelegate {
    optional func searchControllerWillBeginSearch(controller: SearchViewController)
    optional func searchControllerWillEndSearch(controller: SearchViewController)
}
