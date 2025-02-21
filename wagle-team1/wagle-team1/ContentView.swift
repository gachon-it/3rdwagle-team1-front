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
    @State private var selectedTab = 0
    
    
    var body: some View {
        
        ZStack {
            if showMainView {
                // 메인 콘텐츠나 이후의 뷰들을 여기에 작성합니다.
                NavigationStack{
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
                                    ProfileView()  // 설정 화면
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
