//
//  PaymentVC.swift
//  ShinewellMaids
//
//  Created by Techimmense Software Solutions on 07/07/23.
//

import UIKit
import InputMask
import SwiftyJSON
import Stripe

class PaymentVC: UIViewController {

    @IBOutlet weak var lblAmount: UILabel!
    @IBOutlet weak var txtCardHolderName: UITextField!
    @IBOutlet weak var txtCardNumber: UITextField!
    @IBOutlet weak var txtExpiryDate: UITextField!
    @IBOutlet weak var txtSecurityCode: UITextField!
    @IBOutlet var listnerCardNum: MaskedTextFieldDelegate!
    @IBOutlet var listerExpiryDate: MaskedTextFieldDelegate!
    
    var amount = 0.0
    var planId = ""
    var request_id = ""
    
    var bill_id = ""
    var statusCheck = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.lblAmount.text = "AED \(self.amount)"
        self.configureListener()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
        setNavigationBarItem(LeftTitle: "", LeftImage: "black_back", CenterTitle: "Payment Details", CenterImage: "", RightTitle: "", RightImage: "", BackgroundColor: "#D2F6F4", BackgroundImage: "", TextColor: "#000000", TintColor: "#000000", Menu: "")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    func configureListener()
    {
        listnerCardNum.affinityCalculationStrategy = .prefix
        listnerCardNum.affineFormats = ["[0000] [0000] [0000] [0000]"]
        
        listerExpiryDate.affinityCalculationStrategy = .prefix
        listerExpiryDate.affineFormats = ["[00]/[00]"]
    }
    
    func cardValidation()
    {
        let cardParams = STPCardParams()
        
        // Split the expiration date to extract Month & Year
        if self.txtCardHolderName.text?.isEmpty == false && self.txtSecurityCode.text?.isEmpty == false && self.txtExpiryDate.text?.isEmpty == false && self.txtExpiryDate.text?.isEmpty == false {
            let expirationDate = self.txtExpiryDate.text?.components(separatedBy: "/")
            let expMonth = UInt((expirationDate?[0])!)
            let expYear = UInt((expirationDate?[1])!)
            
            // Send the card info to Strip to get the token
            cardParams.number = self.txtCardNumber.text
            cardParams.cvc = self.txtSecurityCode.text
            cardParams.expMonth = expMonth!
            cardParams.expYear = expYear!
            
            //            let cardBrand = STPCardValidator.brand(forNumber: self.txtCardNumber.text!)
            //            let cardImage = STPImageLibrary.brandImage(for: cardBrand)
            //            self.imgWallet.image = cardImage
        }
        
        let cardState = STPCardValidator.validationState(forCard: cardParams)
        switch cardState {
        case .valid:
            self.generateToken(cardParams)
        case .invalid:
            self.alert(alertmessage: "Card Is Invalid!")
        case .incomplete:
            self.alert(alertmessage: "Card Is Incomplete!")
        default:
            print("default")
        }
    }
    
    func generateToken(_ cardParams: STPCardParams)
    {
        STPAPIClient.shared.createToken(withCard: cardParams) { (token: STPToken?, error: Error?) in
            guard let token = token, error == nil else {
                Utility.showAlertWithAction(withTitle: k.appName, message: "Something Went Wrong!", delegate: nil, parentViewController: self, completionHandler: { (boool) in
                })
                return
            }
            print(token.tokenId)
            self.stripePayment(token.tokenId)
        }
    }
    
    func stripePayment(_ token: String)
    {
        if self.statusCheck == true {
            Api.shared.stripePayment(self, self.paramStripe(token)) { responseData in
                self.parseDataSaveCard(apiResponse: responseData)
                self.statusCheck = true
            }
        }else{
            self.statusCheck = true
        }
        self.statusCheck = true
    }
    
    func parseDataSaveCard(apiResponse : AnyObject) {
        DispatchQueue.main.async {
            let swiftyJsonVar = JSON(apiResponse)
            print(swiftyJsonVar)
            if(swiftyJsonVar["status"] == "1") {
                print(swiftyJsonVar["result"]["id"].stringValue)
                Utility.showAlertWithAction(withTitle: k.appName, message: "Payment Successfully Done!", delegate: nil, parentViewController: self, completionHandler: { (boool) in
                    Switcher.checkLogin()
                })
            } else {
                Utility.showAlertWithAction(withTitle: k.appName, message: "Something Went Wrong!", delegate: nil, parentViewController: self, completionHandler: { (boool) in
                })
            }
            self.unBlockUi()
        }
    }
    
    func paramStripe(_ tokenId: String) -> [String : AnyObject]
    {
        var dict: [String : AnyObject] = [:]
        
        dict["user_id"]                = k.userDefault.value(forKey: k.session.userId)! as AnyObject
        dict["offer_id"]               = k.emptyString as AnyObject
        dict["request_id"]             = self.request_id as AnyObject
        dict["currency"]               = "AED" as AnyObject
        dict["total_amount"]           = self.amount as AnyObject
        dict["payment_method"]         = "Card" as AnyObject
        dict["token"]                  = tokenId as AnyObject
        print(dict)
        return dict
    }
    
    @IBAction func btnPay(_ sender: UIButton) {
        self.cardValidation()
    }
}
