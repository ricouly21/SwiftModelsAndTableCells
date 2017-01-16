//
//  ViewController.swift
//  ModelsAndTableCells
//
//  Created by justine tabin on 16/01/2017.
//
//

import Foundation
import UIKit


class SampleData {
    var key: String?
    var value: AnyObject?
    
    init(key: String, value: AnyObject) {
        self.key = key
        self.value = value
    }
    
    init() {}
}

class ViewController: UIViewController {

    @IBOutlet weak var mainTableView: UITableView!
    
    var sampleData = [SampleData]()
    
    let data = [
        ["key": "Mortgage Holder", "value": "Ulyses Rico"],
        ["key": "Contact Number", "value": "908-818-1572"],
        ["key": "Monthly Payment Amount", "value": "$300"],
        ["key": "Due Date", "value": "24th"],
        ["key": "Monthly Payment Amount", "value": "$300"],
        ["key": "Contact Number", "value": "908-818-1572"],
        ["key": "Mortgage Holder", "value": "Ulyses Rico"],
        ["key": "Monthly Payment Amount", "value": "$300"],
        ["key": "Due Date", "value": "24th"],
        ["key": "Monthly Payment Amount", "value": "$300"],
        ["key": "Contact Number", "value": "908-818-1572"],
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.automaticallyAdjustsScrollViewInsets = false
        self.mainTableView.delegate = self
        self.mainTableView.dataSource = self
        self.mainTableView.keyboardDismissMode = .onDrag
        
        for datum in self.data {
            self.sampleData.append(SampleData(key: datum["key"]!, value: datum["value"] as AnyObject))
        }
        
    }

}



extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.sampleData.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? ViewControllerTableCell {
            
            cell.sampleData = self.sampleData[indexPath.row]
            cell.tableView = self.mainTableView
            
            return cell
            
        }
        
        return UITableViewCell()
        
    }
    
}




class ViewControllerTableCell: UITableViewCell, UITextViewDelegate {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var textView: UITextView!
    
    var sampleData = SampleData()
    
    var tableView: UITableView? {
        didSet {
            self.textView.delegate = self
            self.textView.isScrollEnabled = false
            
            self.titleLabel.text = self.sampleData.key
            self.textView.text = "\(self.sampleData.value!)"
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.selectionStyle = .none
        
    }
    
    
    func textViewDidChange(_ textView: UITextView) {
        self.sampleData.value = textView.text as AnyObject?
        self.tableView?.beginUpdates()
        self.tableView?.endUpdates()
    }
    
}
