import SwiftUI

struct SignUpView: View {
    @State private var nickname: String = ""
    @State private var nicknameError: String? = nil
    @State private var isNavigatingToHome: Bool = false
    @Binding var isLoggedIn: Bool
    @Environment(\.dismiss) var dismiss

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
    }

    private func validateNickname() {
        if nickname.isEmpty {
            nicknameError = "닉네임을 입력해주세요"
        } else if nickname.count > 10 {
            nicknameError = "최대 10자까지 입력 가능합니다"
        } else {
            nicknameError = nil
            isNavigatingToHome = true
        }
    }
}
