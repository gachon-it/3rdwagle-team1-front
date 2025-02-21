//
//  APIService.swift
//  wagle-team1
//
//  Created by 이상엽 on 2/21/25.
//

import Foundation

enum APIError: Error {
    case invalidURL
    case requestFailed
    case decodingFailed
}

enum APIEndpoint {
    case login
    case signup
    
    var baseURL: String {
        return "/api/v1/members"
    }
    
    var path: String {
        switch self {
        case .login:
            return "/login"
        case .signup:
            return "/signup"
        }
    }
    
    var url: URL? {
        var components = URLComponents(string: baseURL)
        components?.path = path
        
        return components?.url
    }
}

final class MemberAPI {
    
    func login(name: String, completion: @escaping (Result<LoginResponse, Error>) -> Void) {
        guard let url = URL(string:"https://8da8-2001-2d8-2017-5945-8cff-476a-bd11-141.ngrok-free.app/api/v1/members/login") else {
            completion(.failure(URLError(.badURL)))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        // JSON 데이터 전송을 위한 헤더 설정
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        // 요청 데이터 인코딩
        let loginData = LoginRequest(name: name)
        do {
            request.httpBody = try JSONEncoder().encode(loginData)
        } catch {
            completion(.failure(error))
            return
        }
        
        // URLSession을 사용해 API 호출
        URLSession.shared.dataTask(with: request) { data, response, error in
            // 에러 체크
            if let error = error {
                completion(.failure(error))
                return
            }
            
            // 응답 데이터가 없는 경우
            guard let data = data else {
                completion(.failure(URLError(.badServerResponse)))
                return
            }
            
            // JSON 디코딩
            do {
                let loginResponse = try JSONDecoder().decode(LoginResponse.self, from: data)
                completion(.success(loginResponse))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
    
    func signup(name: String, completion: @escaping (Result<SignupResponse, Error>) -> Void) {
        guard let url = URL(string:"https://8da8-2001-2d8-2017-5945-8cff-476a-bd11-141.ngrok-free.app/api/v1/members/signup") else {
            completion(.failure(URLError(.badURL)))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        // 요청 데이터 인코딩
        let signupData = SignupRequest(name: name)
        do {
            request.httpBody = try JSONEncoder().encode(signupData)
        } catch {
            completion(.failure(error))
            return
        }
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(URLError(.badServerResponse)))
                return
            }
            
            do {
                let signupResponse = try JSONDecoder().decode(SignupResponse.self, from: data)
                completion(.success(signupResponse))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}
