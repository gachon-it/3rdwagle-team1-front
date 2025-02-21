//
//  Items.swift
//  wagle-team1
//
//  Created by 이상엽 on 2/21/25.
//

import SwiftUI

// MARK: - Model
enum YourlItemType {
    case folder
    case link
}

struct YourlItem: Identifiable {
    let id = UUID()
    var title: String
    var dateString: String
    var type: YourlItemType
    var isStarred: Bool
    
    // 실제 API 응답에 따라 구조를 바꿔서 쓰면 돼.
    // 예: folderId, linkId, etc.
}
struct FolderItem: Codable, Identifiable {
    let id: Int
    let name: String
    let date: Date
}

struct FolderResponse: Codable {
    let code: Int
    let message: String
    let result: [FolderItem]
}
struct Article: Codable, Identifiable {
    let articleId: Int
    var id: Int { articleId } // Identifiable 프로토콜을 위해 id 제공
    let name: String?
    let url: String
    let description: String
    let imageUrl: String?
    let rating: String // enum인 경우 추후 enum으로 매핑할 수 있음
    let createdAt: String? // Date로 파싱하려면 DateFormatter 적용 필요
    let updatedAt: String?
}

struct FolderDetailResponse: Codable {
    let code: Int
    let message: String
    let result: [Article]
}

enum ItemType {
    case folder
    case link
}

struct SearchItem: Identifiable {
    let id = UUID()
    let title: String
    let dateString: String
    let type: ItemType
    let memo: String?
}
