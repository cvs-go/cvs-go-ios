//
//  MyInfoView.swift
//  PyeonHae
//
//  Created by 이주화 on 2023/04/23.
//

import SwiftUI

struct MyInfoView: View {
    @ObservedObject var myInfoViewModel = MyInfoViewModel()
    
    @State private var selectedTab: Int = 0
    @State private var tabItems = MyInfoTapType.allCases.map { $0.rawValue }
    
    @State private var showSettingView = false
    @State private var showEditView = false
    
    @State private var selectedProduct: Product? = nil
    
    var body: some View {
        VStack(spacing: 0) {
            navigationBar
            Spacer().frame(height: 20)
            UserInfoView(userInfoType: .me, showEditView: $showEditView)
            Rectangle()
                .frame(height: 14)
                .foregroundColor(Color.grayscale10)
            TopTabBar(
                tabItems: tabItems,
                contents: [
                    AnyView(MyReviewView(
                        reviewContent: $myInfoViewModel.myReviewData
                    )),
                    AnyView(MyLikeView(
                        myInfoViewModel: myInfoViewModel,
                        selectedProduct: $selectedProduct
                    )),
                    AnyView(MyBookmarkView()),
                ],
                type: .myInfo
            )
            Spacer()
            
            NavigationLink(
                destination: UserSettingView(myInfoViewModel: myInfoViewModel).navigationBarHidden(true),
                isActive: $showSettingView
            ) {
                EmptyView()
            }
        }
        .fullScreenCover(isPresented: $showEditView) {
            MyInfoEditView(myInfoViewModel: myInfoViewModel)
        }
    }
    
    @ViewBuilder
    private var navigationBar: some View {
        VStack {
            HStack {
                Spacer().frame(width: 20)
                Text("내정보")
                    .font(.pretendard(.bold, 20))
                    .foregroundColor(.grayscale100)
                Spacer()
                Image(name: .setting)
                    .onTapGesture {
                        self.showSettingView = true
                    }
                Spacer().frame(width: 18)
            }
        }
        .frame(height: 44)
    }
}

struct MyInfoView_Previews: PreviewProvider {
    static var previews: some View {
        MyInfoView()
    }
}
