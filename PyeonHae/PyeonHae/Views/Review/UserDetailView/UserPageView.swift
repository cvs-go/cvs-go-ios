//
//  UserPageView.swift
//  PyeonHae
//
//  Created by 이주화 on 2023/02/08.
//

import SwiftUI

struct UserPageView: View {
    var body: some View {
        GeometryReader { geo in
            VStack {
                ScrollView {
                    UserInfoView()
                    Spacer().frame(height: 20)
                    WriteReviewsView()
                }
                .background(Color.grayscale10)
            }
        }
    }
}

struct UserPageView_Previews: PreviewProvider {
    static var previews: some View {
        UserPageView()
    }
}
