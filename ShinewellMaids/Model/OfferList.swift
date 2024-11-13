//
//  OfferList.swift
//  ShinewellMaids
//
//  Created by Techimmense Software Solutions on 26/06/23.
//

import Foundation

struct GetOfferList : Codable {
    let result : [ResOfferList]?
    let message : String?
    let status : String?

    enum CodingKeys: String, CodingKey {

        case result = "result"
        case message = "message"
        case status = "status"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        result = try values.decodeIfPresent([ResOfferList].self, forKey: .result)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        status = try values.decodeIfPresent(String.self, forKey: .status)
    }
}

struct ResOfferList : Codable {
    let id : String?
    let user_id : String?
    let code : String?
    let percentage : String?
    let image : String?
    let end_date : String?
    let description : String?
    let seen_status : String?
    let cat_id : String?
    let cat_name : String?
    let date_time : String?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case user_id = "user_id"
        case code = "code"
        case percentage = "percentage"
        case image = "image"
        case end_date = "end_date"
        case description = "description"
        case seen_status = "seen_status"
        case cat_id = "cat_id"
        case cat_name = "cat_name"
        case date_time = "date_time"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        user_id = try values.decodeIfPresent(String.self, forKey: .user_id)
        code = try values.decodeIfPresent(String.self, forKey: .code)
        percentage = try values.decodeIfPresent(String.self, forKey: .percentage)
        image = try values.decodeIfPresent(String.self, forKey: .image)
        end_date = try values.decodeIfPresent(String.self, forKey: .end_date)
        description = try values.decodeIfPresent(String.self, forKey: .description)
        seen_status = try values.decodeIfPresent(String.self, forKey: .seen_status)
        cat_id = try values.decodeIfPresent(String.self, forKey: .cat_id)
        cat_name = try values.decodeIfPresent(String.self, forKey: .cat_name)
        date_time = try values.decodeIfPresent(String.self, forKey: .date_time)
    }

}
