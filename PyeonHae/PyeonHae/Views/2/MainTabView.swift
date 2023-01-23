//
//  MainTabView.swift
//  PyeonHae
//
//  Created by 정건호 on 2023/01/23.
//

import SwiftUI

struct MainTabView: View {
    var body: some View {
        NavigationView {
            TabView {
                Text("home")
                    .tabItem {
                        Image(name: .homeIcon)
                    }
                Text("review")
                    .tabItem {
                        Image(name: .reviewIcon)
                    }
                Text("search")
                    .tabItem {
                        Image(name: .searchIcon)
                    }
                Text("myPage")
                    .tabItem {
                        Image(name: .profileIcon)
                    }
            }
            .accentColor(.grayscale85)
        }
    }
}

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
    }
}
