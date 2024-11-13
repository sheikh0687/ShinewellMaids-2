//
//  SavedAddressVC.swift
//  ShinewellMaids
//
//  Created by Techimmense Software Solutions on 12/06/23.
//

import UIKit

class SavedAddressVC: UIViewController {

    @IBOutlet weak var adressTableView: UITableView!
    @IBOutlet weak var lblHidden: UILabel!
    
    let identifier = "AdressCell"
    var arrAddress: [ResAddress] = []
    var addressId = ""
    var howManyHour = ""
    var howManyMaid = ""
    var anyCleaningMaterial = ""
    var cleaningMaterialName = ""
    var cleaningMaterialId = ""
    var cleaningMaterialPrice = ""
    var anyAdditionalService = ""
    var additionalServiceName = ""
    var additionalServicePrice = ""
    var additionalServiceTime = ""
    var additionalServiceId = ""
    var howCleanerEnter = ""
    var cleaningInstruction = ""
    var totalAmount = ""
    var serviceAmount = ""
    var vatAmount = ""
    var VAT = ""
    var descriptionVal = ""
    var lat = 0.0
    var lon = 0.0
    var checkStr = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.adressTableView.register(UINib(nibName: identifier, bundle: nil), forCellReuseIdentifier: identifier)
        k.topMargin = UIApplication.shared.statusBarFrame.size.height + (self.navigationController?.navigationBar.frame.height ?? 0) + 100
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
        setNavigationBarItem(LeftTitle: "", LeftImage: "black_back", CenterTitle: "Saved Address", CenterImage: "", RightTitle: "", RightImage: "Plus24", BackgroundColor: "#D2F6F4", BackgroundImage: "", TextColor: "#000000", TintColor: "#000000", Menu: "")
        self.savedAddress()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }

    override func leftClick() {
        if self.checkStr == "Next"{
            self.navigationController?.popViewController(animated: true)
        }else{
            toggleLeft()
        }
    }
    
    override func rightClick() {
        if Utility.isUserLogin() {
            let vc = R.storyboard.main().instantiateViewController(withIdentifier: "AddAdressVC") as! AddAdressVC
            self.navigationController?.pushViewController(vc, animated: true)
        } else {
            self.alert(alertmessage: "Please register to use this app!")
        }
    }
    
    @IBAction func btnBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func getProfile() {
        Api.shared.getProfile(self) { (response) in
           print("succeess")
        }
    }
    
    @IBAction func btnAddress(_ sender: UIButton) {
        let vc = Kstoryboard.instantiateViewController(withIdentifier: "AddAdressVC") as! AddAdressVC
        vc.cloLatLon = { userLat, userLon in
            self.lat = userLat
            self.lon = userLon
        }
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func savedAddress()
    {
        Api.shared.getAddress(self) { responseData in
            if responseData.count > 0
            {
                self.arrAddress = responseData
                self.lblHidden.isHidden = true
            }else
            {
                self.arrAddress = []
                self.lblHidden.isHidden = false
            }
            self.adressTableView.reloadData()
        }
    }
    
    func deletedAddress()
    {
        Api.shared.deleteAddress(self, self.paramDeleteAddress()) { responseData in
            Utility.showAlertWithAction(withTitle: k.appName, message: "Address Deleted Successfully", delegate: nil, parentViewController: self) { boool in
                self.savedAddress()
                self.getProfile()
            }
        }
    }
    
    func paramDeleteAddress() -> [String : AnyObject]
    {
        var dict: [String : AnyObject] = [:]
        dict["address_id"]             = self.addressId as AnyObject
        print(dict)
        return dict
    }
    
    @IBAction func btnNExt(_ sender: UIButton) {
        let vc = R.storyboard.main().instantiateViewController(withIdentifier: "DateTimeVC") as! DateTimeVC
        vc.hour = self.howManyHour
        vc.Maid = self.howManyMaid
        vc.cleaningMaterial = self.anyCleaningMaterial
        vc.materialName = self.cleaningMaterialName
        vc.materialId = self.cleaningMaterialId
        vc.materialPrice = self.cleaningMaterialPrice
        vc.additionalService  = self.anyAdditionalService
        vc.serviceName = self.additionalServiceName
        vc.servicePrice = self.additionalServicePrice
        vc.serviceTime = self.additionalServiceTime
        vc.serviceId = self.additionalServiceId
        vc.cleanerEnter = self.howCleanerEnter
        vc.instruction = self.cleaningInstruction
        vc.amount = self.totalAmount
        vc.serviceAmount = self.serviceAmount
        vc.vatAmount = self.vatAmount
        vc.VAT = self.VAT
        vc.descriptionVal = self.descriptionVal
        vc.userLat = self.lat
        vc.userLon = self.lon
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension SavedAddressVC: UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrAddress.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AdressCell", for: indexPath) as! AdressCell
        
        let obj = arrAddress[indexPath.row]
        
        cell.lblName.text = obj.area_name ?? ""
        cell.lblAddress.text = obj.address ?? ""
        
        cell.cloSelect =  {
            let vc = Kstoryboard.instantiateViewController(withIdentifier: "DateTimeVC") as! DateTimeVC
            vc.addressId = obj.id ?? ""
            if cell.lblAddress.text == "" {
                vc.address = obj.area_name ?? ""
                print(vc.address)
            }else{
                vc.address = obj.address ?? ""
                print(vc.address)
            }
            vc.hour = self.howManyHour
            vc.Maid = self.howManyMaid
            vc.cleaningMaterial = self.anyCleaningMaterial
            vc.materialName = self.cleaningMaterialName
            vc.materialId = self.cleaningMaterialId
            vc.materialPrice = self.cleaningMaterialPrice
            vc.additionalService  = self.anyAdditionalService
            vc.serviceName = self.additionalServiceName
            vc.servicePrice = self.additionalServicePrice
            vc.serviceTime = self.additionalServiceTime
            vc.serviceId = self.additionalServiceId
            vc.cleanerEnter = self.howCleanerEnter
            vc.instruction = self.cleaningInstruction
            vc.amount = self.totalAmount
            vc.serviceAmount = self.serviceAmount
            vc.vatAmount = self.vatAmount
            vc.VAT = self.VAT
            vc.descriptionVal = self.descriptionVal
            vc.userLat = self.lat
            vc.userLon = self.lon
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
        cell.cloDelete = {
            let vc = Kstoryboard.instantiateViewController(withIdentifier: "PresentDeleteVC") as! PresentDeleteVC
            vc.modalTransitionStyle = .crossDissolve
            vc.modalPresentationStyle = .overFullScreen
            
            vc.cloOk = {
                self.addressId = obj.id ?? ""
                print(self.addressId)
                self.deletedAddress()
            }
            self.present(vc, animated: true, completion: nil)
        }
        return cell
    }
    
    
}

//extension SavedAddressVC: UITableViewDelegate
//{
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 100
//    }
//}
