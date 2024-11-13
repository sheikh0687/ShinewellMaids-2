//
//  BookingHistory.swift
//  ShinewellMaids
//
//  Created by Techimmense Software Solutions on 28/06/23.
//

import Foundation

struct ApiBookingHistory : Codable {
    let result : [ResBookingHistory]?
    let message : String?
    let status : String?

    enum CodingKeys: String, CodingKey {

        case result = "result"
        case message = "message"
        case status = "status"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        result = try values.decodeIfPresent([ResBookingHistory].self, forKey: .result)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        status = try values.decodeIfPresent(String.self, forKey: .status)
    }
}

struct ResBookingHistory : Codable {
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
    let address_details : Booking_Address_details?
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
        address_details = try values.decodeIfPresent(Booking_Address_details.self, forKey: .address_details)
        format_date = try values.decodeIfPresent(String.self, forKey: .format_date)
    }

}

struct Booking_Address_details : Codable {
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
