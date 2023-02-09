//
//  ReviewPhotoView.swift
//  PyeonHae
//
//  Created by 이주화 on 2023/02/09.
//

import SwiftUI

struct ReviewPhotoView: View {
    var body: some View {
        VStack {
            HStack {
                Image(name: .addPhoto)
                Spacer()
            }
            .padding(.horizontal, 20)
            .padding(.top, 16)
        }
        .background(Color.white)
    }
}

struct ReviewPhotoView_Previews: PreviewProvider {
    static var previews: some View {
        ReviewPhotoView()
    }
}
