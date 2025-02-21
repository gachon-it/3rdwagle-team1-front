//
//  LinkDetailView.swift
//  wagle-team1
//
//  Created by 이상엽 on 2/21/25.
//

import SwiftUI

struct LinkDetailView: View {
    @State var title: String
    @State var url: String
    @State var memo: String
    
    // 실제 수정 로직은 ViewModel 통해 처리
    @ObservedObject var viewModel: YourlViewModel
    let linkId: UUID
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            TextField("제목제목", text: $title)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            TextField("https://naver.com", text: $url)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            // 메모는 여러 줄 필요하면 TextEditor 사용
            TextEditor(text: $memo)
                .frame(height: 150)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.gray.opacity(0.5), lineWidth: 1)
                )
            
            Spacer()
            
            Button {
                // 수정하기
                viewModel.updateLink(id: linkId, title: title, url: url, memo: memo)
            } label: {
                Text("수정하기")
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.brown)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
        }
        .padding()
        .navigationTitle("링크 상세")
    }
}
