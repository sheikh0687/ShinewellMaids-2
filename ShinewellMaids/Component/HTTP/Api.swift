//
//  Api.swift
//  ShinewellMaids
//
//  Created by Techimmense Software Solutions on 26/06/23.
//

import Foundation

class Api: NSObject{
    
    static let shared = Api()
    
    func paramGetUserId() -> [String:AnyObject] {
        var dict : [String:AnyObject] = [:]
        dict["user_id"] = k.userDefault.string(forKey: k.session.userId) as AnyObject
        return dict
    }
    
    func login(_ vc: UIViewController, _ params: [String: AnyObject], _ success: @escaping(_ responseData : ResLogin) -> Void) {
        vc.showProgressBar()
        Service.post(url: Router.LogIn.url(), params: params, method: .get, vc: vc, successBlock: { (response) in
            do {
                let decoder = JSONDecoder()
                let root = try decoder.decode(GetLogIn.self, from: response)
                if root.status == "1" {
                    if let result = root.result {
                        success(result)
                        vc.hideProgressBar()
                    }
                } else {
                    vc.hideProgressBar()
                    k.userDefault.set(false, forKey: k.session.status)
                    k.userDefault.set(k.emptyString, forKey: k.session.userId)
                    k.userDefault.set(k.emptyString, forKey: k.session.userEmail)
                    k.userDefault.set(k.emptyString, forKey: k.session.userReferal)
                    vc.alert(alertmessage: root.message ?? "Something Went Wrong")
                }
            } catch {
                vc.hideProgressBar()
                print(error)
            }
            vc.hideProgressBar()
        }) { (error: Error) in
            vc.alert(alertmessage: error.localizedDescription)
            vc.hideProgressBar()
        }
    }
    
    func forgotPassword(_ vc: UIViewController, _ params: [String: AnyObject], _ success: @escaping(_ responseData : ApiBasic) -> Void) {
        vc.blockUi()
        Service.post(url: Router.ForgetPassword.url(), params: params, method: .get, vc: vc, successBlock: { (response) in
            do {
                let decoder = JSONDecoder()
                let root = try decoder.decode(ApiBasic.self, from: response)
                if root.result != nil {
                    success(root)
                }
            } catch {
                print(error)
            }
            vc.unBlockUi()
        }) { (error: Error) in
            vc.alert(alertmessage: error.localizedDescription)
            vc.unBlockUi()
        }
    }
    
    func signUpUser(_ vc: UIViewController, _ params: [String: AnyObject], _ success: @escaping(_ responseData : ResSignUp) -> Void) {
        vc.showProgressBar()
        Service.post(url: Router.SignUp.url(), params: params, method: .get, vc: vc, successBlock: { (response) in
            do {
                let decoder = JSONDecoder()
                let root = try decoder.decode(ApiSignUp.self, from: response)
                if root.status == "1" {
                    if let result = root.result {
                        success(result)
                        vc.hideProgressBar()
                    }
                } else {
                    vc.hideProgressBar()
                    k.userDefault.set(false, forKey: k.session.status)
                    k.userDefault.set(k.emptyString, forKey: k.session.userId)
                    k.userDefault.set(k.emptyString, forKey: k.session.userEmail)
                    k.userDefault.set(k.emptyString, forKey: k.session.userReferal)
                    vc.alert(alertmessage: root.message ?? "Something Went Wrong!")
                }
            } catch {
                print(error)
                vc.hideProgressBar()
            }
            vc.hideProgressBar()
        }) { (error: Error) in
            vc.alert(alertmessage: error.localizedDescription)
            vc.hideProgressBar()
        }
    }
    
    func socialLogin(_ vc: UIViewController, _ params: [String: String], images: [String : UIImage?]?, videos: [String : Data?]?, _ success: @escaping(_ responseData : ResLogin) -> Void) {
        vc.blockUi()
        Service.postSingleMedia(url: Router.socialLogin.url(), params: params, imageParam: images, videoParam: videos, parentViewController: vc, successBlock: { (response) in
            do {
                let decoder = JSONDecoder()
                let root = try decoder.decode(GetLogIn.self, from: response)
                if root.status == "1" {
                    if let result = root.result {
                        success(result)
                    }
                } else {
                    k.userDefault.set(false, forKey: k.session.status)
                    k.userDefault.set(k.emptyString, forKey: k.session.userId)
                    k.userDefault.set(k.emptyString, forKey: k.session.userEmail)
                    k.userDefault.set(k.emptyString, forKey: k.session.stripeCustomerId)
                    vc.alert(alertmessage: root.message ?? "Something Went Wrong!")
                }
            } catch {
                print(error)
            }
            vc.unBlockUi()
        }) { (error: Error) in
            vc.alert(alertmessage: error.localizedDescription)
            vc.unBlockUi()
        }
    }
    
