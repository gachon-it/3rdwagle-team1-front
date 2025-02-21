//
//  ProfileView.swift
//  wagle-team1
//
//  Created by 이상엽 on 2/21/25.
//

import SwiftUI

struct ProfileView: View {
    @Binding var isLoggedIn: Bool

    var body: some View {
        VStack{
            
            Spacer()
            
            Image("person")
            
            Text("테스트")
                .foregroundStyle(Color.softGreen)
                .padding(.top, 50)
            
            Spacer()
            Spacer()
            
            HStack{
                Button(action: {
                    isLoggedIn = false
                }) {
                    Text("로그아웃")
                        .font(.system(size: 16, weight: .medium))
                        .foregroundColor(.gray)
                        .padding()
                }
                .padding(.leading, 43)
                
                Spacer()
            }
        }
    }
}
