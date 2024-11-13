//
//  BookingDetail.swift
//  ShinewellMaids
//
//  Created by Techimmense Software Solutions on 04/07/23.
//

import Foundation

struct ApiBookingDetail : Codable {
    
    let result : ResBookingDt?
    let message : String?
    let status : String?

    enum CodingKeys: String, CodingKey {

        case result = "result"
        case message = "message"
        case status = "status"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        result = try values.decodeIfPresent(ResBookingDt.self, forKey: .result)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        status = try values.decodeIfPresent(String.self, forKey: .status)
    }

}

struct ResBookingDt : Codable {
    let id : String?
    let user_id : String?
    let provider_id : String?
    let accept_provider_id : String?
    let cart_id : String?
    let total_amount : String?
    let provider_amount : String?
    let admin_commission : String?
    let admin_VAT : String?
    let discount : String?
    let wallet_used_amount : String?
    let card_amount : String?
    let date : String?
    let time : String?
    let how_offen_want_service : String?
    let how_many_hours : String?
    let how_many_cleaners : String?
    let need_any_cleaning_material : String?
    let additional_service : String?
    let cleaning_material_name : String?
    let cleaning_material_id : String?
    let cleaning_material_price : String?
    let additional_service_name : String?
    let additional_service_price : String?
    let additional_service_time : String?
    let additional_service_id : String?
    let how_cleaner_enter : String?
    let cleaning_instruction : String?
    let hr_rate : String?
    let vAT : String?
    let service_amount : String?
    let vAT_amount : String?
    let cleaning_material_amount : String?
    let extra_service_amount : String?
    let accept_one_hr : String?
    let time1 : String?
    let address : String?
    let lat : String?
    let lon : String?
    let address_id : String?
    let offer_id : String?
    let offer_code : String?
    let offer_percentage : String?
    let unique_code : String?
    let description : String?
    let time_slot : String?
    let required_hour : String?
    let required_worker : String?
    let payment_type : String?
    let payment_status : String?
    let emp_id : String?
    let emp_name : String?
    let emp_image : String?
    let emp_gender : String?
    let status : String?
    let date_time : String?
    let date_time_last : String?
    let date_time_two_hr : String?
    let timezone : String?
    let request_type : String?
    let reason_title : String?
    let reason_detail : String?
    let extra_service_name : String?
    let extra_service_price : String?
    let extra_service_payment_type : String?
    let extra_service_id : String?
    let payment_confirmation : String?
    let day_name : String?
    let address_details : Booked_Address_details?
    let user_details : Booked_User_details?
    let rating_review_status : String?
    let format_date : String?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case user_id = "user_id"
        case provider_id = "provider_id"
        case accept_provider_id = "accept_provider_id"
        case cart_id = "cart_id"
        case total_amount = "total_amount"
        case provider_amount = "provider_amount"
        case admin_commission = "admin_commission"
        case admin_VAT = "admin_VAT"
        case discount = "discount"
        case wallet_used_amount = "wallet_used_amount"
        case card_amount = "card_amount"
        case date = "date"
        case time = "time"
        case how_offen_want_service = "how_offen_want_service"
        case how_many_hours = "how_many_hours"
        case how_many_cleaners = "how_many_cleaners"
        case need_any_cleaning_material = "need_any_cleaning_material"
        case additional_service = "additional_service"
        case cleaning_material_name = "cleaning_material_name"
        case cleaning_material_id = "cleaning_material_id"
        case cleaning_material_price = "cleaning_material_price"
        case additional_service_name = "additional_service_name"
        case additional_service_price = "additional_service_price"
        case additional_service_time = "additional_service_time"
        case additional_service_id = "additional_service_id"
        case how_cleaner_enter = "how_cleaner_enter"
        case cleaning_instruction = "cleaning_instruction"
        case hr_rate = "hr_rate"
        case vAT = "VAT"
        case service_amount = "service_amount"
        case vAT_amount = "VAT_amount"
        case cleaning_material_amount = "cleaning_material_amount"
        case extra_service_amount = "extra_service_amount"
        case accept_one_hr = "accept_one_hr"
        case time1 = "time1"
        case address = "address"
        case lat = "lat"
        case lon = "lon"
        case address_id = "address_id"
        case offer_id = "offer_id"
        case offer_code = "offer_code"
        case offer_percentage = "offer_percentage"
        case unique_code = "unique_code"
        case description = "description"
        case time_slot = "time_slot"
        case required_hour = "required_hour"
        case required_worker = "required_worker"
        case payment_type = "payment_type"
        case payment_status = "payment_status"
        case emp_id = "emp_id"
        case emp_name = "emp_name"
        case emp_image = "emp_image"
        case emp_gender = "emp_gender"
        case status = "status"
        case date_time = "date_time"
        case date_time_last = "date_time_last"
        case date_time_two_hr = "date_time_two_hr"
        case timezone = "timezone"
        case request_type = "request_type"
        case reason_title = "reason_title"
        case reason_detail = "reason_detail"
        case extra_service_name = "extra_service_name"
        case extra_service_price = "extra_service_price"
        case extra_service_payment_type = "extra_service_payment_type"
        case extra_service_id = "extra_service_id"
        case payment_confirmation = "payment_confirmation"
        case day_name = "day_name"
        case address_details = "address_details"
        case user_details = "user_details"
        case rating_review_status = "rating_review_status"
        case format_date = "format_date"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        user_id = try values.decodeIfPresent(String.self, forKey: .user_id)
        provider_id = try values.decodeIfPresent(String.self, forKey: .provider_id)
        accept_provider_id = try values.decodeIfPresent(String.self, forKey: .accept_provider_id)
        cart_id = try values.decodeIfPresent(String.self, forKey: .cart_id)
        total_amount = try values.decodeIfPresent(String.self, forKey: .total_amount)
        provider_amount = try values.decodeIfPresent(String.self, forKey: .provider_amount)
        admin_commission = try values.decodeIfPresent(String.self, forKey: .admin_commission)
        admin_VAT = try values.decodeIfPresent(String.self, forKey: .admin_VAT)
        discount = try values.decodeIfPresent(String.self, forKey: .discount)
        wallet_used_amount = try values.decodeIfPresent(String.self, forKey: .wallet_used_amount)
        card_amount = try values.decodeIfPresent(String.self, forKey: .card_amount)
        date = try values.decodeIfPresent(String.self, forKey: .date)
        time = try values.decodeIfPresent(String.self, forKey: .time)
        how_offen_want_service = try values.decodeIfPresent(String.self, forKey: .how_offen_want_service)
        how_many_hours = try values.decodeIfPresent(String.self, forKey: .how_many_hours)
        how_many_cleaners = try values.decodeIfPresent(String.self, forKey: .how_many_cleaners)
        need_any_cleaning_material = try values.decodeIfPresent(String.self, forKey: .need_any_cleaning_material)
        additional_service = try values.decodeIfPresent(String.self, forKey: .additional_service)
        cleaning_material_name = try values.decodeIfPresent(String.self, forKey: .cleaning_material_name)
        cleaning_material_id = try values.decodeIfPresent(String.self, forKey: .cleaning_material_id)
        cleaning_material_price = try values.decodeIfPresent(String.self, forKey: .cleaning_material_price)
        additional_service_name = try values.decodeIfPresent(String.self, forKey: .additional_service_name)
        additional_service_price = try values.decodeIfPresent(String.self, forKey: .additional_service_price)
        additional_service_time = try values.decodeIfPresent(String.self, forKey: .additional_service_time)
        additional_service_id = try values.decodeIfPresent(String.self, forKey: .additional_service_id)
        how_cleaner_enter = try values.decodeIfPresent(String.self, forKey: .how_cleaner_enter)
        cleaning_instruction = try values.decodeIfPresent(String.self, forKey: .cleaning_instruction)
        hr_rate = try values.decodeIfPresent(String.self, forKey: .hr_rate)
        vAT = try values.decodeIfPresent(String.self, forKey: .vAT)
        service_amount = try values.decodeIfPresent(String.self, forKey: .service_amount)
        vAT_amount = try values.decodeIfPresent(String.self, forKey: .vAT_amount)
        cleaning_material_amount = try values.decodeIfPresent(String.self, forKey: .cleaning_material_amount)
        extra_service_amount = try values.decodeIfPresent(String.self, forKey: .extra_service_amount)
        accept_one_hr = try values.decodeIfPresent(String.self, forKey: .accept_one_hr)
        time1 = try values.decodeIfPresent(String.self, forKey: .time1)
        address = try values.decodeIfPresent(String.self, forKey: .address)
        lat = try values.decodeIfPresent(String.self, forKey: .lat)
        lon = try values.decodeIfPresent(String.self, forKey: .lon)
        address_id = try values.decodeIfPresent(String.self, forKey: .address_id)
        offer_id = try values.decodeIfPresent(String.self, forKey: .offer_id)
        offer_code = try values.decodeIfPresent(String.self, forKey: .offer_code)
        offer_percentage = try values.decodeIfPresent(String.self, forKey: .offer_percentage)
        unique_code = try values.decodeIfPresent(String.self, forKey: .unique_code)
        description = try values.decodeIfPresent(String.self, forKey: .description)
        time_slot = try values.decodeIfPresent(String.self, forKey: .time_slot)
        required_hour = try values.decodeIfPresent(String.self, forKey: .required_hour)
        required_worker = try values.decodeIfPresent(String.self, forKey: .required_worker)
        payment_type = try values.decodeIfPresent(String.self, forKey: .payment_type)
        payment_status = try values.decodeIfPresent(String.self, forKey: .payment_status)
        emp_id = try values.decodeIfPresent(String.self, forKey: .emp_id)
        emp_name = try values.decodeIfPresent(String.self, forKey: .emp_name)
        emp_image = try values.decodeIfPresent(String.self, forKey: .emp_image)
        emp_gender = try values.decodeIfPresent(String.self, forKey: .emp_gender)
        status = try values.decodeIfPresent(String.self, forKey: .status)
        date_time = try values.decodeIfPresent(String.self, forKey: .date_time)
        date_time_last = try values.decodeIfPresent(String.self, forKey: .date_time_last)
        date_time_two_hr = try values.decodeIfPresent(String.self, forKey: .date_time_two_hr)
        timezone = try values.decodeIfPresent(String.self, forKey: .timezone)
        request_type = try values.decodeIfPresent(String.self, forKey: .request_type)
        reason_title = try values.decodeIfPresent(String.self, forKey: .reason_title)
        reason_detail = try values.decodeIfPresent(String.self, forKey: .reason_detail)
        extra_service_name = try values.decodeIfPresent(String.self, forKey: .extra_service_name)
        extra_service_price = try values.decodeIfPresent(String.self, forKey: .extra_service_price)
        extra_service_payment_type = try values.decodeIfPresent(String.self, forKey: .extra_service_payment_type)
        extra_service_id = try values.decodeIfPresent(String.self, forKey: .extra_service_id)
        payment_confirmation = try values.decodeIfPresent(String.self, forKey: .payment_confirmation)
        day_name = try values.decodeIfPresent(String.self, forKey: .day_name)
        address_details = try values.decodeIfPresent(Booked_Address_details.self, forKey: .address_details)
        user_details = try values.decodeIfPresent(Booked_User_details.self, forKey: .user_details)
        rating_review_status = try values.decodeIfPresent(String.self, forKey: .rating_review_status)
        format_date = try values.decodeIfPresent(String.self, forKey: .format_date)
    }
}

