//
//  AppDelegate.swift
//  ShinewellMaids
//
//  Created by Techimmense Software Solutions on 10/06/23.
//

import UIKit
import SlideMenuControllerSwift
import CoreLocation
import Stripe
import IQKeyboardManagerSwift
import Firebase
import FirebaseMessaging
import GoogleSignIn

let Kstoryboard = UIStoryboard.init(name: "Main", bundle: nil)
let kAppDelegate = UIApplication.shared.delegate as! AppDelegate

@main
class AppDelegate: UIResponder, UIApplicationDelegate, MessagingDelegate {


    var window: UIWindow?
    var coordinate1 = CLLocation(latitude: 0.0, longitude: 0.0)
    var coordinate2 = CLLocation(latitude: 0.0, longitude: 0.0)
    var CURRENT_LAT = ""
    var CURRENT_LON = ""
    let notificationCenter = UNUserNotificationCenter.current()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        StripeAPI.defaultPublishableKey = "pk_live_51K2u2EC5FP1Ar3IFCI7yo9YmLDI1pxUNDRmV3wHUb9PwrFY7TwHRzGM2arOABIrRv1PxysRBcjtwAhNB2b4qVxDN00Bjik9fv8"

        
        GIDSignIn.sharedInstance().clientID = "968611051353-5mjpe6dvt79c3ie5dn4t7m37igiq37vc.apps.googleusercontent.com"
    
        GIDSignIn.sharedInstance().delegate = self
    
        GIDSignIn.sharedInstance().restorePreviousSignIn()
        
        
        if #available(iOS 15, *) {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.titleTextAttributes = [.foregroundColor: UIColor.black]
            appearance.backgroundColor = hexStringToUIColorApp(hex: "#D2F6F4")
            UINavigationBar.appearance().standardAppearance = appearance
            UINavigationBar.appearance().scrollEdgeAppearance = appearance
        }
        
        FirebaseApp.configure()
        Messaging.messaging().delegate = self
        notificationCenter.delegate = self
        self.configureNotification()
        Switcher.checkLogin()
        IQKeyboardManager.shared.enable = true
        
        return true
    }
    
    func hexStringToUIColorApp (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }

    // MARK: UISceneSession Lifecycle

    func applicationWillResignActive(_ application: UIApplication) {
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        UIApplication.shared.applicationIconBadgeNumber = 0
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
    }
    
    func application(_ app: UIApplication,
                     open url: URL,
                     options: [UIApplication.OpenURLOptionsKey : Any]) -> Bool {

         return GIDSignIn.sharedInstance().handle(url)
    }

    func configureNotification() {
        if #available(iOS 10.0, *) {
            let center = UNUserNotificationCenter.current()
            center.requestAuthorization(options:[.badge, .alert, .sound]){ (granted, error) in }
        }
        UIApplication.shared.registerUserNotificationSettings(UIUserNotificationSettings(types: [.badge, .sound, .alert], categories: nil))
        UIApplication.shared.registerForRemoteNotifications()
    }
    
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        Messaging.messaging().token { token, error in
            if let error = error {
                print("Error fetching FCM registration token: \(error)")
            } else if let token = token {
                print("FCM registration token: \(token)")
                k.iosRegisterId = token
                print(k.iosRegisterId)
            }
        }
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        let deviceTokenString = deviceToken.reduce("", {$0 + String(format: "%02X", $1)})
        k.iosRegisterId = deviceTokenString
        Messaging.messaging().apnsToken = deviceToken
    }
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("APNs registration failed: \(error)")
    }
    
    // MARK:-  Received Remote Notification
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        
        if let info = userInfo["aps"] as? Dictionary<String, AnyObject> {
            print(info)
        }
        completionHandler(UIBackgroundFetchResult.newData)
    }
}

extension AppDelegate: LocationManagerDelegate {
    
    func didEnterInCircularArea() {
        print("")
    }
    
    func didExitCircularArea() {
        print("")
    }
    
    
    func tracingLocation(currentLocation: CLLocation) {
        coordinate2 = currentLocation
        print(coordinate2)
        let distanceInMeters = coordinate1.distance(from: coordinate2) // result is in meters
        if distanceInMeters > 250 {
            CURRENT_LAT = String(currentLocation.coordinate.latitude)
            CURRENT_LON = String(currentLocation.coordinate.longitude)
            coordinate1 = currentLocation
            if let _ = UserDefaults.standard.value(forKey: "user_id") {
                //self.updateLatLon()
            }
        }
    }
    
