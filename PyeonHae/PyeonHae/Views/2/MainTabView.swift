//
//  MainTabView.swift
//  PyeonHae
//
//  Created by 정건호 on 2023/01/23.
//

import SwiftUI

struct MainTabView: View {
    @State var selectedIndex: Int = 0
    
    var body: some View {
        NavigationView {
            CustomTabView(
                tabs: TabType.allCases.map({ $0.tabItem }),
                selectedIndex: $selectedIndex
            ) { index in
                let type = TabType(rawValue: index) ?? .home
                getTabView(type: type)
            }
        }
        .navigationViewStyle(.stack)
    }
    
    @ViewBuilder
    func getTabView(type: TabType) -> some View {
        switch type {
        case .home:
            HomeView()
        case .review:
            Text("리뷰")
        case .search:
            Text("탐색")
        case .myPage:
            Text("내정보")
        }
    }
}

struct TabItemData {
    let image: Image.ImageName
    let title: String
}

struct TabItemView: View {
    let data: TabItemData
    let isSelected: Bool
    
    var body: some View {
        VStack {
            Image(name: data.image)
                .foregroundColor(isSelected ? .grayscale85 : .grayscale50)
            
            Spacer().frame(height: 4)
            
            Text(data.title)
                .font(.pretendard(.medium, 11))
                .foregroundColor(isSelected ? .grayscale85 : .grayscale50)
        }
    }
}

struct TabBottomView: View {
    let tabbarItems: [TabItemData]
    var height: CGFloat = 56
    @Binding var selectedIndex: Int
    
    var body: some View {
        HStack {
            Spacer()
            ForEach(tabbarItems.indices, id: \.self) { index in
                let item = tabbarItems[index]
                Button {
                    self.selectedIndex = index
                } label: {
                    let isSelected = selectedIndex == index
                    TabItemView(data: item, isSelected: isSelected)
                }
                .buttonStyle(PlainButtonStyle())
                Spacer()
            }
        }
        .frame(height: height)
        .background(Color.white)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.borderColor)
                .edgesIgnoringSafeArea(.bottom)
        )
    }
}

struct CustomTabView<Content: View>: View {
    let tabs: [TabItemData]
    @Binding var selectedIndex: Int
    @ViewBuilder let content: (Int) -> Content
    
    var body: some View {
        ZStack {
            TabView(selection: $selectedIndex) {
                ForEach(tabs.indices, id: \.self) { index in
                    content(index)
                        .tag(index)
                }
            }
            VStack {
                Spacer()
                TabBottomView(tabbarItems: tabs, selectedIndex: $selectedIndex)
            }
        }
    }
}

enum TabType: Int, CaseIterable {
    case home = 0
    case review = 1
    case search = 2
    case myPage = 3
    
    var tabItem: TabItemData {
        switch self {
        case .home:
            return TabItemData(image: .homeIcon, title: "홈")
        case .review:
            return TabItemData(image: .reviewIcon, title: "리뷰")
        case .search:
            return TabItemData(image: .searchIcon, title: "탐색")
        case .myPage:
            return TabItemData(image: .profileIcon, title: "내정보")
        }
    }
}

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
            .previewDevice("iPhone 8")
    }
}
