//
//  LabelTextViewTableCell.swift
//  ModelsAndTableCells
//
//  Created by justine tabin on 17/01/2017.
//
//

import Foundation
import UIKit


class Object {
    var id: Int?
    var details: [ObjectDetail]? = [ObjectDetail]()
    
    init() { }
    
    init(id: Int, details: [ObjectDetail]) {
        self.id = id
        self.details = details
    }
    
    func copy() -> Object {
        var detailsCopy = [ObjectDetail]()
        
        if let details = self.details {
            for detail in details {
                detailsCopy.append(ObjectDetail(key: detail.key!, value: detail.value!))
            }
            
            return Object(id: self.id!, details: detailsCopy)
        }
        
        return Object()
    }
}

class ObjectDetail {
    var key: String?
    var value: Any?
    
    init() { }
    
    init(key: String, value: Any) {
        self.key = key
        self.value = value
    }
    
    func copy() -> ObjectDetail {
        return ObjectDetail(key: self.key!, value: self.value!)
    }
}

class LabelTextViewTableCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var textView: UITextView!
    
    var detail: ObjectDetail? = ObjectDetail()
    
    var tableView: UITableView? {
        didSet {
            self.textView.delegate = self
            self.textView.isScrollEnabled = false
            
            if let detail = self.detail {
                self.titleLabel.text = detail.key
                self.textView.text = "\(detail.value!)"
            }
            
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.selectionStyle = .none
        self.titleLabel.font = UIFont.boldSystemFont(ofSize: 17)
        
    }
    
}


extension LabelTextViewTableCell: UITextViewDelegate {
    
    func textViewDidChange(_ textView: UITextView) {
        self.detail?.value = textView.text as AnyObject?
        self.tableView?.beginUpdates()
        self.tableView?.endUpdates()
    }
    
}
