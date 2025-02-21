//
//  SearchView.swift
//  wagle-team1
//
//  Created by 이상엽 on 2/21/25.
//

import SwiftUI

struct SearchView: View {
    @State private var searchText: String = ""

    var body: some View {
        VStack(spacing: 40){
            TextField("폴더명 또는 링크 제목", text: $searchText)
                .padding()
                .background(RoundedRectangle(cornerRadius: 8)
                .stroke(Color.softGreen, lineWidth: 1))
                .foregroundColor(Color.softGreen)
            
            Spacer()
        }
        .padding()

    }
}

#Preview{
    SearchView()
}
