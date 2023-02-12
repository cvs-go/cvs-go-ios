//
//  EditReviewView.swift
//  PyeonHae
//
//  Created by 이주화 on 2023/02/09.
//

import SwiftUI

struct EditReviewView: View {
    var body: some View {
        GeometryReader { geo in
            VStack(spacing: 0) {
                    SelectProductView()
                    Spacer().frame(height: 20)
                    EditLetterView()
                    ReviewPhotoView()
            }
            .background(Color.grayscale10)
        }
    }
}

struct EditReviewView_Previews: PreviewProvider {
    static var previews: some View {
        EditReviewView()
    }
}
