//
//  PresentCancelVC.swift
//  ShinewellMaids
//
//  Created by Techimmense Software Solutions on 06/07/23.
//

import UIKit

class PresentCancelVC: UIViewController {

    var cloYes: (() -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func btnYEs(_ sender: UIButton) {
        self.cloYes?()
        self.dismiss(animated: true)
    }
    
    @IBAction func btnBack(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
    @IBAction func btnCancel(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
}
