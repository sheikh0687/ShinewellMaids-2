//
//  PresentDeleteVC.swift
//  ShinewellMaids
//
//  Created by Techimmense Software Solutions on 13/06/23.
//

import UIKit

class PresentDeleteVC: UIViewController {

    var cloOk: (() -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func btnCancel(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
    @IBAction func btnOk(_ sender: UIButton) {
        self.cloOk?()
        self.dismiss(animated: true)
    }
}
