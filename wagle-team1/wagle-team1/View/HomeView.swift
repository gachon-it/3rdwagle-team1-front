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
    @State private var showFolderCreationModal = false
    @State private var showFolderCreationPopup = false
    @State private var showLinkCreation = false
    @State private var navigateToFolderDetail = false
    @State private var selectedFolder: YourlItem? = nil

    @AppStorage("userId") var userId: Int = 0

    let formatter = DateFormatter()

    
    
    var body: some View {
        
        NavigationStack {
            
            ZStack {
                
                
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
                    List(viewModel.folderContents) { item in
                        HStack {
                            // 폴더 or 링크 아이콘
                            Image("folder")
                                .foregroundColor(.softGreen)
                            
                            
                            VStack(alignment: .leading) {
                                Text(String(item.id))

                                Text(item.name)
                                    .font(.system(size: 14))
                                    .foregroundStyle(Color.softGreen)
                                Text(formatter.string(from: item.date))                                    .font(.caption)
                                    .foregroundColor(.gray)
                            }
                            Spacer()
                            
                            Image(systemName: "chevron.down")
                                .foregroundColor(.gray)
                            // 별표
//                            if item.isStarred {
                                Image(systemName: "star.fill")
                                    .foregroundColor(.yellow)
//                            }
                            
                            
                        }
                        .contentShape(Rectangle())
                        .onTapGesture {
                            // 폴더면 FolderDetailView로 이동
                            // 링크면 LinkDetailView로 이동
//                            if item.type == .folder {
                                // folderId를 넘겨줘야 할 수도 있음
//                                selectedFolder = item
                                navigateToFolderDetail = true
                                //                                navigateToFolderDetail(item: item)
                                print("folder click")
                            
//                            } else {
//                                navigateToLinkDetail(item: item)
//                                print("Link click")
//                                
//                            }
                        }
                    }
                    .listStyle(.plain)
                }
                .navigationBarHidden(true) // 기본 네비게이션 바 숨김
                // 화면이 나타날 때 API 호출
                .onAppear {
                    viewModel.fetchFolderContents(folderId: userId)
//                    viewModel.fetchItems()
                }
                // 바텀시트
                .sheet(isPresented: $showNewItemSheet) {
                    NewItemSheetView { selection in
                        // selection에 따라 폴더 생성화면 / 링크 생성화면으로 이동
                        if selection == .folder {
                            // 폴더 생성 화면으로 이동
                            // 보통은 NavigationStack 안에 sheet를 또 넣거나,
                            // dismiss 후 메인화면에서 다른 sheet를 띄우는 식으로도 많이 해
                            showNewItemSheet = false
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                //                            showFolderCreationModal = true
                                showFolderCreationPopup = true
                                
                            }
                        } else if selection == .link {
                            // 링크 생성 화면으로 이동
                            showNewItemSheet = false
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                    showLinkCreation = true
                                }
                        }
                    }
                    //                .presentationDetents([.height(250)])
                    
                }
                // 두 번째 시트: 폴더 만들기 모달
                //            .sheet(isPresented: $showFolderCreationModal) {
                //                FolderCreationView { folderName in
                //                    // 폴더 생성 API 호출
                //                    viewModel.createFolder(name: folderName) { success in
                //                        // 성공 시 리스트 갱신 (fetchItems() 등)
                //                        if success {
                //                            viewModel.fetchItems()
                //                        }
                //                        showFolderCreationModal = false
                //                    }
                //                }
                //                .presentationDetents([.fraction(0.3)]) // 원하는 높이로 조절
                //                .presentationDragIndicator(.visible)
                //            }
                // 중앙 팝업 (조건부)
                if showFolderCreationPopup {
                    Color.black.opacity(0.3)
                        .ignoresSafeArea()
                        .onTapGesture {
                            showFolderCreationPopup = false
                        }
                    
                    FolderCreationPopupView { folderName in
                        print("DEBUG: HomeView - FolderCreationPopupView onConfirm 호출, folderName: \(folderName)")

                        viewModel.createFolder(name: folderName) { success in
                            print("DEBUG: createFolder 결과: \(success)")

                            if success {
                                viewModel.fetchItems()
                            }
                            showFolderCreationPopup = false
                        }
                    }
                    .frame(width: 370, height: 330)
                    .background(Color.white)
                    .cornerRadius(12)
                    .shadow(radius: 5)
                }
                
            }
            .sheet(isPresented: $showLinkCreation) {
                NavigationStack {
                    LinkCreationView(viewModel: viewModel)
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


struct FolderCreationView: View {
    @State private var folderName: String = ""
    
    var onConfirm: (String) -> Void
    
    var body: some View {
        VStack(spacing: 20) {
            Text("폴더 만들기")
                .font(.headline)
            
            TextField("폴더 이름", text: $folderName)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal, 40)
            
            Button(action: {
                onConfirm(folderName)
            }) {
                Text("확인")
                    .foregroundColor(.white)
                    .padding()
                    .frame(width: 100)
                    .background(Color.brown)
                    .cornerRadius(8)
            }
        }
        .padding(30)
    }
    
}



struct FolderCreationPopupView: View {
    @State private var folderName: String = ""
    @State private var errorMessage: String? = nil
    
    var onConfirm: (String) -> Void
    
    var body: some View {
        VStack(spacing: 20) {
            Text("폴더 만들기")
                .font(.headline)
            
            Text("폴더 이름")
                .font(.system(size: 16, weight: .medium))
                .padding(.trailing, 270)
            
            TextField("", text: $folderName)
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(errorMessage == nil ? Color.softGreen : Color.red, lineWidth: 1)
                )
                .foregroundColor(errorMessage == nil ? Color.softGreen : Color.red)
            // 에러 메시지가 있으면 표시
            if let error = errorMessage {
                Text(error)
                    .font(.system(size: 14))
                    .foregroundColor(.red)
                    .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 20)                       }
            Spacer()
            Button("확인") {
                // 폴더 이름이 비어있으면 에러 메시지 설정
                if folderName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                    errorMessage = "폴더이름을 설정해주세요"
                } else {
                    errorMessage = nil
                    print("DEBUG: FolderCreationPopupView - onConfirm 호출, folderName: \(folderName)")

                    onConfirm(folderName)
                }
            }
            .frame(width: 131, height: 30)
            .padding()
            .background(Color.softGreen)
            .foregroundColor(.white)
            .cornerRadius(8)
            
            Spacer()
        }
        .padding()
    }
}
