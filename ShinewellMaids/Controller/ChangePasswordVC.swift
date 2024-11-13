//
//  ChangePasswordVC.swift
//  ShinewellMaids
//
//  Created by Techimmense Software Solutions on 13/06/23.
//

import UIKit

class ChangePasswordVC: UIViewController {

    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtNewPassword: UITextField!
    @IBOutlet weak var txtConfirmPassword: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
        setNavigationBarItem(LeftTitle: "", LeftImage: "black_back", CenterTitle: "Change Password", CenterImage: "", RightTitle: "", RightImage: "", BackgroundColor: "#D2F6F4", BackgroundImage: "", TextColor: "#000000", TintColor: "#000000", Menu: "")
     
    }
    
    override func leftClick() {
        toggleLeft()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    @IBAction func btnSaved(_ sender: UIButton)
    {
        if self.txtPassword.hasText && self.txtNewPassword.hasText && self.txtConfirmPassword.hasText {
            self.updatePassword()
        }else{
            self.alert(alertmessage: "Please Enter the Required Details!")
        }
    }
    
    func updatePassword()
    {
        Api.shared.changePassword(self, self.passwordParam()) { responseData in
            self.alert(alertmessage: "Password Changed Successfully!")
        }
    }
    
    func passwordParam() -> [String : AnyObject]
    {
        var dict: [String : AnyObject] = [:]
        dict["user_id"]                = k.userDefault.value(forKey: k.session.userId) as AnyObject
        dict["password"]               = self.txtNewPassword.text! as AnyObject
        dict["old_password"]           = self.txtPassword.text! as AnyObject
        return dict
    }
}
