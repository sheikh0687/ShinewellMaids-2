//
//  Router.swift
//  ShinewellMaids
//
//  Created by Techimmense Software Solutions on 26/06/23.
//

import Foundation

enum Router: String {
    
    static let BASE_SERVICE_URL = "https://techimmense.in/ShinewellMaids/webservice/"
    static let BASE_IMAGE_URL = "https://techimmense.in/ShinewellMaids/Upload/image"
    static let BASE_URL_POSTCODE = ""
    
    case LogIn
    case ForgetPassword
    case SignUp
    case socialLogin
    
    case Profile
    case UpdateProfile
    case updateArea
    
    case Notification
    case ListOfArea
    case ListofOffer
    case ListOfExtraService
    case ListOfExtraCleaning
    case Address
    case BookingList
    case PendingBill
    case BookingHistory
    case BookingDetail
    
    case AddressDelete
    case UpdatedPassword
    case ChangeRequest
    
    case AddAddress
    case AddFeedback
    case AddBookingAppointment
    
    case ConvertPoint
    case Calculate
    case Setting
    
    case StripePayment
    case BillPayment
    
    case ApplyOffer
    
    case deleteAccount
    
    public func url() -> String {
        switch self {
        case .LogIn:
            return Router.oAuthRoute(path: "login")
        case .ForgetPassword:
            return Router.oAuthRoute(path: "forgot_password")
        case .SignUp:
            return Router.oAuthRoute(path: "signup")
        case .Profile:
            return Router.oAuthRoute(path: "get_profile")
        case .UpdateProfile:
            return Router.oAuthRoute(path: "update_profile")
        case .Notification:
            return Router.oAuthRoute(path: "get_notification_list")
        case .ListOfArea:
            return Router.oAuthRoute(path: "get_area_list")
        case .ListofOffer:
            return Router.oAuthRoute(path: "offer_list")
        case .ListOfExtraService:
            return Router.oAuthRoute(path: "get_service_extra_list")
        case .ListOfExtraCleaning:
            return Router.oAuthRoute(path: "get_cleaning_material_list")
        case .Address:
            return Router.oAuthRoute(path: "get_user_address")
        case .AddressDelete:
            return Router.oAuthRoute(path: "delete_user_address")
        case .AddAddress:
            return Router.oAuthRoute(path: "add_user_address")
        case .BookingList:
            return Router.oAuthRoute(path: "get_user_book_appointment_list")
        case .PendingBill:
            return Router.oAuthRoute(path: "get_user_bill")
        case .BookingHistory:
            return Router.oAuthRoute(path: "get_user_book_appointment_history_list")
        case .UpdatedPassword:
            return Router.oAuthRoute(path: "change_password")
        case .AddFeedback:
            return Router.oAuthRoute(path: "send_feedback")
        case .ConvertPoint:
            return Router.oAuthRoute(path: "convered_points_wallet")
        case .BookingDetail:
            return Router.oAuthRoute(path: "get_request_details")
        case .Calculate:
            return Router.oAuthRoute(path: "calculation")
        case .AddBookingAppointment:
            return Router.oAuthRoute(path: "add_book_appointment")
        case.ChangeRequest:
            return Router.oAuthRoute(path: "change_request_status")
        case.StripePayment:
            return Router.oAuthRoute(path: "add_payment")
        case .BillPayment:
            return Router.oAuthRoute(path: "add_user_bill_payment")
        case .ApplyOffer:
            return Router.oAuthRoute(path: "apply_offer")
        case .Setting:
            return Router.oAuthRoute(path: "get_setting")
        case .socialLogin:
            return Router.oAuthRoute(path: "social_login")
        case .updateArea:
            return Router.oAuthRoute(path: "update_area")
        case .deleteAccount:
            return Router.oAuthRoute(path: "delete_account")
        }
    }
    
    private static func oAuthRoute(path: String) -> String {
        return Router.BASE_SERVICE_URL + path
    }
}

