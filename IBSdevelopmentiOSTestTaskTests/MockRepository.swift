//
//  MockRepository.swift
//  IBSdevelopmentiOSTestTaskTests
//
//  Created by Mac on 03/10/2022.
//

import Foundation
import Combine
@testable import IBSdevelopmentiOSTestTask

class MockRepository: RequestProtocol {
    var fetchAllResult: AnyPublisher<[ResultModel], Error>!
    
    let mockData = ResponseModel(results: [
        ResultModel(gender: "Male",
               name: Name(title: "Mr", first: "Tony", last: "Odu"),
               location: Location(street: Street(number: 1, name: "Chief Ore"),
                                  city: "ikeja",
                                  state: "Lagos",
                                  country: "Nigeria",
                                  coordinates: nil,
                                  timezone: nil),
               email: "oduekene@gmail.com",
               login: nil,
               dob: nil,
               registered: nil,
               phone: "08101301468",
               cell: nil,
               id: nil,
               picture: nil),
        ResultModel(gender: "Feale",
               name: Name(title: "Mrs", first: "Tonia", last: "Odu"),
               location: Location(street: Street(number: 1, name: "Chief Ore"),
                                  city: "ikeja",
                                  state: "Lagos",
                                  country: "Nigeria",
                                  coordinates: nil,
                                  timezone: nil),
               email: "kene@gmail.com",
               login: nil,
               dob: nil,
               registered: nil,
               phone: "08101301468",
               cell: nil,
               id: nil,
               picture: nil),
        ResultModel(gender: "Male",
               name: Name(title: "Mr", first: "Anthony", last: "Odu"),
               location: Location(street: Street(number: 1, name: "Chief Ore"),
                                  city: "ikeja",
                                  state: "Lagos",
                                  country: "Nigeria",
                                  coordinates: nil,
                                  timezone: nil),
               email: "odueke@gmail.com",
               login: nil,
               dob: nil,
               registered: nil,
               phone: "08101301468",
               cell: nil,
               id: nil,
               picture: nil)
    ],info: nil)
    
    func fetchAllData(counts: [Int]) -> AnyPublisher<[ResultModel], Error> {
        return fetchAllResult
    }
}
