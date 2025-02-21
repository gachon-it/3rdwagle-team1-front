//
//  FolderDetailView.swift
//  wagle-team1
//
//  Created by 이상엽 on 2/21/25.
//
import SwiftUI

struct FolderDetailView: View {
    let folder: FolderItem  // FolderItem: id(Int)와 name(String) 정도의 프로퍼티가 있다고 가정
    @StateObject private var viewModel = YourlViewModel()
    
    var body: some View {
        VStack {
            Text(folder.name)
                .font(.title2)
                .bold()
                .padding(.top, 8)
            
            List(viewModel.folderArticles) { article in
                VStack(alignment: .leading, spacing: 8) {
                    Text(article.name ?? "제목 없음")
                        .font(.headline)
                    Text(article.url)
                        .font(.subheadline)
                        .foregroundColor(.blue)
                    Text(article.description)
                        .font(.caption)
                        .foregroundColor(.gray)
                }
                .padding(.vertical, 8)
            }
            .listStyle(.plain)
        }
        .navigationTitle("폴더 상세")
        .onAppear {
            // folder.id가 Int 타입이라고 가정
            viewModel.fetchFolderArticles(folderId: folder.id)
        }
    }
}