struct Booked_User_details : Codable {
    let id : String?
    let store_id : String?
    let first_name : String?
    let last_name : String?
    let store_name : String?
    let mobile : String?
    let mobile_with_code : String?
    let email : String?
    let password : String?
    let country_id : String?
    let state_id : String?
    let state_name : String?
    let city_id : String?
    let city_name : String?
    let image : String?
    let type : String?
    let social_id : String?
    let lat : String?
    let lon : String?
    let address : String?
    let addresstype : String?
    let address_id : String?
    let gender : String?
    let gender_type : String?
    let wallet : String?
    let earn_points : String?
    let referal_points : String?
    let booking_points : String?
    let referral_code : String?
    let signup_referral_code : String?
    let licence_image : String?
    let licence_id : String?
    let licence_issue_date : String?
    let licence_expire_date : String?
    let register_id : String?
    let ios_register_id : String?
    let status : String?
    let approve_status : String?
    let available_status : String?
    let code : String?
    let date_time : String?
    let cat_id : String?
    let cat_name : String?
    let bank_name : String?
    let branch_name : String?
    let iban_id : String?
    let account_number : String?
    let bank_emirates : String?
    let owner_name : String?
    let tax_number : String?
    let store_logo : String?
    let store_cover_image : String?
    let about_store : String?
    let outdoor_service : String?
    let indoor_service : String?
    let note : String?
    let note_block : String?
    let block_unblock : String?
    let remove_status : String?
    let open_time : String?
    let close_time : String?
    let store_ope_closs_status : String?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case store_id = "store_id"
        case first_name = "first_name"
        case last_name = "last_name"
        case store_name = "store_name"
        case mobile = "mobile"
        case mobile_with_code = "mobile_with_code"
        case email = "email"
        case password = "password"
        case country_id = "country_id"
        case state_id = "state_id"
        case state_name = "state_name"
        case city_id = "city_id"
        case city_name = "city_name"
        case image = "image"
        case type = "type"
        case social_id = "social_id"
        case lat = "lat"
        case lon = "lon"
        case address = "address"
        case addresstype = "addresstype"
        case address_id = "address_id"
        case gender = "gender"
        case gender_type = "gender_type"
        case wallet = "wallet"
        case earn_points = "earn_points"
        case referal_points = "referal_points"
        case booking_points = "booking_points"
        case referral_code = "referral_code"
        case signup_referral_code = "signup_referral_code"
        case licence_image = "licence_image"
        case licence_id = "licence_id"
        case licence_issue_date = "licence_issue_date"
        case licence_expire_date = "licence_expire_date"
        case register_id = "register_id"
        case ios_register_id = "ios_register_id"
        case status = "status"
        case approve_status = "approve_status"
        case available_status = "available_status"
        case code = "code"
        case date_time = "date_time"
        case cat_id = "cat_id"
        case cat_name = "cat_name"
        case bank_name = "bank_name"
        case branch_name = "branch_name"
        case iban_id = "Iban_id"
        case account_number = "account_number"
        case bank_emirates = "bank_emirates"
        case owner_name = "owner_name"
        case tax_number = "tax_number"
        case store_logo = "store_logo"
        case store_cover_image = "store_cover_image"
        case about_store = "about_store"
        case outdoor_service = "outdoor_service"
        case indoor_service = "indoor_service"
        case note = "note"
        case note_block = "note_block"
        case block_unblock = "block_unblock"
        case remove_status = "remove_status"
        case open_time = "open_time"
        case close_time = "close_time"
        case store_ope_closs_status = "store_ope_closs_status"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        store_id = try values.decodeIfPresent(String.self, forKey: .store_id)
        first_name = try values.decodeIfPresent(String.self, forKey: .first_name)
        last_name = try values.decodeIfPresent(String.self, forKey: .last_name)
        store_name = try values.decodeIfPresent(String.self, forKey: .store_name)
        mobile = try values.decodeIfPresent(String.self, forKey: .mobile)
        mobile_with_code = try values.decodeIfPresent(String.self, forKey: .mobile_with_code)
        email = try values.decodeIfPresent(String.self, forKey: .email)
        password = try values.decodeIfPresent(String.self, forKey: .password)
        country_id = try values.decodeIfPresent(String.self, forKey: .country_id)
        state_id = try values.decodeIfPresent(String.self, forKey: .state_id)
        state_name = try values.decodeIfPresent(String.self, forKey: .state_name)
        city_id = try values.decodeIfPresent(String.self, forKey: .city_id)
        city_name = try values.decodeIfPresent(String.self, forKey: .city_name)
        image = try values.decodeIfPresent(String.self, forKey: .image)
        type = try values.decodeIfPresent(String.self, forKey: .type)
        social_id = try values.decodeIfPresent(String.self, forKey: .social_id)
        lat = try values.decodeIfPresent(String.self, forKey: .lat)
        lon = try values.decodeIfPresent(String.self, forKey: .lon)
        address = try values.decodeIfPresent(String.self, forKey: .address)
        addresstype = try values.decodeIfPresent(String.self, forKey: .addresstype)
        address_id = try values.decodeIfPresent(String.self, forKey: .address_id)
        gender = try values.decodeIfPresent(String.self, forKey: .gender)
        gender_type = try values.decodeIfPresent(String.self, forKey: .gender_type)
        wallet = try values.decodeIfPresent(String.self, forKey: .wallet)
        earn_points = try values.decodeIfPresent(String.self, forKey: .earn_points)
        referal_points = try values.decodeIfPresent(String.self, forKey: .referal_points)
        booking_points = try values.decodeIfPresent(String.self, forKey: .booking_points)
        referral_code = try values.decodeIfPresent(String.self, forKey: .referral_code)
        signup_referral_code = try values.decodeIfPresent(String.self, forKey: .signup_referral_code)
        licence_image = try values.decodeIfPresent(String.self, forKey: .licence_image)
        licence_id = try values.decodeIfPresent(String.self, forKey: .licence_id)
        licence_issue_date = try values.decodeIfPresent(String.self, forKey: .licence_issue_date)
        licence_expire_date = try values.decodeIfPresent(String.self, forKey: .licence_expire_date)
        register_id = try values.decodeIfPresent(String.self, forKey: .register_id)
        ios_register_id = try values.decodeIfPresent(String.self, forKey: .ios_register_id)
        status = try values.decodeIfPresent(String.self, forKey: .status)
        approve_status = try values.decodeIfPresent(String.self, forKey: .approve_status)
        available_status = try values.decodeIfPresent(String.self, forKey: .available_status)
        code = try values.decodeIfPresent(String.self, forKey: .code)
        date_time = try values.decodeIfPresent(String.self, forKey: .date_time)
        cat_id = try values.decodeIfPresent(String.self, forKey: .cat_id)
        cat_name = try values.decodeIfPresent(String.self, forKey: .cat_name)
        bank_name = try values.decodeIfPresent(String.self, forKey: .bank_name)
        branch_name = try values.decodeIfPresent(String.self, forKey: .branch_name)
        iban_id = try values.decodeIfPresent(String.self, forKey: .iban_id)
        account_number = try values.decodeIfPresent(String.self, forKey: .account_number)
        bank_emirates = try values.decodeIfPresent(String.self, forKey: .bank_emirates)
        owner_name = try values.decodeIfPresent(String.self, forKey: .owner_name)
        tax_number = try values.decodeIfPresent(String.self, forKey: .tax_number)
        store_logo = try values.decodeIfPresent(String.self, forKey: .store_logo)
        store_cover_image = try values.decodeIfPresent(String.self, forKey: .store_cover_image)
        about_store = try values.decodeIfPresent(String.self, forKey: .about_store)
        outdoor_service = try values.decodeIfPresent(String.self, forKey: .outdoor_service)
        indoor_service = try values.decodeIfPresent(String.self, forKey: .indoor_service)
        note = try values.decodeIfPresent(String.self, forKey: .note)
        note_block = try values.decodeIfPresent(String.self, forKey: .note_block)
        block_unblock = try values.decodeIfPresent(String.self, forKey: .block_unblock)
        remove_status = try values.decodeIfPresent(String.self, forKey: .remove_status)
        open_time = try values.decodeIfPresent(String.self, forKey: .open_time)
        close_time = try values.decodeIfPresent(String.self, forKey: .close_time)
        store_ope_closs_status = try values.decodeIfPresent(String.self, forKey: .store_ope_closs_status)
    }

}