    func getProfile(_ vc: UIViewController, _ success: @escaping(_ responseData : ResProfile) -> Void) {
        vc.blockUi()
        Service.post(url: Router.Profile.url(), params: self.paramGetUserId(), method: .get, vc: vc, successBlock: { (response) in
            do {
                let decoder = JSONDecoder()
                let root = try decoder.decode(GetProfile.self, from: response)
                if let result = root.result {
                    success(result)
                }
            } catch {
                vc.hideProgressBar()
                print(error)
            }
            vc.unBlockUi()
        }) { (error: Error) in
            vc.alert(alertmessage: error.localizedDescription)
            vc.unBlockUi()
        }
    }
    
    func updatedArea(_ vc: UIViewController, _ params: [String: String], images: [String : UIImage?]?, videos: [String : Data?]?, _ success: @escaping(_ responseData : ResUpdateArea) -> Void) {
        vc.showProgressBar()
        Service.postSingleMedia(url: Router.updateArea.url(), params: params, imageParam: images, videoParam: videos, parentViewController: vc, successBlock: { (response) in
            do {
                let decoder = JSONDecoder()
                let root = try decoder.decode(ApiUpdateArea.self, from: response)
                if root.status == "1" {
                    vc.hideProgressBar()
                    if let result = root.result {
                        success(result)
                    }
                } else {
                    vc.hideProgressBar()
                    k.userDefault.set(k.emptyString, forKey: k.session.areaName)
                    //                    vc.alert(alertmessage: root.message ?? R.string.localizable.somethingWentWrong())
                }
            } catch {
                vc.hideProgressBar()
                print(error)
            }
            vc.hideProgressBar()
        }) { (error: Error) in
            vc.alert(alertmessage: error.localizedDescription)
            vc.hideProgressBar()
        }
    }
   
    func updatedProfile(_ vc: UIViewController, _ params: [String: String], images: [String : UIImage?]?, videos: [String : Data?]?, _ success: @escaping(_ responseData : ResUpdateProfile) -> Void) {
        vc.showProgressBar()
        Service.postSingleMedia(url: Router.UpdateProfile.url(), params: params, imageParam: images, videoParam: videos, parentViewController: vc, successBlock: { (response) in
            do {
                let decoder = JSONDecoder()
                let root = try decoder.decode(UpdatedProfile.self, from: response)
                if root.status == "1" {
                    vc.hideProgressBar()
                    if let result = root.result {
                        success(result)
                    }
                } else {
                    vc.hideProgressBar()
                    //                    vc.alert(alertmessage: root.message ?? R.string.localizable.somethingWentWrong())
                }
            } catch {
                vc.hideProgressBar()
                print(error)
            }
            vc.hideProgressBar()
        }) { (error: Error) in
            vc.alert(alertmessage: error.localizedDescription)
            vc.hideProgressBar()
        }
    }
    
    func getNotification(_ vc: UIViewController, _ success: @escaping(_ responseData : [ResNotify]) -> Void) {
        vc.showProgressBar()
        Service.post(url: Router.Notification.url(), params: self.paramGetUserId(), method: .get, vc: vc, successBlock: { (response) in
            do {
                let decoder = JSONDecoder()
                let root = try decoder.decode(GetNotification.self, from: response)
                if let result = root.result {
                    success(result)
                    vc.hideProgressBar()
                }
            } catch {
                vc.hideProgressBar()
                print(error)
            }
            vc.hideProgressBar()
        }) { (error: Error) in
            vc.alert(alertmessage: error.localizedDescription)
            vc.hideProgressBar()
        }
    }
    
