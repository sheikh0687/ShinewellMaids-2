//
//  HomeVC.swift
//  ShinewellMaids
//
//  Created by Techimmense Software Solutions on 10/06/23.
//

import UIKit
import SlideMenuControllerSwift
import DropDown
import SDWebImage

class HomeVC: UIViewController {
    
    @IBOutlet weak var imageCollectionView: UICollectionView!
    @IBOutlet weak var pageView: UIPageControl!
    @IBOutlet weak var btnDrop: UIButton!
    
    let identifier = "OfferCell"
    let dropDown = DropDown()
    var timer = Timer()
    var counter = 0
    var selectedAreaId = ""
    var selectedAreaName = ""
    var arrAreaList: [ResAreaList] = []
    var arrOffer: [ResOfferList] = []
    var adminPhone = ""
    var adminWhatsApp = ""
    var areaName = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.imageCollectionView.register(UINib(nibName: identifier, bundle: nil),forCellWithReuseIdentifier: identifier)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
        pageView.numberOfPages = arrOffer.count
        pageView.currentPage = 0
        self.areaList()
        self.offerList()
        self.setting()
        self.Profile()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    @IBAction func btnLeftMenu(_ sender: UIButton)
    {
        if Utility.isUserLogin() {
            self.toggleLeft()
        } else {
            self.alert(alertmessage: "Please register to use this app!")
        }
    }
    
    @IBAction func btnNotification(_ sender: UIButton) {
        let vc = Kstoryboard.instantiateViewController(withIdentifier: "NotififcationVC") as! NotififcationVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func btnPhone(_ sender: UIButton)
    {
        if Utility.isUserLogin() {
            let phoneNumber = self.adminPhone
            print(phoneNumber)// Replace with the contact number you want to open
            
            guard let url = URL(string: "tel://\(phoneNumber)") else {
                // Invalid URL
                // Handle the error condition here
                return
            }
            
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            } else {
                print("Device is not supporting the phone call!")
            }
        } else {
            self.alert(alertmessage: "Please register to use this app!")
        }
    }
    
    @IBAction func btnWhatsApp(_ sender: UIButton)
    {
        if Utility.isUserLogin() {
            let whatsAppNumber = self.adminWhatsApp
            print(whatsAppNumber)// Replace with the phone number you want to open the chat with
            
            if let url = URL(string: "https://wa.me/\(whatsAppNumber)"), UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            } else {
                
            }
        } else {
            self.alert(alertmessage: "Please register to use this app!")
        }
    }
    
    func Profile()
    {
        Api.shared.getProfile(self) { responseData in
            k.userDefault.set(responseData.area ?? "", forKey: k.session.areaName)
            self.btnDrop.setTitle(k.userDefault.value(forKey: k.session.areaName) as? String, for: .normal)
            self.areaName = responseData.area ?? ""
        }
    }
    
    func setting()
    {
        Api.shared.getSetting(self) { responseData in
            let obj = responseData
            self.adminPhone = obj.admin_number ?? ""
            self.adminWhatsApp = obj.admin_whatsapp_number ?? ""
        }
    }
    
    func offerList()
    {
        Api.shared.getOfferList(self) { responseData in
            if responseData.count > 0
            {
                self.arrOffer = responseData
            }else
            {
                self.arrOffer = []
            }
            self.imageCollectionView.reloadData()
        }
    }
    
    @IBAction func btnDropDown(_ sender: UIButton)
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
    
    @IBAction func btnBook(_ sender: UIButton) {
        if self.areaName != "" {
            let vc = Kstoryboard.instantiateViewController(withIdentifier: "OptionSlotVC") as! OptionSlotVC
            self.navigationController?.pushViewController(vc, animated: true)
        }else{
            self.updateArea()
            let vc = Kstoryboard.instantiateViewController(withIdentifier: "OptionSlotVC") as! OptionSlotVC
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func updateArea()
    {
        Api.shared.updatedArea(self, self.paramDetails(), images: [:], videos: [:]) { responseData in
            print("Added Successfully!")
        }
    }
    
    func paramDetails() -> [String : String]
    {
        var paramDict: [String : String] = [:]
        paramDict["user_id"]             = k.userDefault.value(forKey: k.session.userId) as? String
        paramDict["area_id"]             = self.selectedAreaId
        paramDict["area"]                = self.selectedAreaName
        return paramDict
    }
}

extension HomeVC: UICollectionViewDataSource
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.arrOffer.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "OfferCell", for: indexPath) as! OfferCell
        
        let obj = arrOffer[indexPath.row]
        cell.lblCode.text! = obj.code ?? ""
        cell.lblDescription.text! = obj.description ?? ""
        if let imageUrl = URL(string: obj.image ?? ""){
            cell.img.sd_setImage(with: imageUrl, placeholderImage: UIImage(named: ""), options: .continueInBackground,completed: nil)
        }
        return cell
    }
}

extension HomeVC: UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = collectionView.frame.size
        return CGSize(width: size.width, height: size.height)
    }
}

