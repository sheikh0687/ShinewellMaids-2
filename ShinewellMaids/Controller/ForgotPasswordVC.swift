//
//  ForgotPasswordVC.swift
//  ShinewellMaids
//
//  Created by Techimmense Software Solutions on 10/06/23.
//

import UIKit

class ForgotPasswordVC: UIViewController {

    @IBOutlet var txtEmail: UITextField!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
        setNavigationBarItem(LeftTitle: "", LeftImage: "black_back", CenterTitle: "Forgot Password", CenterImage: "", RightTitle: "", RightImage: "", BackgroundColor: "#D2F6F4", BackgroundImage: "", TextColor: "#000000", TintColor: "#000000", Menu: "")
    }
    
    override func viewWillDisappear(_ animated: Bool)
    {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    @IBAction func btnSend(_ sender: UIButton) {
        if self.txtEmail.hasText{
            self.forgotPassword()
        }else{
            self.alert(alertmessage: "Please Enter the Email!")
        }
    }
    
    func forgotPassword() {
        Api.shared.forgotPassword(self, self.paramForgetPassword()) { (response) in
            if response.status == "1" {
                Utility.showAlertWithAction(withTitle: k.appName, message: "New password has sent to your email!", delegate: nil, parentViewController: self) { (bool) in
                    self.dismiss(animated: true, completion: nil)
                }
            } else {
                Utility.showAlertMessage(withTitle: k.appName, message: "Email does not exist!", delegate: nil, parentViewController: self)
            }
        }
    }
    
    func paramForgetPassword() -> [String : AnyObject]
    {
        var dict: [String : AnyObject] = [:]
        dict["email"]                  = self.txtEmail.text! as AnyObject
        return dict
    }
}
