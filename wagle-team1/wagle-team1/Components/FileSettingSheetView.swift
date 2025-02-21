//
//  FileSettingSheetView.swift
//  wagle-team1
//
//  Created by 이상엽 on 2/22/25.
//

import SwiftUI

struct FileSettingSheetView: View {
    let item: YourlItem
    
    // 파일 이름 변경, 삭제를 부모 뷰에서 처리할 수 있도록 클로저 제공
    var onRename: (YourlItem) -> Void
    var onDelete: (YourlItem) -> Void
    
    var body: some View {
        VStack(spacing: 20) {
            Text("파일 설정하기")
                .font(.headline)
                .padding(.top, 20)
            
            Divider()
            
            Button("파일 이름 변경하기") {
                onRename(item)
            }
            .foregroundColor(.black)
            
            Button("삭제하기") {
                onDelete(item)
            }
            .foregroundColor(.red)
            
            Spacer()
        }
        .padding(.bottom, 20)
        // iOS16+ : bottomSheet 높이 설정
        .presentationDetents([.height(250)])
    }
}
