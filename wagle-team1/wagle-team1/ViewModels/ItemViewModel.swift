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
    @Published var folderContents: [FolderItem] = []  // 폴더 내 데이터 리스트
    @Published var folderArticles: [Article] = []

   
    
    func fetchItems() {
        // TODO: API 연동 후 데이터 파싱해서 items에 할당
        // 예시(하드코딩) - 실제로는 제거!
         items = [
            YourlItem(title: "가천대", dateString: "2025.02.22", type: .folder, isStarred: true),
            YourlItem(title: "알고리즘", dateString: "2025.02.22", type: .folder, isStarred: true),
            YourlItem(title: "유튜브", dateString: "2025.02.22", type: .folder, isStarred: true),
            YourlItem(title: "여행", dateString: "2025.02.22", type: .folder, isStarred: true),
            YourlItem(title: "C++", dateString: "2025.02.22", type: .folder, isStarred: true),
            YourlItem(title: "코딩테스트", dateString: "2025.02.22", type: .folder, isStarred: true),
            YourlItem(title: "인공지능", dateString: "2025.02.22", type: .folder, isStarred: true),
            YourlItem(title: "블록체인", dateString: "2025.02.22", type: .folder, isStarred: true),
            YourlItem(title: "IoT", dateString: "2025.02.22", type: .folder, isStarred: true),
            YourlItem(title: "파이썬", dateString: "2025.02.22", type: .folder, isStarred: false),







         ]
    }
    
    func fetchFolderContents(folderId: Int) {
            // 실제 서버 URL에 맞게 수정
            guard let url = URL(string: "https://8da8-2001-2d8-2017-5945-8cff-476a-bd11-141.ngrok-free.app/api/v1/folder/\(folderId)") else {
                print("DEBUG: Invalid folder URL")
                return
            }
            
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            // 필요한 헤더가 있다면 추가
            
            URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
                if let error = error {
                    DispatchQueue.main.async {
                        print("DEBUG: fetchFolderContents error: \(error.localizedDescription)")
                    }
                    return
                }
                
                guard let data = data else {
                    DispatchQueue.main.async {
                        print("DEBUG: No data returned from folder fetch")
                    }
                    return
                }
                
                do {
                    let folderResponse = try JSONDecoder().decode(FolderResponse.self, from: data)
                    DispatchQueue.main.async {
                        print("DEBUG: 폴더 조회 성공, items: \(folderResponse.result)")
                        self?.folderContents = folderResponse.result
                    }
                } catch {
                    DispatchQueue.main.async {
                        print("DEBUG: Folder contents decode error: \(error)")
                    }
                }
            }.resume()
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
    func createLink(title: String, url: String, memo: String, completion: @escaping (Bool) -> Void) {
            // 실제 API URL로 교체
            guard let requestURL = URL(string: "https://8da8-2001-2d8-2017-5945-8cff-476a-bd11-141.ngrok-free.app/api/v1/article") else {
                completion(false)
                return
            }
        print("DEBUG: createLink called with title: \(title), url: \(url), memo: \(memo)")

            var request = URLRequest(url: requestURL)
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            
            // JSON 바디 예시
            let body: [String: Any] = [
                "title": title,
                "url": url,
                "memo": memo
            ]
            
            do {
                request.httpBody = try JSONSerialization.data(withJSONObject: body, options: [])
            } catch {
                completion(false)
                return
            }
            
            URLSession.shared.dataTask(with: request) { data, response, error in
                if let _ = error {
                    DispatchQueue.main.async {
                        completion(false)
                    }
                    return
                }
                
                // 간단히 성공 처리 (실제로는 statusCode나 JSON 응답 체크)
                DispatchQueue.main.async {
                    completion(true)
                }
            }.resume()
        }
    
    func fetchFolderArticles(folderId: Int) {
            // 실제 서버 URL에 맞게 수정 (예시로 https://api.yourdomain.com 사용)
            guard let url = URL(string: "https://8da8-2001-2d8-2017-5945-8cff-476a-bd11-141.ngrok-free.app/api/v1/\(folderId)") else {
                print("DEBUG: Invalid URL for folder articles")
                return
            }
            
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            // 필요한 헤더가 있다면 추가 (예: Authorization 등)
            
            URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
                if let error = error {
                    DispatchQueue.main.async {
                        print("DEBUG: fetchFolderArticles error: \(error.localizedDescription)")
                    }
                    return
                }
                
                guard let data = data else {
                    DispatchQueue.main.async {
                        print("DEBUG: No data received for folder articles")
                    }
                    return
                }
                
                do {
                    let response = try JSONDecoder().decode(FolderDetailResponse.self, from: data)
                    DispatchQueue.main.async {
                        if response.code == 200 {
                            self?.folderArticles = response.result
                            print("DEBUG: Fetched articles: \(response.result)")
                        } else {
                            print("DEBUG: Folder articles fetch failed: \(response.message)")
                        }
                    }
                } catch {
                    DispatchQueue.main.async {
                        print("DEBUG: Decoding error in fetchFolderArticles: \(error)")
                    }
                }
            }.resume()
        }
    // 파일 이름 변경 (PUT)
        func renameItem(item: YourlItem, newName: String, completion: @escaping (Bool) -> Void) {
            guard let url = URL(string: "https://example.com/api/v1/files/\(item.id)") else {
                completion(false)
                return
            }
            var request = URLRequest(url: url)
            request.httpMethod = "PUT"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            
            let body = ["name": newName]
            do {
                request.httpBody = try JSONSerialization.data(withJSONObject: body)
            } catch {
                completion(false)
                return
            }
            
            URLSession.shared.dataTask(with: request) { data, response, error in
                if let _ = error {
                    DispatchQueue.main.async { completion(false) }
                    return
                }
                // 성공 시 리스트 재갱신
                DispatchQueue.main.async {
                    self.fetchItems()
                    completion(true)
                }
            }.resume()
        }
        
        // 파일 삭제 (DELETE)
        func deleteItem(item: YourlItem, completion: @escaping (Bool) -> Void) {
            guard let url = URL(string: "https://example.com/api/v1/files/\(item.id)") else {
                completion(false)
                return
            }
            var request = URLRequest(url: url)
            request.httpMethod = "DELETE"
            
            URLSession.shared.dataTask(with: request) { data, response, error in
                if let _ = error {
                    DispatchQueue.main.async { completion(false) }
                    return
                }
                // 성공 시 리스트 재갱신
                DispatchQueue.main.async {
                    self.fetchItems()
                    completion(true)
                }
            }.resume()
        }
    
    func updateLink(id: UUID, title: String, url: String, memo: String) {
        // TODO: 링크 수정 API 호출
    }
}
