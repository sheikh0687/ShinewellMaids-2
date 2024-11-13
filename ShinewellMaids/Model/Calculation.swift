//
//  Calculation.swift
//  ShinewellMaids
//
//  Created by Techimmense Software Solutions on 04/07/23.
//

import Foundation

struct ApiCalculation : Codable {
    
    let result : ResCalculation?
    let message : String?
    let status : String?

    enum CodingKeys: String, CodingKey {

        case result = "result"
        case message = "message"
        case status = "status"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        result = try values.decodeIfPresent(ResCalculation.self, forKey: .result)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        status = try values.decodeIfPresent(String.self, forKey: .status)
    }

}

struct ResCalculation : Codable {
    let hr_rate : String?
    let cleaning_material_hr_rate : String?
    let cleaning_material_price : String?
    let vAT : String?
    let service_amount : String?
    let vAT_amount : String?
    let total_amount : String?

    enum CodingKeys: String, CodingKey {

        case hr_rate = "hr_rate"
        case cleaning_material_hr_rate = "cleaning_material_hr_rate"
        case cleaning_material_price = "cleaning_material_price"
        case vAT = "VAT"
        case service_amount = "service_amount"
        case vAT_amount = "VAT_amount"
        case total_amount = "total_amount"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        hr_rate = try values.decodeIfPresent(String.self, forKey: .hr_rate)
        cleaning_material_hr_rate = try values.decodeIfPresent(String.self, forKey: .cleaning_material_hr_rate)
        cleaning_material_price = try values.decodeIfPresent(String.self, forKey: .cleaning_material_price)
        vAT = try values.decodeIfPresent(String.self, forKey: .vAT)
        service_amount = try values.decodeIfPresent(String.self, forKey: .service_amount)
        vAT_amount = try values.decodeIfPresent(String.self, forKey: .vAT_amount)
        total_amount = try values.decodeIfPresent(String.self, forKey: .total_amount)
    }

}
