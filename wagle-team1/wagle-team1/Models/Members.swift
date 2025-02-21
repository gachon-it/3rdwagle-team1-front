//
//  Member.swift
//  wagle-team1
//
//  Created by 이상엽 on 2/21/25.
//

import Foundation

// MARK: - login 관련 모델
struct LoginRequest: Codable {
    let name: String
}

struct LoginResult: Codable, Equatable {
    let userId: Int
    let token: String
}

struct LoginResponse: Codable, Equatable {
    let code: Int
    let message: String
    let result: LoginResult?
    // 필요한 다른 필드들도 여기에 추가해
}

// MARK: - 회원가입 관련 모델

struct SignupRequest: Codable {
    let name: String
}

struct SignupResponse: Codable, Equatable {
    let message: String
    let code: Int
}
