//
//  SignupSelectTagView.swift
//  PyeonHae
//
//  Created by 정건호 on 2023/01/15.
//

import SwiftUI
import WrappingHStack

struct SignupSelectTagView: View {
    @ObservedObject var loginViewModel: LoginViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            Spacer().frame(height: 23)
            Text("‘\(loginViewModel.nickname)’님의\n취향이 궁금해요.")
                .font(.pretendard(.medium, 24))
                .foregroundColor(.grayscale100)
            Spacer().frame(height: 8)
            Text("최대 3개까지 선택할 수 있습니다.")
                .font(.pretendard(.regular, 14))
                .foregroundColor(.grayscale85)
                .padding(.leading, 2)
            Spacer().frame(height: 31)
            Text("유저 태그")
                .font(.pretendard(.bold, 14))
                .foregroundColor(.grayscale100)
            Spacer().frame(height: 13)
            WrappingHStack(UserShared.tags, lineSpacing: 6) { tag in
                SelectableButton(
                    text: tag.name,
                    isSelected: loginViewModel.selectedTags.contains { $0 == tag }
                )
                .onTapGesture {
                    handleTagSelection(tag)
                }
            }
            Spacer()
            NavigationLink(
                destination: SignUpSuccessView(loginViewModel: loginViewModel).navigationBarHidden(true),
                isActive: $loginViewModel.pushToSuccess) {
                    Text("확인")
                        .font(.pretendard(.bold, 18))
                        .foregroundColor(.white)
                        .frame(width: UIWindow().screen.bounds.width - 40, height: 50)
                        .background(Color.red100)
                        .cornerRadius(10)
                        .onTapGesture {
                            loginViewModel.requestSignUp()
                        }
                }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.leading, 20)
    }
    
    private func handleTagSelection(_ tag: TagModel) {
        if loginViewModel.selectedTags.contains(tag) {
            loginViewModel.selectedTags.removeAll(where: { $0 == tag })
        } else {
            // 같은 그룹의 태그가 선택되어 있으면 선택 해제
            if loginViewModel.selectedTags.map({ $0.group }).contains(tag.group) {
                loginViewModel.selectedTags.removeAll(where: { $0.group == tag.group })
            }
            if loginViewModel.selectedTags.count < 3 {
                loginViewModel.selectedTags.append(tag)
            }
        }
    }
}
