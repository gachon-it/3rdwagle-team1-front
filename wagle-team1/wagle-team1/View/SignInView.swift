//
//  SignInView.swift
//  wagle-team1
//
//  Created by 이상엽 on 2/21/25.
//



import SwiftUI

struct SignInView: View {
    @State private var nickname: String = ""
    @Binding var isLoggedIn: Bool
    
    @StateObject private var memberViewModel = MemberViewModel()
    @State private var isNavigatingToContent: Bool = false
    
    
    var body: some View {
        VStack(spacing: 40) {
            Spacer()
            
            
            Image("YourL")
                .padding(.bottom, 89)
            
            
            VStack(alignment: .leading, spacing: 8) {
                Text("닉네임")
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(Color.softGreen)
                
                TextField("닉네임을 입력해주세요", text: $nickname)
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.softGreen, lineWidth: 1))
                    .foregroundColor(Color.softGreen)
                NavigationLink(destination: SignUpView(isLoggedIn: $isLoggedIn)) {
                    Text("계정이 없으신가요?")
                        .font(.system(size: 16, weight: .medium))
                        .foregroundColor(.gray)
                        .frame(maxWidth: .infinity)
                }
                .padding(.leading, 220)
                .padding(.top, 10)
                
                
            }
            .padding(.horizontal, 24)
            .padding(.bottom, 155)
            
            
            Spacer()
            
            Button(action: {
                print("로그인 시도: 닉네임 - \(nickname)")
                memberViewModel.login(name: nickname)
            }) {
                Text("로그인")
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.softGreen)
                    .cornerRadius(8)
            }
            .padding(.horizontal, 24)
            .padding(.bottom, 40)
            // API 호출 성공 시 ContentView로 네비게이션
            NavigationLink(destination: ContentView(), isActive: $isNavigatingToContent) {
                EmptyView()
            }
        }
        .navigationBarHidden(true) // 기본 네비게이션 바 숨김
        .background(Color.white.ignoresSafeArea())
        // 로그인 응답 변경 시 처리
        .onChange(of: memberViewModel.loginResponse) { newResponse in
            if let response = newResponse {
                print("로그인 응답: \(response)")
                if response.code == 200 {
                    isLoggedIn = true
                    isNavigatingToContent = true
                } else {
                    print("로그인 실패: \(response.message)")
                }
            }
        }
        // 에러 메시지 변경 시 디버깅 로그 출력
        .onChange(of: memberViewModel.errorMessage) { error in
            if let error = error {
                print("MemberViewModel 에러: \(error)")
            }
        }
    }
}






