//
//  LeftMenuVC.swift
//  ShinewellMaids
//
//  Created by Techimmense Software Solutions on 13/06/23.
//

import UIKit

class LeftMenuVC: UIViewController {

    @IBOutlet weak var leftTableView: UITableView!
    @IBOutlet weak var leftTableHeight: NSLayoutConstraint!
    @IBOutlet weak var lblName: UILabel!
    
    let identifier = "LeftMenuCell"
    
    var arrName =
    
    [
        
    "Home",
    "Address",
    "My Bookings",
    "Booking History",
    "Pending Bill",
    "Change Password",
    "Referal Friends",
    "Wallet",
    "Contact Us"
    
    ]
    
    var arrImage =
    [
        
    UIImage(named: "Home24.jpg"),
    UIImage(named: "myaddress.jpg"),
    UIImage(named: "mybooking.jpg"),
    UIImage(named: "history.jpg"),
    UIImage(named: "history.jpg"),
    UIImage(named: "password.jpg"),
    UIImage(named: "share.jpg"),
    UIImage(named: "Wallet1.jpg"),
    UIImage(named: "Wallet1.jpg")
    
    ]
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.leftTableView.register(UINib(nibName: identifier, bundle: nil), forCellReuseIdentifier: identifier)
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        self.leftTableHeight.constant = CGFloat(self.arrName.count * 45)
        self.Profile()
    }
    
    func Profile()
    {
        Api.shared.getProfile(self) { responseData in
            let obj = responseData
            self.lblName.text = "\(obj.first_name ?? "") \(obj.last_name ?? "")"
        }
    }
    
    @IBAction func btnUpdateProfile(_ sender: UIButton) {
        let vc = Kstoryboard.instantiateViewController(withIdentifier: "EditProfileVC") as! EditProfileVC
        let vc1 = UINavigationController(rootViewController: vc)
        self.slideMenuController()?.changeMainViewController(vc1, close: true)
    }
    
    @IBAction func btnLogout(_ sender: UIButton)
    {
        let domain = Bundle.main.bundleIdentifier!
        UserDefaults.standard.removePersistentDomain(forName: domain)
        UserDefaults.standard.synchronize()
        Switcher.checkLogin()
    }
    
    @IBAction func btnDeleteAccount(_ sender: UIButton) {
        Utility.showAlertYesNoAction(withTitle: "Confirmation", message: "Are you sure to delete with this account", delegate: nil, parentViewController: self) { bool in
            if bool {
                self.delete_Account()
            } else {
                self.dismiss(animated: true)
            }
        }
    }
    
    func delete_Account()
    {
        Api.shared.delete_Account(self) { responseData in
            let obj = responseData
            if obj.status == "1" {
                let domain = Bundle.main.bundleIdentifier!
                UserDefaults.standard.removePersistentDomain(forName: domain)
                UserDefaults.standard.synchronize()
                Switcher.checkLogin()
            } else {
                print("Something went wrong!")
            }
        }
    }
}

extension LeftMenuVC: UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrName.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LeftMenuCell", for: indexPath) as! LeftMenuCell
        cell.img.image = self.arrImage[indexPath.row]
        cell.lblName.text = self.arrName[indexPath.row]
        return cell
    }
}

extension LeftMenuVC: UITableViewDelegate
{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 45
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        let vcHome = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "HomeVC") as! HomeVC
        let vc1 = UINavigationController(rootViewController: vcHome)
        
        let vcNav = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SavedAddressVC") as! SavedAddressVC
        let vc2 = UINavigationController(rootViewController: vcNav)
        
        let vcNav1 = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MyBookingVC") as! MyBookingVC
        let vc3 = UINavigationController(rootViewController: vcNav1)
        
        let vcNav2 = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "BookingHistoryVC") as! BookingHistoryVC
        let vc4 = UINavigationController(rootViewController: vcNav2)
        
        let vcNav3 = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PendingBillVC") as! PendingBillVC
        let vc5 = UINavigationController(rootViewController: vcNav3)
        
        let vcNav4 = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ChangePasswordVC") as! ChangePasswordVC
        let vc6 = UINavigationController(rootViewController: vcNav4)
        
        let vcNav5 = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ReferFriendVC") as! ReferFriendVC
        let vc7 = UINavigationController(rootViewController: vcNav5)
        
        let vcNav6 = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "WalletVC") as! WalletVC
        let vc8 = UINavigationController(rootViewController: vcNav6)
        
        let vcNav7 = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ContactVC") as! ContactVC
        let vc9 = UINavigationController(rootViewController: vcNav7)
        
        if indexPath.row == 0
        {
            self.slideMenuController()?.changeMainViewController(vc1, close: true)
        }
        
        else if indexPath.row == 1
        {
            self.slideMenuController()?.changeMainViewController(vc2, close: true)
        }
        
        else if indexPath.row == 2
        {
            self.slideMenuController()?.changeMainViewController(vc3, close: true)
        }
        
        else if indexPath.row == 3
        {
            self.slideMenuController()?.changeMainViewController(vc4, close: true)
        }
        
        else if indexPath.row == 4
        {
            self.slideMenuController()?.changeMainViewController(vc5, close: true)
        }
        
        else if indexPath.row == 5
        {
            self.slideMenuController()?.changeMainViewController(vc6, close: true)
        }
        
        else if indexPath.row == 6
        {
            self.slideMenuController()?.changeMainViewController(vc7, close: true)
        }
        
        else if indexPath.row == 7
        {
            self.slideMenuController()?.changeMainViewController(vc8, close: true)
        }
        
        else
        {
            self.slideMenuController()?.changeMainViewController(vc9, close: true)
        }
    }
}
        

