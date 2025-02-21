//
//  HomeView.swift
//  wagle-team1
//
//  Created by 이상엽 on 2/21/25.
//

import SwiftUI

struct HomeView: View {
    @State private var nickname: String = ""
    
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
            }
            .padding(.horizontal, 24)
            .padding(.bottom, 255)

            
            Spacer()
            
        }
        .navigationBarHidden(true) // 기본 네비게이션 바 숨김
        .background(Color.white.ignoresSafeArea())
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}





