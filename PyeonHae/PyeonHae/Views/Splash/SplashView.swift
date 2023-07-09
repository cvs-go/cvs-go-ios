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
                UserShared.isLoggedIn ? switchRootViewToMain() : switchRootViewToLogin()
            }
        }
    }
    
    private func switchRootView<Content: View>(to rootView: Content) {
        let hostingController = UIHostingController(rootView: rootView)
        let option = UIWindow.TransitionOptions(direction: .fade, style: .easeInOut)
        option.duration = 0.25
        UIApplication.shared.keyWindow?.set(rootViewController: hostingController, options: option, nil)
    }

    private func switchRootViewToMain() {
        switchRootView(to: MainTabView())
    }

    private func switchRootViewToLogin() {
        switchRootView(to: LoginView())
    }
}

struct SplashView_Previews: PreviewProvider {
    static var previews: some View {
        SplashView()
    }
}