    func getAreaList(_ vc: UIViewController, _ success: @escaping(_ responseData : [ResAreaList]) -> Void) {
        vc.showProgressBar()
        Service.post(url: Router.ListOfArea.url(), params: self.paramGetUserId(), method: .get, vc: vc, successBlock: { (response) in
            do {
                let decoder = JSONDecoder()
                let root = try decoder.decode(GetAreaList.self, from: response)
                if let result = root.result {
                    success(result)
                    vc.hideProgressBar()
                }
            } catch {
                vc.hideProgressBar()
                print(error)
            }
            vc.hideProgressBar()
        }) { (error: Error) in
            vc.alert(alertmessage: error.localizedDescription)
            vc.hideProgressBar()
        }
    }
    
    func getOfferList(_ vc: UIViewController, _ success: @escaping(_ responseData : [ResOfferList]) -> Void) {
        vc.showProgressBar()
        Service.post(url: Router.ListofOffer.url(), params: self.paramGetUserId(), method: .get, vc: vc, successBlock: { (response) in
            do {
                let decoder = JSONDecoder()
                let root = try decoder.decode(GetOfferList.self, from: response)
                if let result = root.result {
                    success(result)
                    vc.hideProgressBar()
                }
            } catch {
                vc.hideProgressBar()
                print(error)
            }
            vc.hideProgressBar()
        }) { (error: Error) in
            vc.alert(alertmessage: error.localizedDescription)
            vc.hideProgressBar()
        }
    }
    
    func getExtraServiceList(_ vc: UIViewController, _ success: @escaping(_ responseData : [ResExtraService]) -> Void) {
        vc.showProgressBar()
        Service.post(url: Router.ListOfExtraService.url(), params: self.paramGetUserId(), method: .get, vc: vc, successBlock: { (response) in
            do {
                let decoder = JSONDecoder()
                let root = try decoder.decode(GetExtraService.self, from: response)
                if let result = root.result {
                    success(result)
                    vc.hideProgressBar()
                }
            } catch {
                vc.hideProgressBar()
                print(error)
            }
            vc.hideProgressBar()
        }) { (error: Error) in
            vc.alert(alertmessage: error.localizedDescription)
            vc.hideProgressBar()
        }
    }
    
    func getExtraCLeaningList(_ vc: UIViewController, _ success: @escaping(_ responseData : [ResExtraCleaning]) -> Void) {
        vc.showProgressBar()
        Service.post(url: Router.ListOfExtraCleaning.url(), params: self.paramGetUserId(), method: .get, vc: vc, successBlock: { (response) in
            do {
                let decoder = JSONDecoder()
                let root = try decoder.decode(GetExtraCleaning.self, from: response)
                if let result = root.result {
                    success(result)
                    vc.hideProgressBar()
                }
            } catch {
                vc.hideProgressBar()
                print(error)
            }
            vc.hideProgressBar()
        }) { (error: Error) in
            vc.alert(alertmessage: error.localizedDescription)
            vc.hideProgressBar()
        }
    }
    
    func getAddress(_ vc: UIViewController, _ success: @escaping(_ responseData : [ResAddress]) -> Void) {
        vc.showProgressBar()
        Service.post(url: Router.Address.url(), params: self.paramGetUserId(), method: .get, vc: vc, successBlock: { (response) in
            do {
                let decoder = JSONDecoder()
                let root = try decoder.decode(GetAddress.self, from: response)
                if let result = root.result {
                    success(result)
                    vc.hideProgressBar()
                }
            } catch {
                vc.hideProgressBar()
                print(error)
            }
            vc.hideProgressBar()
        }) { (error: Error) in
            vc.alert(alertmessage: error.localizedDescription)
            vc.hideProgressBar()
        }
    }
    
    func deleteAddress(_ vc: UIViewController, _ params: [String: AnyObject], _ success: @escaping(_ responseData : DeleteAddress) -> Void) {
        vc.showProgressBar()
        Service.post(url: Router.AddressDelete.url(), params: params, method: .get, vc: vc, successBlock: { (response) in
            do {
                let decoder = JSONDecoder()
                let root = try decoder.decode(DeleteAddress.self, from: response)
                if root.result != nil {
                    success(root)
                    vc.hideProgressBar()
                }
            } catch {
                print(error)
                vc.hideProgressBar()
            }
            vc.hideProgressBar()
        }) { (error: Error) in
            vc.alert(alertmessage: error.localizedDescription)
            vc.hideProgressBar()
        }
    }
    
