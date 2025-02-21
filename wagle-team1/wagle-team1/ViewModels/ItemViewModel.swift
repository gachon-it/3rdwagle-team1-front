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
    func createFolder(name: String, completion: @escaping (Bool) -> Void) {
        // 폴더 생성 API 호출
        // 예시:
        guard let url = URL(string: "https://8da8-2001-2d8-2017-5945-8cff-476a-bd11-141.ngrok-free.app/api/v1/folder/create") else {
            completion(false)
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let body = ["folderName": name]
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: body, options: [])
        } catch {
            completion(false)
            return
        }
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            // 간단히 처리
            if let _ = error {
                completion(false)
                return
            }
            // 성공 시 true, 실패 시 false
            completion(true)
        }.resume()
    }
    func createLink(title: String, url: String, memo: String) {
        // TODO: 링크 생성 API 호출
    }
    
    func updateLink(id: UUID, title: String, url: String, memo: String) {
        // TODO: 링크 수정 API 호출
    }
}
