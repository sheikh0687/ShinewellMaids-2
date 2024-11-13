//
//  AddAddress.swift
//  ShinewellMaids
//
//  Created by Techimmense Software Solutions on 28/06/23.
//

import Foundation

struct AddAddress : Codable {
    
    let result : ResAddAddress?
    let message : String?
    let status : String?

    enum CodingKeys: String, CodingKey {

        case result = "result"
        case message = "message"
        case status = "status"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        result = try values.decodeIfPresent(ResAddAddress.self, forKey: .result)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        status = try values.decodeIfPresent(String.self, forKey: .status)
    }
}

struct ResAddAddress : Codable {
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
