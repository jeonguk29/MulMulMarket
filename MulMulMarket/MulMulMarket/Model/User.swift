//
//  User.swift
//  MulMulMarket
//
//  Created by 정정욱 on 7/3/24.


import Foundation
import FirebaseFirestore

struct User: Codable, Identifiable, Hashable {
    @DocumentID var id: String? // 도큐먼트 식별자를 해당 속성에 자동으로 할당하는 방법
    // Identifiable를 채택해서 id속성은 있어야함
    let fullname: String
    let nickname: String
    var profileImageUrl: String
 

}

extension User {
    // 임시 사용자
    static let MOCK_USER = User(fullname: "Bruce Wayne", nickname: "방구방구", profileImageUrl: "batman")
}

