//
//  ItemViewModel.swift
//  wagle-team1
//
//  Created by 이상엽 on 2/21/25.
//

import SwiftUI
// MARK: - ViewModel
class YourlViewModel: ObservableObject {
    @Published var items: [YourlItem] = []
    
    // 폴더 상세용 데이터도 따로 관리할 수 있음
    // 예: [folderId: [하위 YourlItem]] 형태로
    @Published var folderContents: [UUID: [YourlItem]] = [:]
    
    func fetchItems() {
        // TODO: API 연동 후 데이터 파싱해서 items에 할당
        // 예시(하드코딩) - 실제로는 제거!
         items = [
            YourlItem(title: "가천대", dateString: "2025.02.08", type: .folder, isStarred: true),
            YourlItem(title: "폴더명", dateString: "2025.02.08", type: .folder, isStarred: true),
            YourlItem(title: "(개별링크)", dateString: "2025.02.08", type: .link, isStarred: true)
         ]
    }
    
    func fetchFolderContents(folderId: UUID) {
        // TODO: API 연동 후 folderId에 해당하는 하위 목록을 받아와 folderContents[folderId]에 저장
    }
    
    // 폴더/링크 생성/수정 로직도 여기서 처리
    func createFolder(name: String) {
        // TODO: 폴더 생성 API 호출
    }
    
    func createLink(title: String, url: String, memo: String) {
        // TODO: 링크 생성 API 호출
    }
    
    func updateLink(id: UUID, title: String, url: String, memo: String) {
        // TODO: 링크 수정 API 호출
    }
}
