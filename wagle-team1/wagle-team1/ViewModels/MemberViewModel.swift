//
//  MemberViewModel.swift
//  wagle-team1
//
//  Created by 이상엽 on 2/21/25.
//
import Foundation

final class MemberViewModel: ObservableObject {
    @Published var errorMessage: String?
    @Published var loginResponse: LoginResponse?
    @Published var signupResponse: SignupResponse?
    
    private let apiService = MemberAPI()
    
    // 로그인 함수: name을 전달받아 API 호출 후 결과를 loginResponse에 저장
    func login(name: String) {
        apiService.login(name: name) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let response):
                    self?.loginResponse = response
                case .failure(let error):
                    self?.errorMessage = "로그인 실패: \(error.localizedDescription)"
                }
            }
        }
    }
    
    // 회원가입 함수: name을 전달받아 API 호출 후 결과를 signupResponse에 저장
    func signup(name: String) {
        apiService.signup(name: name) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let response):
                    self?.signupResponse = response
                case .failure(let error):
                    self?.errorMessage = "회원가입 실패: \(error.localizedDescription)"
                }
            }
        }
    }
}
