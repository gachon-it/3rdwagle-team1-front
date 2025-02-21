//
//  ContentView.swift
//  wagle-team1
//
//  Created by 이상엽 on 2/21/25.
//

import SwiftUI

struct ContentView: View {
    @State private var showMainView = false
    @State private var isLoggedIn: Bool = false

    
    var body: some View {
        
        ZStack {
            if showMainView {
                // 메인 콘텐츠나 이후의 뷰들을 여기에 작성합니다.
                NavigationStack{
                    if isLoggedIn {
                        HomeView()
                            .overlay(CustomTabBar(), alignment: .bottom)
                    } else {
                        SignInView(isLoggedIn: $isLoggedIn)
                    }
                }
                        
            } else {
                SplashView()
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                            withAnimation {
                                showMainView = true
                            }
                        }
                    }
            }
        }
    }
}

#Preview {
    ContentView()
}
