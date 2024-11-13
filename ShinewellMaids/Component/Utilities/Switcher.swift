//
//  Switcher.swift
//  ShinewellMaids
//
//  Created by Techimmense Software Solutions on 24/06/23.
//

import Foundation
import UIKit
import SlideMenuControllerSwift

class Switcher {
    
    class func checkLogin() {
        
        let status = k.userDefault.bool(forKey: k.session.status)
        
        if status == true
        {
            let homeViewController = Kstoryboard.instantiateViewController(withIdentifier: "HomeVC") as! HomeVC
            let vc = UINavigationController(rootViewController: homeViewController)
            let SlideMenuViewController = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LeftMenuVC") as! LeftMenuVC
            
            let slideMenuController = SlideMenuController(mainViewController: vc, leftMenuViewController: SlideMenuViewController)
            kAppDelegate.window?.rootViewController = slideMenuController
            kAppDelegate.window?.makeKeyAndVisible()
        }
        else
        {
            let rootVC = Kstoryboard.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
            let nav = UINavigationController(rootViewController: rootVC)
            nav.isNavigationBarHidden = true
            kAppDelegate.window!.rootViewController = nav
            kAppDelegate.window?.makeKeyAndVisible()
        }
    }
}
