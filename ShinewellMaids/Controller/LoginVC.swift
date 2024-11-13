//
//  LoginVC.swift
//  ShinewellMaids
//
//  Created by Techimmense Software Solutions on 10/06/23.
//

import UIKit

class LoginVC: UIViewController {
    
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    @IBAction func btnSkip(_ sender: UIButton) {
        let homeViewController = Kstoryboard.instantiateViewController(withIdentifier: "HomeVC") as! HomeVC
        let CheckViewController = UINavigationController(rootViewController: homeViewController)
        
        kAppDelegate.window?.rootViewController = CheckViewController
        kAppDelegate.window?.makeKeyAndVisible()
    }
    
    @IBAction func btnForgot(_ sender: UIButton) {
        let vc = Kstoryboard.instantiateViewController(withIdentifier: "ForgotPasswordVC") as! ForgotPasswordVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func btnLogin(_ sender: UIButton) {
        if self.txtEmail.hasText && self.txtPassword.hasText {
            self.Login()
        }else{
            self.alert(alertmessage: "Please Enter the Correct Details!")
        }
    }
    
    func Login()
    {
        Api.shared.login(self, self.paramLogin()) { responseData in
            self.hideProgressBar()
            k.userDefault.set(true, forKey: k.session.status)
            k.userDefault.set(responseData.id ?? "", forKey: k.session.userId)
            k.userDefault.set("\(responseData.first_name ?? "") \(responseData.last_name ?? "")", forKey: k.session.userName)
            k.userDefault.set(responseData.email ?? "", forKey: k.session.userEmail)
            k.userDefault.set(responseData.type ?? "", forKey: k.session.userType)
            k.userDefault.set(responseData.referral_code ?? "", forKey: k.session.userReferal)
            Switcher.checkLogin()
        }
    }
    
    
    func paramLogin() -> [String : AnyObject]
    {
        var dict: [String : AnyObject] = [:]
        
        dict["email"]                  = self.txtEmail.text! as AnyObject
        dict["password"]               = self.txtPassword.text! as AnyObject
        dict["register_id"]            = k.emptyString as AnyObject
        dict["lat"]                    = k.emptyString as AnyObject
        dict["lon"]                    = k.emptyString  as AnyObject
        return dict
    }
    
    @IBAction func btnSignUp(_ sender: UIButton) {
        let vc = Kstoryboard.instantiateViewController(withIdentifier: "SignUpVC") as! SignUpVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
