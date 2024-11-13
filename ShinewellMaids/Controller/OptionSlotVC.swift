//
//  OptionSlotVC.swift
//  ShinewellMaids
//
//  Created by Techimmense Software Solutions on 10/06/23.
//

import UIKit
import DropDown

class OptionSlotVC: UIViewController {

    @IBOutlet weak var cleaningCollectionView: UICollectionView!
    @IBOutlet weak var serviceCollectionView: UICollectionView!
    @IBOutlet weak var switchOnOff: UISwitch!
    @IBOutlet weak var vieToHide: UIView!
    @IBOutlet weak var switchOnOff2: UISwitch!
    @IBOutlet weak var viewToHide2: UIView!
    @IBOutlet weak var viewBooking: UIView!
    @IBOutlet weak var viewDetail: UIView!
    @IBOutlet weak var btnDrop1: UIButton!
    @IBOutlet weak var btnDrop2: UIButton!
    @IBOutlet weak var btnDrop3: UIButton!
    @IBOutlet weak var btnDrop4: UIButton!
    @IBOutlet weak var lblCleaner: UILabel!
    @IBOutlet weak var txtDescription: UITextView!
    @IBOutlet weak var lblMonths: UILabel!
    @IBOutlet weak var lblMaids: UILabel!
    @IBOutlet weak var lblHours: UILabel!
    @IBOutlet weak var lblAddtionalCleaning: UILabel!
    @IBOutlet weak var lblServiceAmount: UILabel!
    @IBOutlet weak var lblDiscountAmount: UILabel!
    @IBOutlet weak var lblTotal: UILabel!
    @IBOutlet weak var lbltotalHour: UILabel!
    @IBOutlet weak var lblTotalMaid: UILabel!
    @IBOutlet weak var btnChange: UIButton!
    
    let identifier1 = "CleaningCell"
    let identifier2 = "ServiceCell"
    let mySwitch = UISwitch()
    let newWidth: CGFloat = 40
    let newHeight: CGFloat = 24
    
    var selectedType = "Once"
    var selectedHours = "1"
    var selectedMaid = "1"
    var selectedCleaner = "I am at home"
    var arrExtra: [ResExtraService] = []
    var arrCleaning: [ResExtraCleaning] = []
    var dropDown1 = DropDown()
    var dropDown2 = DropDown()
    var dropDown3 = DropDown()
    var dropDown4 = DropDown()
    var swicth1 = "No"
    var swicth2 = "No"
    var selectedItem1 = [Int : Bool]()
    var selectedItem2 = [Int : Bool]()
    var strCleanId = ""
    var strCleanName = ""
    var strServiceId = ""
    var strServiceName = ""
    var cleaningPrice = ""
    var servicePrice = ""
    var serviceTime = ""
    var vatDiscount = "5.00"
    var isButtonImageSet = false
    var serviceAmount = ""
    var serviceDiscount = ""
    var serviceTotalAmount = ""
    
    var arrCount =
    [
      "1",
      "2",
      "3",
      "4",
      "5",
      "6",
      "7",
      "8",
      "9"
    ]
    
    var arrMonths =
    [
      "Once",
      "Weekly"
    ]
    
