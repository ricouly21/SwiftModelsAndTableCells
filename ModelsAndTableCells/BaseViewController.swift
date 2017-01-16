//
//  BaseViewController.swift
//  ModelsAndTableCells
//
//  Created by justine tabin on 16/01/2017.
//
//

import Foundation
import UIKit


class BaseViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        hideBackButtonText()
        
    }
    
    func initBaseTableView(tableView: UITableView?) {
        if let tableView = tableView {
            tableView.translatesAutoresizingMaskIntoConstraints = false
            self.view.addSubview(tableView)
            
            let top = NSLayoutConstraint(item: tableView, attribute: .top, relatedBy: .equal, toItem: self.view, attribute: .top, multiplier: 1, constant: 0)
            
            let leading = NSLayoutConstraint(item: tableView, attribute: .leading, relatedBy: .equal, toItem: self.view, attribute: .leading, multiplier: 1, constant: 0)
            
            let trailing = NSLayoutConstraint(item: tableView, attribute: .trailing, relatedBy: .equal, toItem: self.view, attribute: .trailing, multiplier: 1, constant: 0)
            
            let bottom = NSLayoutConstraint(item: tableView, attribute: .bottom, relatedBy: .equal, toItem: self.view, attribute: .bottom, multiplier: 1, constant: 0)
            
            NSLayoutConstraint.activate([top, leading, trailing, bottom])
        }
    }
    
    func hideBackButtonText() {
        let backButton = UIBarButtonItem()
        backButton.title = ""
        self.navigationItem.backBarButtonItem = backButton
    }
    
}
