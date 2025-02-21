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
        VStack(alignment: .leading, spacing: 20) {
            Text("새로 만들기")
                .font(.headline)
                .font(.system(size: 20))
                .padding(.top, 20)
                .padding(.leading, 16)
                    
            Button("폴더 만들기") {
                onSelect(.folder)
            }
            .foregroundColor(.black)
            .padding(.leading, 16)
            .padding(.top, 15)
            
            Button("개별 링크 만들기") {
                onSelect(.link)
            }
            .foregroundColor(.black)
            .padding(.leading, 16)
            .padding(.top, 15)
            
            Spacer()
        }
        .frame(maxWidth: .infinity, alignment: .leading) // 이 부분이 중요
        .padding(.bottom, 20)
        .presentationDetents([.height(230)]) // iOS16+
        .presentationCornerRadius(20)  // 원하는 값으로 조정

    }
}

