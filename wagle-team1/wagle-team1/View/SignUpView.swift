import SwiftUI

struct SignUpView: View {
    @State private var nickname: String = ""
    @State private var nicknameError: String? = nil
    @State private var isNavigatingToHome: Bool = false
    @Binding var isLoggedIn: Bool
    @Environment(\.dismiss) var dismiss

    @StateObject private var memberViewModel = MemberViewModel()
    
    var body: some View {
        VStack(spacing: 40) {
            HStack {
                Button(action: {
                    dismiss()
                }) {
                    Image(systemName: "chevron.left")
                        .font(.system(size: 24, weight: .medium))
                        .foregroundColor(Color.softGreen)
                }
                .padding(.leading, 32)
                Spacer()
            }
            .padding(.top, 53)

            Image("YourL")
                .padding(.bottom, 89)

            VStack(alignment: .leading, spacing: 8) {
                Text("닉네임")
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(Color.softGreen)

                TextField("닉네임을 입력해주세요", text: $nickname)
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 8)
                        .stroke(nicknameError == nil ? Color.softGreen : Color.red, lineWidth: 1))
                    .foregroundColor(nicknameError == nil ? Color.softGreen : Color.red)

                if let error = nicknameError {
                    Text(error)
                        .font(.system(size: 14))
                        .foregroundColor(Color.red)
                }
            }
            .padding(.horizontal, 24)
            .padding(.bottom, 255)

            Spacer()

            Button(action: {
                validateNickname()
            }) {
                Text("회원가입")
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.softGreen)
                    .cornerRadius(8)
            }
            .padding(.horizontal, 24)
            .padding(.bottom, 40)

            NavigationLink(
                destination: SignInView(isLoggedIn: $isLoggedIn),
                isActive: $isNavigatingToHome
            ) {
                EmptyView()
            }
        }
        .navigationBarHidden(true) // 기본 네비게이션 바 숨김
        .background(Color.white.ignoresSafeArea())
        // signupResponse가 변경되면 호출됨 (디버깅용 print문 포함)
                .onChange(of: memberViewModel.signupResponse) { response in
                    if let response = response {
                        print("Signup response: \(response)")
                        if response.code == 201 {
                            // 회원가입 성공
                            isNavigatingToHome = true
                        } else {
                            // 회원가입 실패 시 에러 메시지 표시
                            nicknameError = response.message
                        }
                    }
                }
                // 에러 메시지가 업데이트 될 때도 디버깅 출력
                .onChange(of: memberViewModel.errorMessage) { error in
                    if let error = error {
                        print("MemberViewModel error: \(error)")
                    }
                }
    }

    private func validateNickname() {
            if nickname.isEmpty {
                nicknameError = "닉네임을 입력해주세요"
            } else if nickname.count > 10 {
                nicknameError = "최대 10자까지 입력 가능합니다"
            } else {
                nicknameError = nil
                // 디버깅: 회원가입 API 호출 전 로그 출력
                print("Calling signup API with nickname: \(nickname)")
                memberViewModel.signup(name: nickname)
            }
        }
}
