//
//  ReferFriendVC.swift
//  ShinewellMaids
//
//  Created by Techimmense Software Solutions on 24/06/23.
//

import UIKit

class ReferFriendVC: UIViewController {
    
    @IBOutlet weak var lblCode: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
        setNavigationBarItem(LeftTitle: "", LeftImage: "black_back", CenterTitle: "Refers Freinds", CenterImage: "", RightTitle: "", RightImage: "", BackgroundColor: "#D2F6F4", BackgroundImage: "", TextColor: "#000000", TintColor: "#000000", Menu: "")
        self.Profile()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func leftClick()
    {
        toggleLeft()
    }
    
    func Profile()
    {
        Api.shared.getProfile(self){ responseData in
            let obj = responseData
            self.lblCode.text = obj.referral_code ?? ""
        }
    }
    
    @IBAction func btnInvite(_ sender: UIButton) {
        Utility.doShare("www.google.com", "www.google.com", self)
    }
}