    func addAddress(_ vc: UIViewController, _ params: [String: AnyObject], _ success: @escaping(_ responseData : ResAddAddress) -> Void) {
        vc.showProgressBar()
        Service.post(url: Router.AddAddress.url(), params: params, method: .get, vc: vc, successBlock: { (response) in
            do {
                let decoder = JSONDecoder()
                let root = try decoder.decode(AddAddress.self, from: response)
                if root.status == "1" {
                    if let result = root.result {
                        success(result)
                        vc.hideProgressBar()
                    }
                } else {
                    vc.alert(alertmessage: root.message ?? "Something Went Wrong!")
                    vc.hideProgressBar()
                }
            } catch {
                print(error)
                vc.hideProgressBar()
            }
            vc.hideProgressBar()
        }) { (error: Error) in
            vc.alert(alertmessage: error.localizedDescription)
            vc.hideProgressBar()
        }
    }
    
    func getBookingList(_ vc: UIViewController, _ success: @escaping(_ responseData : [ResBookingList]) -> Void) {
        vc.showProgressBar()
        Service.post(url: Router.BookingList.url(), params: self.paramGetUserId(), method: .get, vc: vc, successBlock: { (response) in
            do {
                let decoder = JSONDecoder()
                let root = try decoder.decode(ApiBookingList.self, from: response)
                if let result = root.result {
                    success(result)
                    vc.hideProgressBar()
                }
            } catch {
                vc.hideProgressBar()
                print(error)
            }
            vc.hideProgressBar()
        }) { (error: Error) in
            vc.alert(alertmessage: error.localizedDescription)
            vc.hideProgressBar()
        }
    }
    
    func getPendingBill(_ vc: UIViewController, _ success: @escaping(_ responseData : [ResPendingBill]) -> Void) {
        vc.showProgressBar()
        Service.post(url: Router.PendingBill.url(), params: self.paramGetUserId(), method: .get, vc: vc, successBlock: { (response) in
            do {
                let decoder = JSONDecoder()
                let root = try decoder.decode(ApiPendingBill.self, from: response)
                if let result = root.result {
                    success(result)
                    vc.hideProgressBar()
                }
            } catch {
                vc.hideProgressBar()
                print(error)
            }
            vc.hideProgressBar()
        }) { (error: Error) in
            vc.alert(alertmessage: error.localizedDescription)
            vc.hideProgressBar()
        }
    }
    
    func getBookingHistory(_ vc: UIViewController, _ success: @escaping(_ responseData : [ResBookingHistory]) -> Void) {
        vc.showProgressBar()
        Service.post(url: Router.BookingHistory.url(), params: self.paramGetUserId(), method: .get, vc: vc, successBlock: { (response) in
            do {
                let decoder = JSONDecoder()
                let root = try decoder.decode(ApiBookingHistory.self, from: response)
                if let result = root.result {
                    success(result)
                    vc.hideProgressBar()
                }
            } catch {
                vc.hideProgressBar()
                print(error)
            }
            vc.hideProgressBar()
        }) { (error: Error) in
            vc.alert(alertmessage: error.localizedDescription)
            vc.hideProgressBar()
        }
    }
    
    func changePassword(_ vc: UIViewController, _ params: [String: AnyObject], _ success: @escaping(_ responseData : ApiChangedPassword) -> Void) {
        vc.showProgressBar()
        Service.post(url: Router.UpdatedPassword.url(), params: params, method: .get, vc: vc, successBlock: { (response) in
            do {
                let decoder = JSONDecoder()
                let root = try decoder.decode(ApiChangedPassword.self, from: response)
                if root.result != nil {
                    success(root)
                    vc.hideProgressBar()
                }
            } catch {
                print(error)
                vc.hideProgressBar()
            }
            vc.hideProgressBar()
        }) { (error: Error) in
            vc.alert(alertmessage: error.localizedDescription)
            vc.hideProgressBar()
        }
    }
    
