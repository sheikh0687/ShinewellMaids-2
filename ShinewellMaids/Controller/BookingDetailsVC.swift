//
//  BookingDetailsVC.swift
//  ShinewellMaids
//
//  Created by Techimmense Software Solutions on 13/06/23.
//

import UIKit

class BookingDetailsVC: UIViewController {

    @IBOutlet weak var lblStatus: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var lblType: UILabel!
    @IBOutlet weak var lblHours: UILabel!
    @IBOutlet weak var lblMaid: UILabel!
    @IBOutlet weak var lblCLeaningMaterial1: UILabel!
    @IBOutlet weak var lblContact: UILabel!
    @IBOutlet weak var lblAddress: UILabel!
    @IBOutlet weak var lblServiceCharge: UILabel!
    @IBOutlet weak var lblCleaningMaterial2: UILabel!
    @IBOutlet weak var lblVat: UILabel!
    @IBOutlet weak var lblDiscount: UILabel!
    @IBOutlet weak var lblTotal: UILabel!
    @IBOutlet weak var viewToHide: UIView!
    
    var requestId = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
        setNavigationBarItem(LeftTitle: "", LeftImage: "black_back", CenterTitle: "Booking Details", CenterImage: "", RightTitle: "", RightImage: "", BackgroundColor: "#D2F6F4", BackgroundImage: "", TextColor: "#000000", TintColor: "#000000", Menu: "")
        self.details()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    func details()
    {
        Api.shared.bookingDetails(self, self.paramDetails()) { responseData in
            let obj = responseData
            self.lblMaid.text! = "No. of Maids : \(obj.how_many_cleaners ?? "")"
            self.lblHours.text! = "No. of Hours : \(obj.how_many_hours ?? "") Hours"
            self.lblDate.text! = obj.format_date ?? ""
            self.lblTime.text! = obj.time ?? ""
            self.lblAddress.text! = obj.address ?? ""
            self.lblType.text! = obj.how_offen_want_service ?? ""
            self.lblCLeaningMaterial1.text! = "Cleaning Material : \(obj.need_any_cleaning_material ?? "")"
            self.lblServiceCharge.text! = "\(obj.service_amount ?? "") AED"
            self.lblCleaningMaterial2.text! = "\(obj.cleaning_material_amount ?? "") AED"
            self.lblVat.text! = "AED \(obj.vAT_amount ?? "")"
            self.lblDiscount.text! = "\(obj.discount ?? "") AED"
            self.lblTotal.text! = "\(obj.total_amount ?? "") AED"
            if obj.how_offen_want_service ?? "" == "Once"{
                self.viewToHide.isHidden = false
            }else if self.lblType.text == "Weekly"{
                self.viewToHide.isHidden = true
            }
        }
    }
    
    func paramDetails() -> [String : AnyObject]
    {
        var dict: [String : AnyObject] = [:]
        dict["user_id"]                = k.userDefault.value(forKey: k.session.userId) as AnyObject
        dict["request_id"]             = self.requestId as AnyObject
        return dict
    }
    
    
    func cancelRequest()
    {
        Api.shared.changeRequest(self, self.paramRequestDetail()) { responseData in
            Utility.showAlertWithAction(withTitle: k.appName, message: "Booking Cancelled!", delegate: nil, parentViewController: self) { bool in
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
    
    func paramRequestDetail() -> [String : AnyObject]
    {
        var dict: [String : AnyObject] = [:]
        dict["user_id"]                = k.userDefault.value(forKey: k.session.userId) as AnyObject
        dict["request_id"]             = self.requestId as AnyObject
        dict["status"]                 = "Finish" as AnyObject
        print(dict)
        return dict
    }
    
    @IBAction func btnCancel(_ sender: UIButton) {
        let vc = Kstoryboard.instantiateViewController(withIdentifier: "PresentCancelVC") as! PresentCancelVC
        vc.modalTransitionStyle = .crossDissolve
        vc.modalPresentationStyle = .overFullScreen
        vc.cloYes = {
            self.cancelRequest()
        }
        self.present(vc, animated: true, completion: nil)
    }
}
