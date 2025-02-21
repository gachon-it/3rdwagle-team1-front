//
//  ContentView.swift
//  wagle-team1
//
//  Created by 이상엽 on 2/21/25.
//

import SwiftUI

struct ContentView: View {
    @State private var showMainView = false
    @AppStorage("isLoggedIn") var isLoggedIn: Bool = false
    @State private var selectedTab = 0
    
    
    var body: some View {
        
        VStack {
            if showMainView {
//                NavigationStack{
                    if isLoggedIn {
                        Group {
                            switch selectedTab {
                            case 0:
                                NavigationStack {
                                    HomeView()  // 홈 화면
                                }
                            case 1:
                                NavigationStack {
                                    SearchView()  // 검색 화면
                                }
                            case 2:
                                NavigationStack {
                                    ProfileView(isLoggedIn: $isLoggedIn)  // 설정 화면
                                }
                            default:
                                NavigationStack {
                                    HomeView()
                                }
                            }
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        
                        // 커스텀 탭바를 하단에 배치
                        CustomTabBar(selectedTab: $selectedTab)
                    } else {
                        NavigationStack{
                            SignInView(isLoggedIn: $isLoggedIn)
                        }
                    }
//                }
                
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
                .onChange(of: isLoggedIn) { newValue in
                            if newValue == false {
                                // 로그아웃 될 때 selectedTab을 0으로 초기화
                                selectedTab = 0
                            }
                        }
        
    }
}

#Preview {
    ContentView()
}
