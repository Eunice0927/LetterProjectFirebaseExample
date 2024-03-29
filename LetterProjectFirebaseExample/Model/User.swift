//
//  User.swift
//  LetterProjectFirebaseExample
//
//  Created by Eunsu JEONG on 1/11/24.
//

import Foundation
//Decoding: Raw data나 Raw json 데이터를 받아 data object로 map해준다.
//Encoding: data object를 json data로 변환한다.
struct User: Identifiable, Codable {
    let id: String
    let fullName: String
    let email: String
    
    var initials: String {
        let formatter = PersonNameComponentsFormatter()
        if let components = formatter.personNameComponents(from: fullName) {
            formatter.style = .abbreviated
            return formatter.string(from: components)
        }
        
        return ""
    }
}

extension User {
    static var MOCK_USER = User(id: UUID().uuidString, fullName: "Eunice Jeong", email: "test@gmail.com")
}
