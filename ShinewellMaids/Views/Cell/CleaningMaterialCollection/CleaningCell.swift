//
//  CleaningCell.swift
//  ShinewellMaids
//
//  Created by Techimmense Software Solutions on 12/06/23.
//

import UIKit

class CleaningCell: UICollectionViewCell {

  
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var checkImg: UIImageView!
    @IBOutlet weak var lblHeading: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.checkImg.image = UIImage(named: "Uncheck1")
    }
}