    func sendFeedback(_ vc: UIViewController, _ params: [String: AnyObject], _ success: @escaping(_ responseData : ResFeedback) -> Void) {
        vc.showProgressBar()
        Service.post(url: Router.AddFeedback.url(), params: params, method: .get, vc: vc, successBlock: { (response) in
            do {
                let decoder = JSONDecoder()
                let root = try decoder.decode(ApiAddFeedback.self, from: response)
                if root.status == "1" {
                    if let result = root.result {
                        success(result)
                        vc.hideProgressBar()
                    }
                } else {
                    vc.alert(alertmessage: root.message ?? "Something Went Wrong!")
                    vc.hideProgressBar()
                }
            } catch {
                print(error)
                vc.hideProgressBar()
            }
            vc.hideProgressBar()
        }) { (error: Error) in
            vc.alert(alertmessage: error.localizedDescription)
            vc.hideProgressBar()
        }
    }
    
    func convertPointWallet(_ vc: UIViewController, _ params: [String: AnyObject], _ success: @escaping(_ responseData : ConvertedPoints) -> Void) {
        vc.showProgressBar()
        Service.post(url: Router.ConvertPoint.url(), params: params, method: .get, vc: vc, successBlock: { (response) in
            do {
                let decoder = JSONDecoder()
                let root = try decoder.decode(ConvertedPoints.self, from: response)
                if root.result != nil {
                    success(root)
                    vc.hideProgressBar()
                }
            } catch {
                print(error)
                vc.hideProgressBar()
            }
            vc.hideProgressBar()
        }) { (error: Error) in
            vc.alert(alertmessage: error.localizedDescription)
            vc.hideProgressBar()
        }
    }
    
    func bookingDetails(_ vc: UIViewController, _ params: [String: AnyObject], _ success: @escaping(_ responseData : ResBookingDt) -> Void) {
        vc.showProgressBar()
        Service.post(url: Router.BookingDetail.url(), params: params, method: .get, vc: vc, successBlock: { (response) in
            do {
                let decoder = JSONDecoder()
                let root = try decoder.decode(ApiBookingDetail.self, from: response)
                if root.status == "1" {
                    if let result = root.result {
                        success(result)
                        vc.hideProgressBar()
                    }
                } else {
                    vc.alert(alertmessage: root.message ?? "Something Went Wrong!")
                    vc.hideProgressBar()
                }
            } catch {
                print(error)
                vc.hideProgressBar()
            }
            vc.hideProgressBar()
        }) { (error: Error) in
            vc.alert(alertmessage: error.localizedDescription)
            vc.hideProgressBar()
        }
    }
    
    func calucation(_ vc: UIViewController, _ params: [String: AnyObject], _ success: @escaping(_ responseData : ResCalculation) -> Void) {
        vc.showProgressBar()
        Service.post(url: Router.Calculate.url(), params: params, method: .get, vc: vc, successBlock: { (response) in
            do {
                let decoder = JSONDecoder()
                let root = try decoder.decode(ApiCalculation.self, from: response)
                if root.status == "1" {
                    if let result = root.result {
                        success(result)
                        vc.hideProgressBar()
                    }
                } else {
                    vc.alert(alertmessage: root.message ?? "Something Went Wrong!")
                    vc.hideProgressBar()
                }
            } catch {
                print(error)
                vc.hideProgressBar()
            }
            vc.hideProgressBar()
        }) { (error: Error) in
            vc.alert(alertmessage: error.localizedDescription)
            vc.hideProgressBar()
        }
    }
    
    func addBookings(_ vc: UIViewController, _ params: [String: AnyObject], _ success: @escaping(_ responseData : ResAddBooking) -> Void) {
        vc.showProgressBar()
        Service.post(url: Router.AddBookingAppointment.url(), params: params, method: .get, vc: vc, successBlock: { (response) in
            do {
                let decoder = JSONDecoder()
                let root = try decoder.decode(ApiAddBooking.self, from: response)
                if root.status == "1" {
                    if let result = root.result {
                        success(result)
                        vc.hideProgressBar()
                    }
                } else {
                    vc.alert(alertmessage: root.message ?? "Something Went Wrong!")
                    vc.hideProgressBar()
                }
            } catch {
                print(error)
                vc.hideProgressBar()
            }
            vc.hideProgressBar()
        }) { (error: Error) in
            vc.alert(alertmessage: error.localizedDescription)
            vc.hideProgressBar()
        }
    }
    
