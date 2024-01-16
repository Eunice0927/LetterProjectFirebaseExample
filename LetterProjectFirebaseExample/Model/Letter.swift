//
//  Letter.swift
//  LetterProjectFirebaseExample
//
//  Created by Eunsu JEONG on 1/16/24.
//

import Foundation
import FirebaseFirestore

struct Letter: Codable, Hashable, Identifiable {
    var id: String
    var writer: String
    var recipient: String
    var summary: String
    var date: Date
}

extension Letter {
    static var letterSampleData = Letter(id: UUID().uuidString, writer: "Eunice", recipient: "Tosim", summary: "토심토심아 토뭉이는 어딨어?", date: Date())
}

