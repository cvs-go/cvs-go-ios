//
//  MyInfoEditView.swift
//  PyeonHae
//
//  Created by 이주화 on 2023/04/24.
//

import SwiftUI
import WrappingHStack

struct UserCategory: Codable {
    let id: Int
    let name: String
}

class ImageSelect: ObservableObject {
    @Published var images: [UIImage] = []
}

struct MyInfoEditView: View {
    @State var nickName: String = ""
    @State var nickNameFieldState: TextFieldState = .normal
    @State private var showImagePicker = false
    @State private var selectedElements: [String] = ["맵부심", "맵찔이", "초코러버", "비건", "다이어터", "대식가", "소식가", "기타"]
    @StateObject var imageSelect = ImageSelect()
    
    let filterData: [UserCategory] = [UserCategory(id: 0, name: "맵부심"), UserCategory(id: 1, name: "맵찔이"),UserCategory(id: 2, name: "초코러버"),UserCategory(id: 3, name: "비건"),UserCategory(id: 4, name:  "다이어터"),UserCategory(id: 5, name: "대식가"),UserCategory(id: 6, name: "소식가"),UserCategory(id: 7, name: "기타")]
    
    var body: some View {
        VStack {
            HStack(spacing: 10) {
                Image(name: .close)
                Text("내 정보 수정")
                    .font(.pretendard(.bold, 20))
                    .foregroundColor(.grayscale100)
                Spacer()
            }
            .padding(.horizontal, 15)
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
            WrappingHStack(filterData, id: \.self, lineSpacing: 6) { element in
                SelectableButton(
                    text: element.name,
                    isSelected: selectedElements.contains(element.name)
                )
                .onTapGesture {
                    if selectedElements.contains(element.name) {
                        selectedElements.removeAll(where: { $0 == element.name })
                    } else {
                        selectedElements.append(element.name)
                    }
                }
            }
            .padding(.horizontal, 20)
            Spacer()
            HStack {
                Button(action: {
                    //add action
                }) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .foregroundColor(.red100)
                        Text("수정완료")
                            .font(.pretendard(.bold, 18))
                            .foregroundColor(.white)
                    }
                    .frame(height: 50)
                }
            }
            .padding(.horizontal, 20)
//            Spacer().frame(height: 50)
        }
        .sheet(isPresented: $showImagePicker) {
            MyInfoEditImagePicker(images: $imageSelect.images)
        }
    }
}

struct MyInfoEditView_Previews: PreviewProvider {
    static var previews: some View {
        MyInfoEditView()
    }
}

