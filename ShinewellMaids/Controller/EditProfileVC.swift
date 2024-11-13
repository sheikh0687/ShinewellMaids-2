//
//  EditProfileVC.swift
//  ShinewellMaids
//
//  Created by Techimmense Software Solutions on 13/06/23.
//

import UIKit
import SDWebImage
import CountryPickerView

class EditProfileVC: UIViewController {

    @IBOutlet weak var img: UIButton!
    @IBOutlet weak var txtFirstname: UITextField!
    @IBOutlet weak var txtLastName: UITextField!
    @IBOutlet weak var txtMobile: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    
    var image = UIImage()
    let cpvInternal = CountryPickerView()
    weak var cpvTextField: CountryPickerView!
    var phoneKey:String?
    var phoneNumber: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureCountryView()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
        setNavigationBarItem(LeftTitle: "", LeftImage: "black_back", CenterTitle: "Edit Profile", CenterImage: "", RightTitle: "", RightImage: "", BackgroundColor: "#D2F6F4", BackgroundImage: "", TextColor: "#000000", TintColor: "#000000", Menu: "")
        self.Profile()
    }
    
    override func leftClick() {
        toggleLeft()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }

    func configureCountryView() {
        let cp = CountryPickerView(frame: CGRect(x: 0, y: 0, width: 120, height: 20))
        txtMobile.leftView = cp
        txtMobile.leftViewMode = .always
        self.cpvTextField = cp
        cp.delegate = self
        [cp].forEach {
            $0?.dataSource = self
        }
        cp.countryDetailsLabel.font = UIFont(name: "Cairo-Bold", size: 14.0)
        self.phoneKey = cp.selectedCountry.phoneCode
    }
    
    @IBAction func imageTapped(_ sender: UIButton)
    {
        CameraHandler.shared.showActionSheet(vc: self)
        CameraHandler.shared.imagePickedBlock = { (image) in
            self.image = image
            sender.contentMode = .scaleToFill
            sender.setImage(image, for: .normal)
        }
    }
    
    func Profile()
    {
        Api.shared.getProfile(self) { responseData in
            let obj = responseData
            self.txtFirstname.text = obj.first_name ?? ""
            self.txtLastName.text = obj.last_name ?? ""
            self.txtEmail.text = obj.email ?? ""
            self.txtMobile.text = obj.mobile ?? ""
            if let imageUrl = URL(string: obj.image ?? ""){
                self.img.sd_setImage(with: imageUrl, for: .normal, placeholderImage: UIImage(named: "profile_ic"), options: .continueInBackground,completed: nil)
            }
        }
    }
    
    @IBAction func btnUpdate(_ sender: UIButton) {
        if self.txtEmail.hasText && self.txtFirstname.hasText && self.txtFirstname.hasText && txtMobile.hasText{
            Api.shared.updatedProfile(self, self.profileParam(), images: self.profileImage(), videos: [:]) { responseData in
                Utility.showAlertWithAction(withTitle: k.appName, message: "Profile updated Successfully!", delegate: nil, parentViewController: self) { boool in
                    self.Profile()
                }
            }
        }else{
            self.alert(alertmessage: "Please Enter the Required Details!")
        }
    }
    
    func profileParam() -> [String : String]
    {
        let paramDetails =
        [
            "user_id": k.userDefault.string(forKey: k.session.userId)!,
            "first_name": self.txtFirstname.text!,
            "last_name": self.txtLastName.text!,
            "mobile": self.txtMobile.text!,
            "email": self.txtEmail.text!,
            "about_us": k.emptyString,
            "address": k.emptyString,
            "lat": k.emptyString,
            "lon": k.emptyString
        ]
        return paramDetails
    }
    
    func profileImage() -> [String : UIImage]
    {
        var imageDict: [String : UIImage] = [:]
        imageDict["image"] = image
        return imageDict
    }
}

extension EditProfileVC: CountryPickerViewDelegate {
    
    func countryPickerView(_ countryPickerView: CountryPickerView, didSelectCountry country: Country) {
        self.phoneKey = country.phoneCode
    }
}

extension EditProfileVC: CountryPickerViewDataSource {
    
    func preferredCountries(in countryPickerView: CountryPickerView) -> [Country] {
        var countries = [Country]()
        ["GB"].forEach { code in
            if let country = countryPickerView.getCountryByCode(code) {
                countries.append(country)
            }
        }
        return countries
    }
    
    func sectionTitleForPreferredCountries(in countryPickerView: CountryPickerView) -> String? {
        return "Preferred title"
    }
    
    func showOnlyPreferredSection(in countryPickerView: CountryPickerView) -> Bool {
        return false
    }
    
    func navigationTitle(in countryPickerView: CountryPickerView) -> String? {
        return "Select a Country"
    }
}
