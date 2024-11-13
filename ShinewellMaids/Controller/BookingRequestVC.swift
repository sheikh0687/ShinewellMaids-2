//
//  BookingRequestVC.swift
//  ShinewellMaids
//
//  Created by Techimmense Software Solutions on 12/06/23.
//

import UIKit

class BookingRequestVC: UIViewController {

    @IBOutlet weak var btnWalletOt: UIButton!
    @IBOutlet weak var btnCouponOt: UIButton!
    @IBOutlet weak var walletView: UIView!
    @IBOutlet weak var CouponView: UIView!
    @IBOutlet weak var lblOrderNumber: UILabel!
    @IBOutlet weak var lblBookingAmount: UILabel!
    @IBOutlet weak var lblDiscountAmount: UILabel!
    @IBOutlet weak var lblWalletAmount: UILabel!
    @IBOutlet weak var lblMaid: UILabel!
    @IBOutlet weak var lblHours: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var lblAddress: UILabel!
    @IBOutlet weak var lblTotalAmount: UILabel!
    
    var requestId = ""
    var date = ""
    var selectdeTimes = ""
    var selectedType  = ""
    var selectedAddressID = ""
    var selectedAddress = ""
    var selectedHours = ""
    var selectedMaids = ""
    var selectedCleanMaterial = ""
    var selectedMaterialName = ""
    var selectedMaterialId = ""
    var selectedMaterialPrice = ""
    var selectedAdditionalService = ""
    var selectedServiceName = ""
    var selectedServicePrice = ""
    var selectedServiceTime = ""
    var selectedServiceId = ""
    var selectedCleanerEnter = ""
    var selectedInstruction = ""
    var selectedTotalAmount = ""
    var selectedServiceAmount = ""
    var selectedVatAmount = ""
    var selectedVat = ""
    var selectedDescription = ""
    var selectedAmount = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
        setNavigationBarItem(LeftTitle: "", LeftImage: "black_back", CenterTitle: "Booking Request", CenterImage: "", RightTitle: "", RightImage: "", BackgroundColor: "#D2F6F4", BackgroundImage: "", TextColor: "#000000", TintColor: "#000000", Menu: "")
        self.walletView.isHidden = false
        self.CouponView.isHidden = true
        self.walletToChange()
        self.couponToChange1()
        self.details()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.identifier == "IdentifierCopouns" {
            let vc = segue.destination as! CouponContainerVC
            //               vc.updateTextLabel.text = textField.text
            vc.totalAmount = self.selectedAmount
            print(vc.totalAmount)
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    func details()
    {
        Api.shared.bookingDetails(self, self.paramDetails()) { responseData in
            let obj = responseData
            self.lblOrderNumber.text! = obj.id ?? ""
            self.lblBookingAmount.text! = "\(obj.total_amount ?? "") AED"
            self.lblDiscountAmount.text! = "\(obj.discount ?? "") AED"
            self.lblWalletAmount.text! = "AED \(obj.wallet_used_amount ?? "")"
            self.lblMaid.text! = obj.how_many_cleaners ?? ""
            self.lblHours.text! = "\(obj.how_many_hours ?? "") Hours"
            self.lblDate.text! = obj.format_date ?? ""
            self.lblTime.text! = obj.time ?? ""
            self.lblAddress.text! = obj.address ?? ""
            self.lblTotalAmount.text! = "\(obj.total_amount ?? "") AED"
            self.selectedAmount = obj.total_amount ?? ""
        }
    }
    
    func paramDetails() -> [String : AnyObject]
    {
        var dict: [String : AnyObject] = [:]
        dict["user_id"]                = k.userDefault.value(forKey: k.session.userId) as AnyObject
        dict["request_id"]             = self.requestId as AnyObject
        return dict
    }
    
    
    @IBAction func btnWallet(_ sender: UIButton) {
        self.walletView.isHidden = false
        self.CouponView.isHidden = true
        self.walletToChange()
        self.couponToChange1()
    }
    
    @IBAction func btnCoupon(_ sender: UIButton) {
        self.walletView.isHidden = true
        self.CouponView.isHidden = false
        self.couponToChange()
        self.walletToChange1()
    }
    
    func walletToChange()
    {
        self.btnWalletOt.backgroundColor = hexStringToUIColorApp(hex: "#F5F5F5")
        self.btnWalletOt.setTitleColor(hexStringToUIColorApp(hex: "#004D61"), for: .normal)
    }
    
    func couponToChange()
    {
        self.btnCouponOt.backgroundColor = hexStringToUIColorApp(hex: "#F5F5F5")
        self.btnCouponOt.setTitleColor(hexStringToUIColorApp(hex: "#004D61"), for: .normal)
    }
    
    func walletToChange1()
    {
        self.btnWalletOt.backgroundColor = UIColor.white
        self.btnWalletOt.setTitleColor(UIColor.darkGray, for: .normal)
    }
    
    func couponToChange1()
    {
        self.btnCouponOt.backgroundColor = UIColor.white
        self.btnCouponOt.setTitleColor(UIColor.darkGray, for: .normal)
    }
    
    func hexStringToUIColorApp (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
    @IBAction func btnlater(_ sender: UIButton) {
        Switcher.checkLogin()
    }
    
    @IBAction func btnPayNow(_ sender: UIButton) {
        let vc = Kstoryboard.instantiateViewController(withIdentifier: "PaymentVC") as! PaymentVC
        vc.amount = Double(self.selectedAmount) ?? 0.0
        vc.request_id = self.requestId
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
