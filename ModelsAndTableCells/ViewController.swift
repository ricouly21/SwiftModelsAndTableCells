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


class ViewController: BaseViewController {

    @IBOutlet weak var mainTableView: UITableView!
    
    var sampleData = [SampleData]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "HOME"
        
        let saveButton = UIBarButtonItem(barButtonSystemItem: .done, target: self,
                                         action: #selector(self.saveButtonAction(sender:)))
        self.navigationItem.setRightBarButton(saveButton, animated: false)
        
        self.configureTableView()
        self.loadData()
        
    }
    
    func saveButtonAction(sender: AnyObject) {
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "ViewController2") as? ViewController2 else { return }
        
        let backButton = UIBarButtonItem()
        backButton.title = ""
        self.navigationItem.backBarButtonItem = backButton
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func configureTableView() {
        self.mainTableView.delegate = self
        self.mainTableView.dataSource = self
        self.mainTableView.preservesSuperviewLayoutMargins = false
        self.mainTableView.layoutMargins = UIEdgeInsets.zero
        self.mainTableView.separatorInset = UIEdgeInsets.zero
        self.mainTableView.keyboardDismissMode = .onDrag
    }
    
    func loadData() {
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
        
        for datum in data {
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
            
            cell.sampleData = self.sampleData[indexPath.row]    // Data should be loaded first
            cell.tableView = self.mainTableView                 // before 'table view' is referenced
            
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
    
    func textViewDidChange(_ textView: UITextView) {
        self.sampleData.value = textView.text as AnyObject?
        self.tableView?.beginUpdates()
        self.tableView?.endUpdates()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.selectionStyle = .none
        
    }
    
}
