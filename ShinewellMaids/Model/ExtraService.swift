//
//  ExtraService.swift
//  ShinewellMaids
//
//  Created by Techimmense Software Solutions on 26/06/23.
//

import Foundation

struct GetExtraService : Codable {
    
    let result : [ResExtraService]?
    let message : String?
    let status : String?

    enum CodingKeys: String, CodingKey {

        case result = "result"
        case message = "message"
        case status = "status"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        result = try values.decodeIfPresent([ResExtraService].self, forKey: .result)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        status = try values.decodeIfPresent(String.self, forKey: .status)
    }
}

struct ResExtraService : Codable {
    let id : String?
    let name : String?
    let price : String?
    let image : String?
    let time : String?
    let date_time : String?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case name = "name"
        case price = "price"
        case image = "image"
        case time = "time"
        case date_time = "date_time"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        price = try values.decodeIfPresent(String.self, forKey: .price)
        image = try values.decodeIfPresent(String.self, forKey: .image)
        time = try values.decodeIfPresent(String.self, forKey: .time)
        date_time = try values.decodeIfPresent(String.self, forKey: .date_time)
    }
}
