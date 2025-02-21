import SwiftUI
struct SearchView: View {
    @State private var searchText: String = ""
    
    // 하드코딩된 리스트
    let items: [SearchItem] = [
        SearchItem(title: "가천대", dateString: "2025.02.22", type: .folder, memo: nil),
        SearchItem(title: "가천대학교", dateString: "2025.02.22", type: .folder, memo: nil),
        SearchItem(title: "가천대 연합", dateString: "2025.02.22", type: .folder, memo: nil),
        SearchItem(title: "폴더1", dateString: "2025.02.22", type: .folder, memo: nil),
        SearchItem(title: "폴더2", dateString: "2025.02.22", type: .folder, memo: nil),
        SearchItem(title: "폴더3", dateString: "2025.02.22", type: .folder, memo: nil),

        SearchItem(title: "폴더4", dateString: "2025.02.22", type: .folder, memo: nil),

        SearchItem(title: "폴더5", dateString: "2025.02.22", type: .folder, memo: nil),
        SearchItem(title: "폴더6", dateString: "2025.02.22", type: .folder, memo: nil),
        SearchItem(title: "폴더7", dateString: "2025.02.22", type: .folder, memo: nil),
        SearchItem(title: "폴더8", dateString: "2025.02.22", type: .folder, memo: nil),


        SearchItem(title: "가천대 과제", dateString: "2025.02.22", type: .link, memo: "네이버 URL 저장할... 메모메모메모..."),
        SearchItem(title: "보글보글 바로가기", dateString: "2025.02.22", type: .link, memo: "네이버 URL 저장할... 메모메모메모..."),
        SearchItem(title: "바로가기", dateString: "2025.02.22", type: .link, memo: "네이버 URL 저장할... 메모메모메모..."),
        SearchItem(title: "바로바로", dateString: "2025.02.22", type: .link, memo: "네이버 URL 저장할... 메모메모메모..."),
        SearchItem(title: "바로가요", dateString: "2025.02.22", type: .link, memo: "네이버 URL 저장할... 메모메모메모..."),




        // 추가 항목들...
    ]
    
    // 검색어 필터링된 리스트
    var filteredItems: [SearchItem] {
        if searchText.trimmingCharacters(in: .whitespaces).isEmpty {
            return items
        } else {
            return items.filter { $0.title.contains(searchText) }
        }
    }
    
    var body: some View {
        VStack(spacing: 0) {
            // 상단 검색바
                TextField("폴더명 또는 링크 제목", text: $searchText)
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.softGreen, lineWidth: 1))
                    .foregroundColor(Color.softGreen)
                
            
            
            Divider()
            
            // 리스트
            List(filteredItems) { item in
                HStack {
                    // 폴더 or 링크 아이콘
                    Image(item.type == .folder ? "folder" : "link")
                        .foregroundColor(.softGreen)
                    
                    VStack(alignment: .leading) {
                        Text(item.title)
                            .font(.system(size: 14))
                            .foregroundStyle(Color.softGreen)
                        Text(item.dateString)
                            .font(.caption)
                            .foregroundColor(.gray)
                        
                        // 링크일 경우 메모 표시 (없으면 안 보임)
                        if let memo = item.memo, item.type == .link {
                            Text(memo)
                                .font(.caption2)
                                .foregroundColor(.gray)
                                .lineLimit(1)
                        }
                    }
                }
            }
            .listStyle(.plain)
        }
        .padding()

        .navigationBarTitleDisplayMode(.inline)
        .background(Color.white.ignoresSafeArea())
    }
}
