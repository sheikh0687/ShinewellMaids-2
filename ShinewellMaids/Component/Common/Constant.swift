//
//  Constant.swift
//  ShinewellMaids
//
//  Created by Techimmense Software Solutions on 10/06/23.
//


import Foundation
import UIKit

struct k {
    
    static let appName                                      =      "ShinewellMaids"
    static var iosRegisterId                                =      "123456"
    static let emptyString                                  =      ""
    static let userDefault                                  =      UserDefaults.standard
    static let userType                                     =      "USER"
    static let type1                                        =      "TYPE1"
    static let type2                                        =      "TYPE2"
    static let type3                                        =      "TYPE3"
    static let employeType                                  =      "EMPLOYEE"
    static let currency                                     =      "AED"
    static let themeColor                                   =      ""
    static let navigationColor                              =      ""
    
    struct languages
    {
        struct english
        {
            
            static let urlTermsCondition                    =      ""
            static let urlForgotPassword                    =      "https://droponway.com/Account/ForgetPassword"
            static let urlHowItWork                         =      "https://droponway.com/Home/HowItWorks"
            static let urlPromotion                         =      "https://droponway.com/Home/Promotion"
            static let urlPricing                           =      "https://droponway.com/Home/Pricing"
            static let urlSecurityTip                       =      "https://droponway.com/Home/SafetyTips"
            static let urlFAQs                              =      "https://droponway.com/Home/Faq"
            static let urlAccountTips                       =      "https://droponway.com/Home/AccountHelp"
            static let urlContactUs                         =      "https://droponway.com/Home/Contact Us"
            static let urlNewVC                             =      "https://droponway.com/Home/Index?pagenumber=1"
            static let urlUserProfile                       =      "https://droponway.com/Account/Manage"
            static let urlUserWallet                        = "https://droponway.com/Home/Transactions?"
//            static let urlUserPastOrder                     =      "https://droponway.com/Home/Transactions?"
            static let urlGrabAvailableDelivery             =      "https://droponway.com/Home/Index?pagenumber=1&bidstatus=2&bidtype=2&embed=false"
            static let urlGrabWallet                        =      "https://droponway.com/Home/Transactions?"
            static let urlGrabProfile                       =      "https://droponway.com/Account/Manage"
        }
    }
    
    struct session {
        static let status                                   =      "status"
        static let userId                                   =      "user_id"
        static let userName                                 =      "user_name"
        static let userEmail                                =      "email"
        static let userType                                 =      "type"
        static let userReferal                              =      "referral_code"
        static let stripeCustomerId                         =      ""
        static let catShortCode                             =      ""
        static let onlineStatus                             =      ""
        static let categoryId                               =      "category_id"
        static let subCategoryId                            =      "sub_cat_id"
        static let userImage                                =      "user_image"
        static let interestedRestId                         =      "interested_rest_id"
        static let lat                                      =      "lat"
        static let lon                                      =      "lon"
        static let restaurantName                           =      ""
        static let userLogin                                =      ""
        
        static let areaName                                 =      "area"
        static let ads                                      =      ""
        static let gambling                                 =      ""
        static let malware                                  =      ""
        static let phishing                                 =      ""
        static let spyware                                  =      ""
        
        static let language                                 =      ""
        static let rejectCount                              =      ""
        static let currentCompanyId                         =      ""
    }
    
    
    struct google {
        static let googleApiKey                             =      ""
        static let googleClientId                           =      ""
    }
    
    struct facebook {
        static let facebookId                               =      ""
    }
    
    static var menuWidth: CGFloat                           =      0.0
    static var topMargin: CGFloat                           =      0.0
}
