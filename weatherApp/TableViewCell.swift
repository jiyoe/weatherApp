//
//  TableViewCell.swift
//  weatherApp
//
//  Created by jy on 4/2/25.
//

import UIKit

protocol CVCellDelegate {
    func selectedCVCell(_ index: Int)
}

var delegate: CVCellDelegate?

class TableViewCell: UITableViewCell {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var regionCellLabel: UILabel!
    @IBOutlet weak var TemCellLabel: UILabel!
    @IBOutlet weak var humidityCellLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        containerView.frame = containerView.frame.inset(by: UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8))
    }
}
