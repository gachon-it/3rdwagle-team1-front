//
//  HomeView.swift
//  wagle-team1
//
//  Created by 이상엽 on 2/21/25.
//

import SwiftUI

struct HomeView: View {
        @StateObject private var viewModel = YourlViewModel()
        
        // 바텀시트(두 번째 이미지) 노출 여부
        @State private var showNewItemSheet = false
        
        var body: some View {
            NavigationStack {
                VStack {
                    // 상단 커스텀 바
                    HStack{
                        Spacer()
                        
                        Image("YourL")
                            .padding(.leading, 65)
                        
                        Spacer()
                        
                        // 우측 상단 검색 버튼
                        Button {
                            // 검색 액션
                        } label: {
                            Image("search")
                                .renderingMode(.template)
                                .font(.system(size: 24))
                                .foregroundColor(.softGreen)
                        }
                        .padding(.trailing, 45)
                    }
                    .padding(.vertical, 8)
                    HStack{
                        
                        Button {
                            showNewItemSheet = true
                        } label: {
                            Label {
                                Text("새로 만들기")
                                    .foregroundStyle(Color.softGreen)
                            } icon: {
                                Image("plus")
                                    .renderingMode(.template) // 템플릿 모드 설정
                                    .foregroundStyle(Color.softGreen)
                            }
                        }
                        .padding(.leading, 33)
                        .padding(.top, 53)
                        
                        Spacer()
                    }
                    // 메인 리스트
                    List(viewModel.items) { item in
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
                            }
                            Spacer()
                            
                            Image(systemName: "chevron.down")
                                .foregroundColor(.gray)
                            // 별표
                            if item.isStarred {
                                Image(systemName: "star.fill")
                                    .foregroundColor(.yellow)
                            }
                            
                                
                        }
                        .contentShape(Rectangle())
                        .onTapGesture {
                            // 폴더면 FolderDetailView로 이동
                            // 링크면 LinkDetailView로 이동
                            if item.type == .folder {
                                // folderId를 넘겨줘야 할 수도 있음
                                navigateToFolderDetail(item: item)
                                print("folder click")
                            } else {
                                navigateToLinkDetail(item: item)
                                print("Link click")

                            }
                        }
                    }
                    .listStyle(.plain)
                }
                .navigationBarHidden(true) // 기본 네비게이션 바 숨김
                // 화면이 나타날 때 API 호출
                .onAppear {
                    viewModel.fetchItems()
                }
                // 바텀시트
                .sheet(isPresented: $showNewItemSheet) {
                    NewItemSheetView { selection in
                        // selection에 따라 폴더 생성화면 / 링크 생성화면으로 이동
                        if selection == .folder {
                            // 폴더 생성 화면으로 이동
                            // 보통은 NavigationStack 안에 sheet를 또 넣거나,
                            // dismiss 후 메인화면에서 다른 sheet를 띄우는 식으로도 많이 해
                        } else if selection == .link {
                            // 링크 생성 화면으로 이동
                        }
                    }
                }
            }
        }
        
        // 폴더 상세 화면으로 이동
        private func navigateToFolderDetail(item: YourlItem) {
            // NavigationStack에서는 NavigationLink 대신 .navigationDestination()를 쓸 수도 있어
            // 여기서는 간단히 링크 뷰를 push하는 예시로.
            
            // 방법 1) NavigationStack에 .navigationDestination(for: YourlItem.self) 사용
            // 방법 2) State로 관리해서 NavigationLink 강제 트리거
            // 여기선 방법 2 간단 예시:
        }
        
        // 링크 상세 화면으로 이동
        private func navigateToLinkDetail(item: YourlItem) {
            // LinkDetailView로 이동
        }
    }


struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}





