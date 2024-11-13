//
//  PendingBill.swift
//  ShinewellMaids
//
//  Created by Techimmense Software Solutions on 28/06/23.
//

import Foundation

struct ApiPendingBill : Codable {
    let result : [ResPendingBill]?
    let message : String?
    let status : String?

    enum CodingKeys: String, CodingKey {

        case result = "result"
        case message = "message"
        case status = "status"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        result = try values.decodeIfPresent([ResPendingBill].self, forKey: .result)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        status = try values.decodeIfPresent(String.self, forKey: .status)
    }
}

struct ResPendingBill : Codable {
    let id : String?
    let user_id : String?
    let total_amount : String?
    let description : String?
    let status : String?
    let date_time : String?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case user_id = "user_id"
        case total_amount = "total_amount"
        case description = "description"
        case status = "status"
        case date_time = "date_time"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        user_id = try values.decodeIfPresent(String.self, forKey: .user_id)
        total_amount = try values.decodeIfPresent(String.self, forKey: .total_amount)
        description = try values.decodeIfPresent(String.self, forKey: .description)
        status = try values.decodeIfPresent(String.self, forKey: .status)
        date_time = try values.decodeIfPresent(String.self, forKey: .date_time)
    }

}
