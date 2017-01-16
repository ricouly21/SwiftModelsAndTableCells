//
//  ProfileViewController.swift
//  ModelsAndTableCells
//
//  Created by justine tabin on 17/01/2017.
//
//

import Foundation
import UIKit


class ProfileViewController: BaseViewController {
    
    let mainTableView: UITableView? = UITableView()
    
    let refreshControl = UIRefreshControl()
    
    var object: Object? = Object()
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if let object = self.object {
            for detail in object.details! {
                print(detail.value!)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "PROFILE"
        
        let editButton = UIBarButtonItem(title: "Edit",
                                         style: .plain,
                                         target: self,
                                         action: #selector(self.editButtonAction(sender:)))
        self.navigationItem.setRightBarButton(editButton, animated: false)
        
        self.initBaseTableView(tableView: self.mainTableView)
        self.mainTableView?.delegate = self
        self.mainTableView?.dataSource = self
        
        self.refreshControl.addTarget(self, action: #selector(self.reloadTableView), for: .valueChanged)
        self.mainTableView?.addSubview(self.refreshControl)
        
        let cell = UINib(nibName: "LabelTextViewTableCell", bundle: nil)
        self.mainTableView?.register(cell, forCellReuseIdentifier: "cell")
        
        self.loadProfile()
        
    }
    
    func loadProfile() {
        let data: [[String : Any]] = [
            ["key": "id", "value": 1],
            ["key": "username", "value": "uly@directworkmedia.com"],
            ["key": "email", "value": "uly@directworkmedia.com"],
            ["key": "name", "value": "Ulyses Rico"],
            ["key": "gender", "value": "Male"],
            ["key": "dob", "value": "12-21-1991"],
            ["key": "address", "value": "154 P. Arambulo Street, Brgy. Kanluran, Sta. Rosa City, Laguna"],
            ["key": "zip", "value": "4026"],
            ["key": "job_title", "value": "iOS App Developer"],
            ["key": "company", "value": "Think Direct Works Media, Inc."],
            ["key": "employment_date", "value": "09-10-2015"],
//            ["key": "avatar", "value": "https://z-1-scontent.fmnl3-2.fna.fbcdn.net/v/t1.0-9/13226661_721866897953220_7217126888620287224_n.jpg?_nc_eui2=v1%3AAeGoNgcLoyNhbaXjCWY_reNfXhTQz9HSWaMvDTxqoMA4gB94qOWL3NWUs36-KRQyI_gxv8rJFR7clHiQzE7ahX58nGTfSqOZn5bVxIsvMHWvzOO_ODWjJxqnwMN0cQEabnI&oh=ff0ddd250273547df64f428f3cfe718a&oe=59170083"],
        ]
        
        for datum in data {
            if let user = self.object {
                if datum["key"] as? String == "id" {
                    user.id = datum["value"] as? Int
                } else {
                    user.details?.append(ObjectDetail(key: datum["key"] as! String,
                                                              value: datum["value"]! as Any))
                }
            }
        }
        
        self.mainTableView?.reloadData()
    }
    
    func editButtonAction(sender: AnyObject) {
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "ProfileEditViewController") as? ProfileEditViewController else { return }
        vc.object = self.object?.copy()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func reloadTableView() {
        self.refreshControl.beginRefreshing()
        self.mainTableView?.reloadData()
        self.refreshControl.endRefreshing()
    }
    
}



extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
    
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
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? LabelTextViewTableCell {
            
            if let object = self.object {
                cell.detail = object.details?[indexPath.row]
            }
            
            cell.tableView = tableView
            cell.textView.isEditable = false
            
            return cell
        }
        
        return UITableViewCell()
    }
    
}










