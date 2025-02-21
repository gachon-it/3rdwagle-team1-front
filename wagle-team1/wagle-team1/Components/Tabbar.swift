//
//  Tabbar.swift
//  wagle-team1
//
//  Created by 이상엽 on 2/21/25.
//

import SwiftUI

struct CustomTabBar: View {
    @State private var selectedTab = 0
    
    let icons = [
        "home", "search", "setting"
    ]
    
    var body: some View {
        HStack {
            ForEach(0..<icons.count, id: \ .self) { index in
                Spacer()
                Button(action: {
                    selectedTab = index
                }) {
                    Image(icons[index])
                        .font(.system(size: 24))
                        .foregroundColor(selectedTab == index ? Color.softGreen : Color.gray)
                }
                Spacer()
            }
        }
        .padding()
        .background(Color.white)
        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: -2)
    }
}