    var arrCleaner =
    [
      "I am at home",
      "I will keep the key under the mat",
      "I will leave the key to security"
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.cleaningCollectionView.register(UINib(nibName: identifier1, bundle: nil), forCellWithReuseIdentifier: identifier1)
        self.serviceCollectionView.register(UINib(nibName: identifier2, bundle: nil), forCellWithReuseIdentifier: identifier2)
        switchOnOff.frame = CGRect(x: mySwitch.frame.origin.x, y: mySwitch.frame.origin.y, width: newWidth, height: newHeight)
        switchOnOff2.frame = CGRect(x: mySwitch.frame.origin.x, y: mySwitch.frame.origin.y, width: newWidth, height: newHeight)
        switchOnOff.translatesAutoresizingMaskIntoConstraints = false
        switchOnOff.widthAnchor.constraint(equalToConstant: newWidth).isActive = true
        switchOnOff.heightAnchor.constraint(equalToConstant: newHeight).isActive = true
        switchOnOff2.translatesAutoresizingMaskIntoConstraints = false
        switchOnOff2.widthAnchor.constraint(equalToConstant: newWidth).isActive = true
        switchOnOff2.heightAnchor.constraint(equalToConstant: newHeight).isActive = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
        setNavigationBarItem(LeftTitle: "", LeftImage: "black_back", CenterTitle: "Select Option", CenterImage: "", RightTitle: "", RightImage: "", BackgroundColor: "#D2F6F4", BackgroundImage: "", TextColor: "#000000", TintColor: "#000000", Menu: "")
//        switchOnOff.state = off
        self.cleaningCollectionView.allowsMultipleSelection = true
        self.serviceCollectionView.allowsMultipleSelection = true
        self.txtDescription.addHint("Enter")
        self.vieToHide.isHidden = true
        self.viewToHide2.isHidden = true
        self.viewBooking.isHidden = true
        self.viewDetail.isHidden = true
        self.configureDropDown1()
        self.configureDropDown2()
        self.configureDropDown3()
        self.configureDropDown4()
        self.lblServiceAmount.text = "25.00"
        self.lblDiscountAmount.text = "1.25"
        self.lblTotal.text = "26.25"
        self.btnChange.setImage(UIImage(named: "uparrow"), for: .normal)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    
    private func blankSelected1()
    {
        for i in 0...arrCleaning.count
        {
            selectedItem1[i] = false
        }
    }
    
    private func blankSelected2()
    {
        for i in 0...arrExtra.count
        {
            selectedItem2[i] = false
        }
    }
    
    @IBAction func btnDropDown1(_ sender: UIButton) {
        self.dropDown1.show()
    }
    
    
    func configureDropDown1()
    {
        dropDown1.anchorView = self.btnDrop1
        dropDown1.dataSource = self.arrMonths
        dropDown1.bottomOffset = CGPoint(x: -5, y: 45)
        dropDown1.selectionAction = { [weak self] index, item in
            print("Selected item: \(item) at index: \(index)")
            self?.selectedType = item
            self?.btnDrop1.setTitle(item, for: .normal)
            self?.lblMonths.text = item
        }
    }
    
    @IBAction func btnDropDown2(_ sender: UIButton) {
        self.dropDown2.show()
    }
    
    func configureDropDown2()
    {
        dropDown2.anchorView = self.btnDrop2
        dropDown2.dataSource = self.arrCount
        dropDown2.bottomOffset = CGPoint(x: -5, y: 45)
        dropDown2.selectionAction = { [weak self] index, item in
            print("Selected item: \(item) at index: \(index)")
            self?.selectedHours = item
            self?.calculation()
            self?.btnDrop2.setTitle(item, for: .normal)
            self?.lblHours.text = item
            self?.lbltotalHour.text = "\(item) Hours (25.00/hr)*"
        }
    }
    
    @IBAction func btnDropDown3(_ sender: UIButton) {
        self.dropDown3.show()
    }
    
    func configureDropDown3()
    {
        dropDown3.anchorView = self.btnDrop3
        dropDown3.dataSource = self.arrCount
        dropDown3.bottomOffset = CGPoint(x: -5, y: 45)
        dropDown3.selectionAction = { [weak self] index, item in
            print("Selected item: \(item) at index: \(index)")
            self?.selectedMaid = item
            self?.calculation()
            self?.btnDrop3.setTitle(item, for: .normal)
            self?.lblMaids.text = item
            self?.lblTotalMaid.text = "\(item) Maids for 1 visits"
        }
    }
    
    @IBAction func btnDropDown4(_ sender: UIButton) {
        self.dropDown4.show()
    }
    
    func configureDropDown4()
    {
        dropDown4.anchorView = self.lblCleaner
        dropDown4.dataSource = self.arrCleaner
        dropDown4.bottomOffset = CGPoint(x: -5, y: 45)
        dropDown4.selectionAction = { [weak self] index, item in
            print("Selected item: \(item) at index: \(index)")
            self?.selectedCleaner = item
            self?.lblCleaner.text = item
        }
    }
    
    @IBAction func swicth(_ sender: UISwitch) {
        if switchOnOff.isOn == false {
            self.vieToHide.isHidden  = true
            self.lblAddtionalCleaning.text = "No"
            self.swicth1 = "No"
            self.calculation()
        }else{
            self.vieToHide.isHidden  = false
            self.swicth1 = "Yes"
            self.lblAddtionalCleaning.text = "Yes"
            self.validate()
            self.calculation()
            self.extraCleaning()
        }
    }
    
    @IBAction func switch2(_ sender: UISwitch) {
        if switchOnOff2.isOn == false
        {
            self.viewToHide2.isHidden = true
        }else
        {
            self.viewToHide2.isHidden = false
            self.swicth2 = "Yes"
            self.validate2()
            self.extraService()
        }
    }
    
    @IBAction func btnShow(_ sender: UIButton) {
        if isButtonImageSet {
               // If the button image is already set, change it back to the initial image
            self.btnChange.setImage(UIImage(named: "uparrow"), for: .normal)
               isButtonImageSet = false
           } else {
               // If the button image is not set, change it to a new image
            self.btnChange.setImage(UIImage(named: "downarrow"), for: .normal)
               isButtonImageSet = true
           }
        self.viewBooking.isHidden = !self.viewBooking.isHidden
        self.viewDetail.isHidden = !self.viewDetail.isHidden
    }
    
    func extraCleaning()
    {
        Api.shared.getExtraCLeaningList(self) { responseData in
            if responseData.count > 0
            {
                self.arrCleaning = responseData
            }else
            {
                self.arrCleaning = []
            }
            self.cleaningCollectionView.reloadData()
        }
    }
    
    func validate()
    {
        var strId = [String]()
        var strName = [String]()
        for val in selectedItem1 {
            let obj = self.arrCleaning[val.key]
            strId.append(obj.id ?? "")
            strName.append(obj.name ?? "")
        }
        self.strCleanId = strId.joined(separator: ",")
        print(self.strCleanId)
        self.strCleanName = strName.joined(separator: ",")
        print(self.strCleanName)
    }
    
    func validate2()
    {
        var strId1 = [String]()
        var strName2 = [String]()
        for val in selectedItem2 {
            let obj = self.arrExtra[val.key]
            strId1.append(obj.id ?? "")
            strName2.append(obj.name ?? "")
        }
        self.strServiceId = strId1.joined(separator: ",")
        print(self.strServiceId)
        self.strServiceName = strName2.joined(separator: ",")
        print(self.strServiceName)
    }
    
    
    func extraService()
    {
        Api.shared.getExtraServiceList(self) { responseData in
            if responseData.count > 0
            {
                self.arrExtra = responseData
            }else
            {
                self.arrExtra = []
            }
            self.serviceCollectionView.reloadData()
        }
    }
    
    func calculation()
    {
        Api.shared.calucation(self, self.paramDetail()) { responseData in
            let obj = responseData
            self.lblServiceAmount.text! = "\(obj.service_amount ?? "")"
            self.lblDiscountAmount.text! = "\(obj.vAT_amount ?? "")"
            self.lblTotal.text! = "\(obj.total_amount ?? "")"
            self.serviceAmount = obj.service_amount ?? ""
            self.serviceDiscount = obj.vAT_amount ?? ""
            self.serviceTotalAmount = obj.total_amount ?? ""
        }
    }
    
    func paramDetail() -> [String : AnyObject]
    {
        var dict: [String : AnyObject] = [:]
        dict["user_id"]                = k.userDefault.string(forKey: k.session.userId) as AnyObject
        dict["no_of_maid"]             = self.selectedMaid as AnyObject
        dict["total_hr"]               = self.selectedHours as AnyObject
        dict["cleaning_material"]      = self.swicth1 as AnyObject
        print(dict)
        return dict
    }
    
    
    @IBAction func btnNext(_ sender: UIButton) {
        let vc = Kstoryboard.instantiateViewController(withIdentifier: "SavedAddressVC") as! SavedAddressVC
        vc.howManyHour = self.selectedHours
        vc.howManyMaid = self.selectedMaid
        vc.anyCleaningMaterial = self.swicth1
        vc.cleaningMaterialName = self.strCleanName
        vc.cleaningMaterialId = self.strCleanId
        vc.cleaningMaterialPrice = self.cleaningPrice
        vc.anyAdditionalService = self.swicth2
        vc.additionalServiceName = self.strServiceName
        print(vc.additionalServiceName)
        vc.additionalServicePrice = self.servicePrice
        vc.additionalServiceTime = self.serviceTime
        vc.additionalServiceId = self.strServiceId
        vc.howCleanerEnter = self.selectedCleaner
        vc.descriptionVal = self.txtDescription.text!
        vc.totalAmount = self.lblTotal.text!
        print(vc.totalAmount)
        vc.serviceAmount = self.lblServiceAmount.text!
        print(vc.serviceAmount)
        vc.vatAmount = self.lblDiscountAmount.text!
        print(vc.vatAmount)
        vc.VAT = self.vatDiscount
        vc.checkStr = "Next"
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension OptionSlotVC: UICollectionViewDataSource
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView.tag == 0 {
            return self.arrCleaning.count
        }else{
            return self.arrExtra.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView.tag == 0
        {
           
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CleaningCell", for: indexPath) as! CleaningCell
            if selectedItem1[indexPath.row] == true {
                
                let obj = arrCleaning[indexPath.row]
                cell.lblHeading.text! = obj.name ?? ""
                self.cleaningPrice = obj.price ?? ""
                cell.checkImg.image = UIImage(named: "Checked")
                Utility.setImageWithSDWebImage(obj.image ?? "", cell.img)
            }else{
                let obj = arrCleaning[indexPath.row]
                cell.lblHeading.text! = obj.name ?? ""
                self.cleaningPrice = obj.price ?? ""
                cell.checkImg.image = UIImage(named: "Uncheck1")
                Utility.setImageWithSDWebImage(obj.image ?? "", cell.img)
            }
            return cell
        }
        else
        {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ServiceCell", for: indexPath) as! ServiceCell
            
            if selectedItem2[indexPath.row] == true {
                
                let obj = self.arrExtra[indexPath.row]
                cell.lblName.text! = obj.name ?? ""
                cell.lblTime.text! = obj.time ?? ""
                self.servicePrice = obj.price ?? ""
                self.serviceTime = obj.time ?? ""
                cell.checkImg.image = UIImage(named: "Checked")
                Utility.setImageWithSDWebImage(obj.image ?? "", cell.img)
            }else{
                let obj = self.arrExtra[indexPath.row]
                cell.lblName.text! = obj.name ?? ""
                cell.lblTime.text! = obj.time ?? ""
                self.servicePrice = obj.price ?? ""
                self.serviceTime = obj.time ?? ""
                cell.checkImg.image = UIImage(named: "Uncheck1")
                Utility.setImageWithSDWebImage(obj.image ?? "", cell.img)
            }
            return cell
        }
    }
}

extension OptionSlotVC: UICollectionViewDelegate
{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView.tag == 0
        {
            let cell = cleaningCollectionView.cellForItem(at: indexPath) as! CleaningCell
            cell.checkImg.image = UIImage(named: "Checked")
            self.selectedItem1[indexPath.row] = true
            print(selectedItem1)
        }else
        {
            let cell = serviceCollectionView.cellForItem(at: indexPath) as! ServiceCell
            cell.checkImg.image = UIImage(named: "Checked")
            self.selectedItem2[indexPath.row] = true
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if collectionView.tag == 0
        {
            let cell = cleaningCollectionView.cellForItem(at: indexPath) as! CleaningCell
            cell.checkImg.image = UIImage(named: "Uncheck1")
            selectedItem1[indexPath.row] = false
        }else
        {
            let cell = serviceCollectionView.cellForItem(at: indexPath) as! ServiceCell
            cell.checkImg.image = UIImage(named: "Uncheck1")
            self.selectedItem2[indexPath.row] = false
        }
    }
}

extension OptionSlotVC: UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView.tag == 0
        {
            let size = collectionView.frame.size
            return CGSize(width: 200, height: 50)
        }
        else
        {
            let size = collectionView.frame.size
            return CGSize(width: 150, height: 75)
        }
    }
}
