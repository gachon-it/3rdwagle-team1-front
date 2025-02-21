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
