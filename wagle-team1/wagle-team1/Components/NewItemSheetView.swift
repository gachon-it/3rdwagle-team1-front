//
//  NewItemSheetView.swift
//  wagle-team1
//
//  Created by 이상엽 on 2/21/25.
//
import SwiftUI

enum NewItemSelection {
    case folder
    case link
}

struct NewItemSheetView: View {
    var onSelect: (NewItemSelection) -> Void
    
    var body: some View {
        VStack(spacing: 20) {
            Text("새로만들기")
                .font(.headline)
                .padding(.top, 20)
            
            Divider()
            
            Button("폴더만들기") {
                onSelect(.folder)
            }
            .foregroundColor(.brown)
            
            Button("개별 링크 만들기") {
                onSelect(.link)
            }
            .foregroundColor(.brown)
            
            Spacer()
        }
        .padding(.bottom, 20)
        .presentationDetents([.height(250)]) // iOS16+
    }
}
