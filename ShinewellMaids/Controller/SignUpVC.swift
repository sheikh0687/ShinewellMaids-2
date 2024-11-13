//
//  SignUpVC.swift
//  ShinewellMaids
//
//  Created by Techimmense Software Solutions on 10/06/23.
//

import UIKit
import CountryPickerView
import GoogleSignIn
import AuthenticationServices

class SignUpVC: UIViewController {
    
    @IBOutlet weak var txtFirstName: UITextField!
    @IBOutlet weak var txtLastName: UITextField!
    @IBOutlet weak var txtMobile: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtConfirmPassword: UITextField!
    @IBOutlet weak var txtRefCode: UITextField!
    @IBOutlet weak var btnCheck: UIButton!
    
    let cpvInternal = CountryPickerView()
    weak var cpvTextField: CountryPickerView!
    var phoneKey:String?
    var phoneNumber: String = ""
    var countryCode = ""
    var countryCodeWithoutPlus = ""
    var googleSignIn = GIDSignIn.sharedInstance
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        GIDSignIn.sharedInstance().delegate = self
        GIDSignIn.sharedInstance()?.presentingViewController = self
        self.configureCountryView()
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
        self.btnCheck.image(for: .normal) == UIImage.init(named: "Uncheck1")
    }
    
    override func viewWillDisappear(_ animated: Bool)
    {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: false)
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
    
    @IBAction func btnTermsCondition(_ sender: UIButton) {
        let vc = R.storyboard.main().instantiateViewController(withIdentifier: "TermsNConditionVC") as! TermsNConditionVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func btnBack(_ sender: UIButton)
    {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnCheckBox(_ sender: UIButton)
    {
        if btnCheck.image(for: .normal) == UIImage.init(named: "Uncheck1")
        {
            self.btnCheck.setImage(UIImage(named: "Checked"), for: .normal)
        }
        else
        {
            self.btnCheck.setImage(UIImage(named: "Uncheck1"), for: .normal)
        }
    }
    
    @IBAction func btnRegister(_ sender: UIButton)
    {
        self.RagistationValidation()
    }
    
    func RagistationValidation()->Bool
    {
        if txtFirstName.text!.isEmpty
        {
            self.alert(alertmessage: "Required First Name")
            return false
        }
        else if txtLastName.text!.isEmpty
        {
            self.alert(alertmessage: "Required Last Name")
            return false
        }
        else if txtMobile.text!.isEmpty
        {
            self.alert(alertmessage: "Please Enter Mobile Number")
            return false
        }
        else if txtEmail.text!.isEmpty
        {
            self.alert(alertmessage: "Email Address Not Found")
            return false
        }
        else if txtPassword.text!.isEmpty
        {
            self.alert(alertmessage: "Please Enter the Password!")
            return false
        }
        else if txtConfirmPassword.text!.isEmpty
        {
            self.alert(alertmessage: "Please Confirm Password")
            return false
        }
        else if btnCheck.image(for: .normal) != UIImage.init(named: "Checked")
        {
            self.alert(alertmessage: "Please Read the Terms And Condition For Proceed")
            return false
        }
        else
        {
            self.signUp()
            return true
        }
    }
    
    func signUp()
    {
        Api.shared.signUpUser(self, self.signUpParams()) { (response) in
            Utility.showAlertWithAction(withTitle: k.appName, message: "Your Account has created successfully!", delegate: nil, parentViewController: self) { (boool) in
                k.userDefault.set(true, forKey: k.session.status)
                k.userDefault.set(response.id ?? "", forKey: k.session.userId)
                k.userDefault.set("\(response.first_name ?? "") \(response.last_name ?? "")", forKey: k.session.userName)
                k.userDefault.set(response.image ?? "", forKey: k.session.userImage)
                k.userDefault.set(response.email ?? "", forKey: k.session.userEmail)
                k.userDefault.set(response.type ?? "", forKey: k.session.userType)
                k.userDefault.set(response.referral_code ?? "", forKey: k.session.userReferal)
                Switcher.checkLogin()
            }
        }
    }
    
    func signUpParams() -> [String : AnyObject]
    {
        var dict: [String : AnyObject] =    [:]
        dict["first_name"]             =    self.txtFirstName.text! as AnyObject
        dict["last_name"]              =    self.txtLastName.text! as AnyObject
        dict["mobile"]                 =    self.txtMobile.text! as AnyObject
        dict["email"]                  =    self.txtEmail.text! as AnyObject
        dict["password"]               =    self.txtPassword.text! as AnyObject
        dict["register_id"]            =    k.emptyString as AnyObject
        dict["ios_register_id"]        =    k.iosRegisterId as AnyObject
        dict["lat"]                    =    k.emptyString as AnyObject
        dict["lon"]                    =    k.emptyString as AnyObject
        dict["signup_referral_code"]   =    self.txtRefCode.text! as AnyObject
        dict["mobile_with_code"]       =    self.countryCodeWithoutPlus as AnyObject
        print(dict)
        return dict
    }
    
    @IBAction func btnGoogle(_ sender: UIButton) {
        GIDSignIn.sharedInstance()?.signIn()
    }
    
    func paramSocialLogin(fName: String,lName: String,email: String,mobile: String, socialId: String) -> [String:String] {
        var dict:[String:String] = [:]
        dict["first_name"] = fName
        dict["last_name"] = lName
        dict["email"] = email
        dict["mobile"] = mobile
        dict["social_id"] = socialId
        dict["register_id"] = k.emptyString
        dict["ios_register_id"] = k.iosRegisterId
        dict["type"]  = "Normal"
        dict["lat"] = kAppDelegate.CURRENT_LAT
        dict["lon"] = kAppDelegate.CURRENT_LON
        print(dict)
        return dict
    }
    
    func socail_Login(fName: String,lName: String,email: String,mobile: String, socialId: String) {
        Api.shared.socialLogin(self, self.paramSocialLogin(fName: fName, lName: lName, email: email, mobile: mobile, socialId: socialId), images: [:], videos: [:]) { responseData in
            k.userDefault.set(true, forKey: k.session.status)
            k.userDefault.set(responseData.id ?? "", forKey: k.session.userId)
            k.userDefault.set("\(responseData.first_name ?? "") \(responseData.last_name ?? "")", forKey: k.session.userName)
            k.userDefault.set(responseData.email ?? "", forKey: k.session.userEmail)
            Switcher.checkLogin()
        }
    }
    
    @IBAction func btnSignInApple(_ sender: UIButton) {
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        request.requestedScopes = [.fullName, .email]
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = self
        authorizationController.performRequests()
    }
}

extension SignUpVC: CountryPickerViewDelegate {
    
    func countryPickerView(_ countryPickerView: CountryPickerView, didSelectCountry country: Country) {
        self.phoneKey = country.phoneCode
        self.countryCode = country.phoneCode
        self.countryCodeWithoutPlus = countryCode.replacingOccurrences(of: "+", with: "")
    }
}

extension SignUpVC: CountryPickerViewDataSource {
    
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

extension SignUpVC: GIDSignInDelegate {
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!,
              withError error: Error!) {
        if let error = error {
            print("\(error.localizedDescription)")
            // [START_EXCLUDE silent]
            NotificationCenter.default.post(
                name: Notification.Name(rawValue: "ToggleAuthUINotification"), object: nil, userInfo: nil)
            // [END_EXCLUDE]
        } else {
            // Perform any operations on signed in user here.
            let userId = user.userID                  // For client-side use only!
            let idToken = user.authentication.idToken // Safe to send to the server
            let fullName = user.profile.name
            let givenName = user.profile.givenName
            let familyName = user.profile.familyName
            let email = user.profile.email
            
            self.socail_Login(fName: fullName ?? "", lName: "", email: email ?? "", mobile: "", socialId: userId ?? "")
        }
    }
}


extension SignUpVC: ASAuthorizationControllerDelegate {
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        
        if let appleIdCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
            
            let userInfo = appleIdCredential.user
            
            // Use guard let to safely unwrap optional values
            guard let fullName = appleIdCredential.fullName else {
                self.alert(alertmessage: "Full Name is not provided")
                return
            }

            // Use guard let to safely unwrap email
            guard let email = appleIdCredential.email else {
                self.alert(alertmessage: "Email id is not provided")
                return
            }
            
            print("User id is \(userInfo)")
            
            self.socail_Login(fName: fullName.description, lName: "", email: email, mobile: "", socialId: userInfo)
        }
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        ////
    }
}

extension SignUpVC : ASAuthorizationControllerPresentationContextProviding {
    
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return self.view.window!
    }
}
