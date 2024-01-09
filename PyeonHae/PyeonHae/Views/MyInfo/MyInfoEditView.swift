//
//  MyInfoEditView.swift
//  PyeonHae
//
//  Created by 이주화 on 2023/04/24.
//

import SwiftUI
import WrappingHStack

class ImageSelect: ObservableObject {
    @Published var images: [UIImage] = []
}

struct MyInfoEditView: View {
    @ObservedObject var myInfoViewModel: MyInfoViewModel
    @StateObject private var keyboardResponder = KeyboardResponder()
    @State var nickName: String = ""
    @State var nickNameFieldState: TextFieldState = .normal
    @State private var showImagePicker = false
    @State private var selectedTags: [TagModel] = []
    @StateObject var imageSelect = ImageSelect()
    @Binding var showEditView: Bool
    
    var body: some View {
        ZStack {
            VStack {
                NavigationBar(type: .close, title: "내정보 수정")
                Spacer().frame(height: 60)
                Button(action: {
                    showImagePicker.toggle()
                }) {
                    if imageSelect.images.isEmpty {
                        Image(name: .emptyImage)
                            .resizable()
                            .frame(width: 120, height: 120)
                    } else {
                        Image(uiImage: imageSelect.images.first ?? UIImage())
                            .resizable()
                            .frame(width: 120, height: 120)
                    }
                }
                .cornerRadius(10)
                .buttonStyle(.plain)
                Spacer().frame(height: 30)
                HStack {
                    TextFieldWithTitle(text: $nickName, title: "닉네임", placeholder: "2자 이상 8자 이내의 닉네임을 입력해주세요.", isSecure: false, type: .nickname, state: $nickNameFieldState)
                }
                .padding(.horizontal, 20)
                Spacer().frame(height: 50)
                HStack {
                    Text("유저태그")
                        .font(.pretendard(.bold, 14))
                        .foregroundColor(.grayscale100)
                    Spacer()
                }
                .padding(.horizontal, 20)
                WrappingHStack(UserShared.tags, id: \.self, lineSpacing: 6) { tag in
                    SelectableButton(
                        text: tag.name,
                        isSelected: selectedTags.contains { $0 == tag }
                    )
                    .onTapGesture {
                        handleTagSelection(tag)
                    }
                }
                .padding(.horizontal, 20)
                Spacer()
            }
            VStack {
                Spacer()
                HStack {
                    Button(action: {
                        if imageSelect.images.isEmpty {
                            myInfoViewModel.requestEditInfo(
                                nickname: nickName,
                                tagIds: selectedTags.map { $0.id },
                                completion: {
                                    showEditView = false
                                }
                            )
                        } else {
                            myInfoViewModel.requestEditInfoWithImage(
                                nickname: nickName,
                                tagIds: selectedTags.map { $0.id },
                                images: imageSelect.images,
                                completion: {
                                    showEditView = false
                                }
                            )
                        }
                    }) {
                        ZStack {
                            if(keyboardResponder.currentHeight > 0) {
                                Rectangle()
                                    .foregroundColor(.red100)
                            } else {
                                RoundedRectangle(cornerRadius: 10)
                                    .foregroundColor(.red100)
                            }
                            Text("수정완료")
                                .font(.pretendard(.bold, 18))
                                .foregroundColor(.white)
                        }
                        .frame(height: 50)
                    }
                }
                .padding(.horizontal, keyboardResponder.currentHeight > 0 ? 0 : 20)
            }
        }
        .sheet(isPresented: $showImagePicker) {
            MyInfoEditImagePicker(images: $imageSelect.images)
        }
        .onAppear {
            initUserInfo()
        }
    }
    
    private func handleTagSelection(_ tag: TagModel) {
        if selectedTags.contains(tag) {
            selectedTags.removeAll(where: { $0 == tag })
        } else {
            // 같은 그룹의 태그가 선택되어 있으면 선택 해제
            if selectedTags.map({ $0.group }).contains(tag.group) {
                selectedTags.removeAll(where: { $0.group == tag.group })
            }
            if selectedTags.count < 3 {
                selectedTags.append(tag)
            }
        }
    }
    
    private func initUserInfo() {
        self.nickName = UserShared.userNickname
        self.selectedTags = UserShared.userTags
        UserShared.userProfileImageUrl?.toImage { image in
            if let image = image {
                self.imageSelect.images = [image]
            }
        }
    }
}

