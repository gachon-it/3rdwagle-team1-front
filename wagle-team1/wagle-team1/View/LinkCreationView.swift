//
//  LinkCreationView.swift
//  wagle-team1
//
//  Created by 이상엽 on 2/22/25.
//

import SwiftUI

struct LinkCreationView: View {
    @ObservedObject var viewModel: YourlViewModel  // 뷰모델 (이미 있다면 주입)
    @Environment(\.dismiss) private var dismiss
    
    @State private var linkTitle: String = ""
    @State private var linkURL: String = ""
    @State private var linkMemo: String = ""
    
    // 저장 버튼 활성화 여부
    private var isSaveButtonDisabled: Bool {
        linkTitle.trimmingCharacters(in: .whitespaces).isEmpty ||
        linkURL.trimmingCharacters(in: .whitespaces).isEmpty ||
        linkMemo.trimmingCharacters(in: .whitespaces).isEmpty
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Image("YourL")
                .padding(.leading, 130)
            Text("제목")
                .font(.system(size: 16, weight: .medium))
                .foregroundColor(.softGreen)
            TextField("제목을 입력해주세요", text: $linkTitle)
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.softGreen, lineWidth: 1)
                )
            
            Text("URL")
                .font(.system(size: 16, weight: .medium))
                .foregroundColor(.softGreen)
            TextField("URL을 입력해주세요", text: $linkURL)
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.softGreen, lineWidth: 1)
                )
                .keyboardType(.URL)
                .autocapitalization(.none)
            
            Text("메모")
                .font(.system(size: 16, weight: .medium))
                .foregroundColor(.softGreen)
            
            // TextEditor에는 기본 placeholder가 없어서 ZStack으로 구현
            ZStack(alignment: .topLeading) {
                if linkMemo.isEmpty {
                    Text("메모할 내용을 입력해주세요")
                        .foregroundColor(.gray)
                        .padding(.top, 8)
                        .padding(.leading, 4)
                }
                TextEditor(text: $linkMemo)
                    .frame(minHeight: 120)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.softGreen, lineWidth: 1)
                    )
            }
            
            Spacer()
            
            Button(action: {
                // 저장하기
                print("DEBUG: Saving link with title: \(linkTitle), url: \(linkURL), memo: \(linkMemo)")

                viewModel.createLink(title: linkTitle, url: linkURL, memo: linkMemo) { success in
                    print("DEBUG: createLink callback success: \(success)")

                    if success {
                        // 성공 시 리스트 갱신하고 화면 닫기
                        viewModel.fetchItems()
                        dismiss()
                    } else {
                        // 실패 시 필요하면 에러 처리
                        print("DEBUG: 링크 생성 실패")
                    }
                }
            }) {
                Text("수정하기")
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(isSaveButtonDisabled ? Color.gray : Color.softGreen)
                    .cornerRadius(8)
            }
            .disabled(isSaveButtonDisabled) // 입력이 다 안 되면 버튼 비활성화
            
        }
        .padding()
//        .navigationTitle("개별 링크 만들기")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
                    // 왼쪽에 화살표 이미지를 가진 버튼을 추가해서 화면 닫기
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button(action: {
                            dismiss()
                        }) {
                            Image(systemName: "chevron.left")
                                .font(.system(size: 20, weight: .medium))
                                .foregroundColor(.softGreen)
                        }
                    }
                }
    }
}
