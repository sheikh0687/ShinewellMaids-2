//
//  WalletVC.swift
//  ShinewellMaids
//
//  Created by Techimmense Software Solutions on 13/06/23.
//

import UIKit

class WalletVC: UIViewController {

    @IBOutlet weak var lblReferalPoints: UILabel!
    @IBOutlet weak var lblBookingPoints: UILabel!
    @IBOutlet weak var lblTotalPoints: UILabel!
    @IBOutlet weak var lblWalletAmount: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
        setNavigationBarItem(LeftTitle: "", LeftImage: "black_back", CenterTitle: "Wallet", CenterImage: "", RightTitle: "", RightImage: "", BackgroundColor: "#D2F6F4", BackgroundImage: "", TextColor: "#000000", TintColor: "#000000", Menu: "")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func leftClick() {
        toggleLeft()
    }
    
    func getProfile()
    {
        Api.shared.getProfile(self) { responseData in
            let obj = responseData
            self.lblReferalPoints.text! = obj.referal_points ?? ""
            self.lblBookingPoints.text! = obj.booking_points ?? ""
            self.lblTotalPoints.text! = obj.earn_points ?? ""
            self.lblWalletAmount.text! = "Current Wallet Amount : AED \(obj.wallet ?? "")"
        }
    }
    
    @IBAction func btnConvert(_ sender: UIButton)
    {
        if Int(self.lblTotalPoints.text!) ?? 0 <= 10 {
            self.alert(alertmessage: "You need minimum 10 points to convert in wallet amount!")
        }else{
            self.convert()
        }
    }
    
    func convert()
    {
        Api.shared.convertPointWallet(self, self.paramPoint()) { responseData in
            Utility.showAlertWithAction(withTitle: k.appName, message: "Applied Successfully", delegate: nil, parentViewController: self) { boool in
                self.getProfile()
            }
        }
    }
    
    func paramPoint() -> [String : AnyObject]
    {
        var dict: [String : AnyObject] = [:]
        dict["user_id"]                = k.userDefault.value(forKey: k.session.userId) as AnyObject
        dict["points"]                 = self.lblTotalPoints.text! as AnyObject
        return dict
    }
}
