//
//  SplashView.swift
//  PyeonHae
//
//  Created by 정건호 on 2023/03/25.
//

import SwiftUI

struct SplashView: View {
    @ObservedObject var splashViewModel = SplashViewModel()
    
    var body: some View {
        ZStack(alignment: .center) {
            Image(name: .backgroundImage)
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
            
            Image(name: .pyeonHaeImage)
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                UserShared.isLoggedIn 
                ? switchRootView(rootview: MainTabView(), direction: .fade)
                : switchRootView(rootview: LoginView(), direction: .fade)
                
            }
        }
    }
}

struct SplashView_Previews: PreviewProvider {
    static var previews: some View {
        SplashView()
    }
}