    func tracingLocationDidFailWithError(error: NSError) {
        print("tracing Location Error : \(error.description)")
    }
}

extension AppDelegate: UNUserNotificationCenterDelegate {
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert, .badge, .sound])
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        print("Click detected")
        print(response)
        print(response.notification.request.content.userInfo)
        let userInfo = response.notification.request.content.userInfo
        //        self.redirectNotification(userInfo)
        completionHandler()
    }
    
    func showNotification(_ heading: String, _ message: String) {
        let content = UNMutableNotificationContent()
        content.title = NSString.localizedUserNotificationString(forKey: heading, arguments: nil)
        content.body = NSString.localizedUserNotificationString(forKey: message, arguments: nil)
        content.sound = UNNotificationSound.default
        content.categoryIdentifier = "New Offer Added"
        let trigger = UNTimeIntervalNotificationTrigger.init(timeInterval: 1, repeats: false)
        let request = UNNotificationRequest.init(identifier: "notify-test", content: content, trigger: trigger)
        kAppDelegate.notificationCenter.add(request) { (errorr) in}
    }
    
    //    func redirectNotification(_ userInfo: Dictionary<AnyHashable, Any>) {
    //        if let info = userInfo["aps"] as? Dictionary<String, AnyObject> {
    //            let status = userInfo["gcm.notification.ios_status"] as? String
    //            print("Status Notification: ",status)
    //
    //            if status == "Request Accept" {
    //                if UIApplication.topViewController() != nil {
    //                    DispatchQueue.main.async {
    //                        self.handleRequestAccept()
    //                    }
    //                }
    //            } else if status == "You have a new message" {
    //                if UIApplication.topViewController() != nil {
    //                    DispatchQueue.main.async {
    //                        let receiverId = userInfo["gcm.notification.receiver_id"] as? String ?? ""
    //                        let userName = userInfo["gcm.notification.user_name"] as? String ?? ""
    //                        let requestId = userInfo["gcm.notification.request_id"] as? String ?? ""
    //
    //                        print(receiverId)
    //                        print(userName)
    //                        print(requestId)
    //                        self.handleChat(receiverId, userName, requestId)
    //                    }
    //                }
    //            } else {
    ////                if let rootViewController = UIApplication.topViewController() {
    ////                    let alertMsg = info["alert"]?["title"] as? String ?? ""
    ////                    Utility.showAlertMessage(withTitle: k.appName, message: alertMsg, delegate: nil, parentViewController: rootViewController)
    ////                }
    //                Switcher.updateRootVC()
    //            }
    //        }
    //    }
    //
    //    func handleRequestAccept() {
    //        let rootVC = R.storyboard.main().instantiateViewController(withIdentifier: "EmpOrderMainVC") as! EmpOrderMainVC
    //        let nav = UINavigationController(rootViewController: rootVC)
    //        nav.isNavigationBarHidden = false
    //        rootVC.isFromNotification = true
    //        kAppDelegate.window!.rootViewController = nav
    //        kAppDelegate.window?.makeKeyAndVisible()
    //    }
    //
    //    func handleChat(_ receiverId: String, _ userName: String, _ requestId: String) {
    //        let rootVC = R.storyboard.main().instantiateViewController(withIdentifier: "UserChatVC") as! UserChatVC
    //        let nav = UINavigationController(rootViewController: rootVC)
    //        nav.isNavigationBarHidden = false
    //        rootVC.isFromNotification = true
    //        rootVC.receiverId = receiverId
    //        rootVC.userName = userName
    //        rootVC.requestId = requestId
    //        kAppDelegate.window!.rootViewController = nav
    //        kAppDelegate.window?.makeKeyAndVisible()
    //    }
}

extension AppDelegate: GIDSignInDelegate {
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        
        // Check for sign in error
        if let error = error {
            if (error as NSError).code == GIDSignInErrorCode.hasNoAuthInKeychain.rawValue {
                print("The user has not signed in before or they have since signed out.")
            } else {
                print("\(error.localizedDescription)")
            }
            return
        }

        // Post notification after user successfully sign in
        NotificationCenter.default.post(name: .signInGoogleCompleted, object: nil)
    }
}

// MARK:- Notification names
extension Notification.Name {
    
    /// Notification when user successfully sign in using Google
    static var signInGoogleCompleted: Notification.Name {
        return .init(rawValue: #function)
    }
}