    func changeRequest(_ vc: UIViewController, _ params: [String: AnyObject], _ success: @escaping(_ responseData : ResChangeStatus) -> Void) {
        vc.showProgressBar()
        Service.post(url: Router.ChangeRequest.url(), params: params, method: .get, vc: vc, successBlock: { (response) in
            do {
                let decoder = JSONDecoder()
                let root = try decoder.decode(ApiChangeStatus.self, from: response)
                if root.status == "1" {
                    if let result = root.result {
                        success(result)
                        vc.hideProgressBar()
                    }
                } else {
                    vc.alert(alertmessage: root.message ?? "Something Went Wrong!")
                    vc.hideProgressBar()
                }
            } catch {
                print(error)
                vc.hideProgressBar()
            }
            vc.hideProgressBar()
        }) { (error: Error) in
            vc.alert(alertmessage: error.localizedDescription)
            vc.hideProgressBar()
        }
    }
    
    func stripePayment(_ vc: UIViewController, _ params: [String: AnyObject], _ success: @escaping(_ responseData : AnyObject) -> Void) {
        vc.blockUi()
        Service.callPostService(apiUrl: Router.StripePayment.url(), parameters: params, Method: .get, parentViewController: vc, successBlock: { (response, message) in
            success(response)
            vc.unBlockUi()
        }) { (error) in
            vc.alert(alertmessage: error.localizedDescription)
            vc.unBlockUi()
        }
    }
    
    func billPayment(_ vc: UIViewController, _ params: [String: AnyObject], _ success: @escaping(_ responseData : AnyObject) -> Void) {
        vc.blockUi()
        Service.callPostService(apiUrl: Router.BillPayment.url(), parameters: params, Method: .get, parentViewController: vc, successBlock: { (response, message) in
            success(response)
            vc.unBlockUi()
        }) { (error) in
            vc.alert(alertmessage: error.localizedDescription)
            vc.unBlockUi()
        }
    }
    
    func applyOffer(_ vc: UIViewController, _ params: [String: AnyObject], _ success: @escaping(_ responseData : ApiApplyCode) -> Void) {
        vc.showProgressBar()
        Service.post(url: Router.ApplyOffer.url(), params: params, method: .get, vc: vc, successBlock: { (response) in
            do {
                let decoder = JSONDecoder()
                let root = try decoder.decode(ApiApplyCode.self, from: response)
                if root.result != nil {
                    success(root)
                    vc.hideProgressBar()
                }
            } catch {
                print(error)
                vc.hideProgressBar()
            }
            vc.hideProgressBar()
        }) { (error: Error) in
            vc.alert(alertmessage: error.localizedDescription)
            vc.hideProgressBar()
        }
    }
    
    func getSetting(_ vc: UIViewController, _ success: @escaping(_ responseData : ResSetting) -> Void) {
        vc.showProgressBar()
        Service.post(url: Router.Setting.url(), params: self.paramGetUserId(), method: .get, vc: vc, successBlock: { (response) in
            do {
                let decoder = JSONDecoder()
                let root = try decoder.decode(ApiSetting.self, from: response)
                if let result = root.result {
                    success(result)
                    vc.hideProgressBar()
                }
            } catch {
                vc.hideProgressBar()
                print(error)
            }
            vc.hideProgressBar()
        }) { (error: Error) in
            vc.alert(alertmessage: error.localizedDescription)
            vc.hideProgressBar()
        }
    }
    
    func delete_Account(_ vc: UIViewController,_ success: @escaping(_ responseData : ApiBasic) -> Void) {
        vc.blockUi()
        Service.post(url: Router.deleteAccount.url(), params: paramGetUserId(), method: .get, vc: vc, successBlock: { (response) in
            do {
                let decoder = JSONDecoder()
                let root = try decoder.decode(ApiBasic.self, from: response)
                if root.result != nil {
                    success(root)
                }
            } catch {
                print(error)
            }
            vc.unBlockUi()
        }) { (error: Error) in
            vc.alert(alertmessage: error.localizedDescription)
            vc.unBlockUi()
        }
    }
}

