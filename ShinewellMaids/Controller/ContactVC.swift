//
//  ContactVC.swift
//  ShinewellMaids
//
//  Created by Techimmense Software Solutions on 13/06/23.
//

import UIKit

class ContactVC: UIViewController {

    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtDescription: UITextView!
    @IBOutlet weak var txtEmail: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
        setNavigationBarItem(LeftTitle: "", LeftImage: "black_back", CenterTitle: "Contact Us", CenterImage: "", RightTitle: "", RightImage: "", BackgroundColor: "#D2F6F4", BackgroundImage: "", TextColor: "#000000", TintColor: "#000000", Menu: "")
        self.txtDescription.addHint("Enter")
    }
    
    override func leftClick() {
        toggleLeft()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    @IBAction func btnSend(_ sender: UIButton) {
        if self.txtName.hasText && self.txtDescription.hasText && self.txtEmail.hasText{
            self.feedback()
        }else{
            self.alert(alertmessage: "Please enter the required details!")
        }
    }
    
    func feedback()
    {
        Api.shared.sendFeedback(self, self.paramFeedback()) { responseData in
            Utility.showAlertWithAction(withTitle: k.appName, message: "We Will Contact you soon, Thanks!", delegate: nil, parentViewController: self) { boool in
                Switcher.checkLogin()
            }
        }
    }
    
    func paramFeedback() -> [String : AnyObject]
    {
        var dict: [String : AnyObject] = [:]
        dict["user_id"]                = k.userDefault.value(forKey: k.session.userId) as AnyObject
        dict["name"]                   = self.txtName.text! as AnyObject
        dict["contact_number"]         = k.emptyString as AnyObject
        dict["email"]                  = self.txtEmail.text! as AnyObject
        dict["feedback"]               = self.txtDescription.text! as AnyObject
        print(dict)
        return dict
    }
}
