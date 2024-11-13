//
//  OfferCell.swift
//  ShinewellMaids
//
//  Created by Techimmense Software Solutions on 10/06/23.
//

import UIKit

class OfferCell: UICollectionViewCell {

    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var lblCode: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    
    var cloApply: (() -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    @IBAction func btnApply(_ sender: UIButton) {
        self.cloApply?()
    }
}
