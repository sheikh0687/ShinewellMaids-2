//
//  HistoryCell.swift
//  ShinewellMaids
//
//  Created by Techimmense Software Solutions on 13/06/23.
//

import UIKit

class HistoryCell: UITableViewCell {

    @IBOutlet weak var viewToHide: UIView!
    @IBOutlet weak var lblHour_Amount: UILabel!
    @IBOutlet weak var lblDay_Date: UILabel!
    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var lblNumberOfService: UILabel!
    @IBOutlet weak var lblHour: UILabel!
    @IBOutlet weak var lblMaid: UILabel!
    @IBOutlet weak var lblCLeaning: UILabel!
    @IBOutlet weak var lblPaymentStatus: UILabel!
    @IBOutlet weak var lblAmount: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
      
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
