//
//  PendingCell.swift
//  ShinewellMaids
//
//  Created by Techimmense Software Solutions on 13/06/23.
//

import UIKit

class PendingCell: UITableViewCell {

    @IBOutlet weak var lblBName: UILabel!
    @IBOutlet weak var lblPaymentStatus: UILabel!
    @IBOutlet weak var lblAmount: UILabel!
    
    var cloPay: (() -> Void)?
    override func awakeFromNib() {
        super.awakeFromNib()
      
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func btnPay(_ sender: UIButton) {
        self.cloPay?()
    }
}
