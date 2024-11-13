//
//  AddAdressVC.swift
//  ShinewellMaids
//
//  Created by Techimmense Software Solutions on 12/06/23.
//

import UIKit
import DropDown
import Rswift
import CoreLocation

class AddAdressVC: UIViewController {

    @IBOutlet weak var btnDrop: UIButton!
    @IBOutlet weak var txtBuildingNum: UITextView!
    @IBOutlet weak var txtAppartmentNum: UITextView!
    @IBOutlet weak var txtStreetNum: UITextView!
    @IBOutlet weak var txtLandmarkNum: UITextView!
    
    @IBOutlet weak var txtAddress: UITextView!
    
    
    let dropDown = DropDown()
    var selectedAreaId = ""
    var selectedAreaName = ""
    var arrAreaList: [ResAreaList] = []
    var userAddress = ""
    var userLat = 0.0
    var userLon = 0.0
    var cloLatLon: ((Double,Double) -> Void)?
    var location_cordinate:CLLocationCoordinate2D?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
        setNavigationBarItem(LeftTitle: "", LeftImage: "black_back", CenterTitle: "Add Address", CenterImage: "", RightTitle: "", RightImage: "", BackgroundColor: "#D2F6F4", BackgroundImage: "", TextColor: "#000000", TintColor: "#000000", Menu: "")
        
        self.txtBuildingNum.addHint("Enter")
        self.txtStreetNum.addHint("Enter")
        self.txtAppartmentNum.addHint("Enter")
        self.txtLandmarkNum.addHint("Enter")
        self.areaList()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    @IBAction func btnLocation(_ sender: UIButton)
    {
        let vc = R.storyboard.main().instantiateViewController(withIdentifier: "AddressPickerVC") as! AddressPickerVC
        vc.locationPickedBlock = { (addressCoordinate, latVal, lonVal, addressVal) in
            self.txtAddress.text = addressVal
            self.userAddress = addressVal
            self.userLat = latVal
            self.userLon = lonVal
            self.location_cordinate = addressCoordinate
        }
        self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func BtndropDown(_ sender: UIButton)
    {
        self.dropDown.show()
    }
    
    func areaList()
    {
        Api.shared.getAreaList(self) { responseData in
            if responseData.count > 0
            {
                self.arrAreaList = responseData
            }else
            {
                self.arrAreaList = []
            }
            self.configureAreaDropdown()
        }
    }
    
    func configureAreaDropdown() {
        var arrAreaId:[String] = []
        var arrAreaName:[String] = []
        for val in self.arrAreaList {
            arrAreaId.append(val.id ?? "")
            arrAreaName.append(val.name ?? "")
        }
        dropDown.anchorView = self.btnDrop
        dropDown.dataSource = arrAreaName
        dropDown.bottomOffset = CGPoint(x: -5, y: 45)
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            print("Selected item: \(item) at index: \(index)")
            self.selectedAreaId = arrAreaId[index]
            self.selectedAreaName = item
            self.btnDrop.setTitle(item, for: .normal)
        }
    }
    
    @IBAction func btnSave(_ sender: UIButton)
    {
        self.RagistationValidation()
    }
    
    func RagistationValidation()->Bool
        {
            if self.selectedAreaId.isEmpty
               {
                self.alert(alertmessage: "Please Select the area!")
                return false
                }
               else if txtBuildingNum.text!.isEmpty
               {
                self.alert(alertmessage: "Please Enter Building Name!")
                return false
               }
               else if txtAppartmentNum.text!.isEmpty
               {
                   self.alert(alertmessage: "Please Enter Appartment Name!")
                return false
               }
               else if txtStreetNum.text!.isEmpty
               {
                   self.alert(alertmessage: "Please Enter Street Name!")
                return false
               }
               else if txtLandmarkNum.text!.isEmpty
               {
                self.alert(alertmessage: "Please Enter Landmark Name!")
                return false
               }
            else
            {
                self.savedAddres()
                return true
            }
        }
    
    func savedAddres()
    {
        Api.shared.addAddress(self, self.addAddressParam()) { responseData in
            Utility.showAlertWithAction(withTitle: k.appName, message: "Address Saved Successfully!", delegate: nil, parentViewController: self) { boool in
                self.navigationController?.popViewController(animated: true)
                self.cloLatLon?(self.userLat, self.userLon)
            }
        }
    }
    
    
    func addAddressParam() -> [String : AnyObject]
    {
        var dict: [String : AnyObject] = [:]
        dict["user_id"]                = k.userDefault.value(forKey: k.session.userId) as AnyObject
        dict["address"]                = self.userAddress as AnyObject
        dict["area_id"]                = self.selectedAreaId as AnyObject
        dict["area_name"]              = self.selectedAreaName as AnyObject
        dict["villa"]                  = self.txtBuildingNum.text! as AnyObject
        dict["appartment"]             = self.txtAppartmentNum.text! as AnyObject
        dict["street"]                 = self.txtStreetNum.text! as AnyObject
        dict["landmark"]               = self.txtLandmarkNum.text! as AnyObject
        dict["lat"]                    = self.userLat as AnyObject
        dict["lon"]                    = self.userLon as AnyObject
        dict["timezone"]               = localTimeZoneIdentifier as AnyObject
        print(dict)
        return dict
    }
}
