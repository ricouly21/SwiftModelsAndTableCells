//
//  ProfileEditViewController.swift
//  ModelsAndTableCells
//
//  Created by justine tabin on 17/01/2017.
//
//

import Foundation
import UIKit


class ProfileEditViewController: BaseViewController {
    
    let mainTableView: UITableView? = UITableView()
    
    var object: Object? = Object()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "EDIT PROFILE"
        
        let saveButton = UIBarButtonItem(barButtonSystemItem: .save, target: self,
                                         action: #selector(self.saveButtonAction(sender:)))
        self.navigationItem.setRightBarButton(saveButton, animated: false)
        
        self.initBaseTableView(tableView: self.mainTableView)
        self.mainTableView?.delegate = self
        self.mainTableView?.dataSource = self
        
        let cell = UINib(nibName: "LabelTextViewTableCell", bundle: nil)
        self.mainTableView?.register(cell, forCellReuseIdentifier: "cell")
        
    }
    
    func saveButtonAction(sender: AnyObject) {
        guard let navigationController = self.navigationController else { return }
        
        navigationController.viewControllers.forEach { (viewController) in
            if let profileViewController = viewController as? ProfileViewController {
                profileViewController.object = self.object
                profileViewController.reloadTableView()
                navigationController.popToViewController(profileViewController, animated: true)
            }
        }
    }
    
}



extension ProfileEditViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let details = self.object?.details {
            return details.count
        }
        
        return 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? LabelTextViewTableCell else { return UITableViewCell() }
        
        if let object = self.object, let detail = object.details?[indexPath.row] {
            cell.detail = detail
        }
        
        cell.tableView = tableView
        
        return cell
        
    }
    
}