struct Booked_Address_details : Codable {
    let id : String?
    let user_id : String?
    let address : String?
    let lat : String?
    let lon : String?
    let area_id : String?
    let area_name : String?
    let villa : String?
    let appartment : String?
    let street : String?
    let landmark : String?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case user_id = "user_id"
        case address = "address"
        case lat = "lat"
        case lon = "lon"
        case area_id = "area_id"
        case area_name = "area_name"
        case villa = "villa"
        case appartment = "appartment"
        case street = "street"
        case landmark = "landmark"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        user_id = try values.decodeIfPresent(String.self, forKey: .user_id)
        address = try values.decodeIfPresent(String.self, forKey: .address)
        lat = try values.decodeIfPresent(String.self, forKey: .lat)
        lon = try values.decodeIfPresent(String.self, forKey: .lon)
        area_id = try values.decodeIfPresent(String.self, forKey: .area_id)
        area_name = try values.decodeIfPresent(String.self, forKey: .area_name)
        villa = try values.decodeIfPresent(String.self, forKey: .villa)
        appartment = try values.decodeIfPresent(String.self, forKey: .appartment)
        street = try values.decodeIfPresent(String.self, forKey: .street)
        landmark = try values.decodeIfPresent(String.self, forKey: .landmark)
    }

}
