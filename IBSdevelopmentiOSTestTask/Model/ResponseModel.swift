//
//  ResponseModel.swift
//  IBSdevelopmentiOSTestTask
//
//  Created by Mac on 02/10/2022.
//

import Foundation

// MARK: - ResponseModel
struct ResponseModel: Codable {
    let results: [ResultModel]
    let info: Info?
}

// MARK: - Info
struct Info: Codable {
    let seed: String?
    let results, page: Int?
    let version: String?
}

// MARK: - Result
struct ResultModel: Codable {
    let gender: String?
    let name: Name?
    let location: Location?
    let email: String?
    let login: Login?
    let dob, registered: Dob?
    let phone, cell: String?
    let id: ID?
    let picture: Picture?
}

// MARK: - Dob
struct Dob: Codable {
    let date: String?
    let age: Int?
}

// MARK: - ID
struct ID: Codable {
    let name, value: String?
}

// MARK: - Location
struct Location: Codable {
    let street: Street?
    let city, state, country: String?
    let coordinates: Coordinates?
    let timezone: Timezone?
}

// MARK: - Coordinates
struct Coordinates: Codable {
    let latitude, longitude: String?
}

// MARK: - Street
struct Street: Codable {
    let number: Int?
    let name: String?
}

// MARK: - Timezone
struct Timezone: Codable {
    let offset, timezoneDescription: String?

    enum CodingKeys: String, CodingKey {
        case offset
        case timezoneDescription = "description"
    }
}

// MARK: - Login
struct Login: Codable {
    let uuid, username, password, salt: String?
    let md5, sha1, sha256: String?
}

// MARK: - Name
struct Name: Codable {
    let title, first, last: String?
}

// MARK: - Picture
struct Picture: Codable {
    let large, medium, thumbnail: String?
}
