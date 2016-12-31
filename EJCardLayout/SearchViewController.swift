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
    
    func numberOfSectionInTableView(_ tableView: UITableView) -> (NSInteger) {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: NSInteger) -> (NSInteger) {
        return 0;
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar){
        self.searchBar.setShowsCancelButton(true, animated: true)
        let delegate: SearchViewControllerDelegate = self.delegate!
        delegate.searchControllerWillBeginSearch!(self)
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(false, animated: true)
    }
    
    func searchBarCancelButtionClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        let delegate: SearchViewControllerDelegate = self.delegate!
        delegate.searchControllerWillEndSearch!(self)
    }
}

@objc protocol SearchViewControllerDelegate {
    @objc optional func searchControllerWillBeginSearch(_ controller: SearchViewController)
    @objc optional func searchControllerWillEndSearch(_ controller: SearchViewController)
}
