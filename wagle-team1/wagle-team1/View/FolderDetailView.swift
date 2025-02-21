//
//  FolderDetailView.swift
//  wagle-team1
//
//  Created by 이상엽 on 2/21/25.
//
import SwiftUI

struct FolderDetailView: View {
    let folder: YourlItem
    @StateObject private var viewModel = YourlViewModel()
    
    var body: some View {
        VStack {
            // 상단 커스텀 or .navigationTitle
            Text(folder.title)
                .font(.title2)
                .bold()
                .padding(.top, 8)
            
            List(viewModel.folderContents[folder.id] ?? []) { item in
                HStack {
                    Image(systemName: item.type == .folder ? "folder.fill" : "link")
                        .foregroundColor(.brown)
                    
                    VStack(alignment: .leading) {
                        Text(item.title)
                            .font(.headline)
                        Text(item.dateString)
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                    Spacer()
                    
                    if item.isStarred {
                        Image(systemName: "star.fill")
                            .foregroundColor(.yellow)
                    }
                    
                    if item.type == .folder {
                        Image(systemName: "chevron.right")
                            .foregroundColor(.gray)
                    }
                }
                .contentShape(Rectangle())
                .onTapGesture {
                    // 하위 폴더면 또 FolderDetailView로 이동
                    // 링크면 LinkDetailView로 이동
                }
            }
            .listStyle(.plain)
        }
        .onAppear {
            viewModel.fetchFolderContents(folderId: folder.id)
        }
    }
}
