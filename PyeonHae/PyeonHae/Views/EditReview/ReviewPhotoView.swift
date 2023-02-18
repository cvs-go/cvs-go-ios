//
//  ReviewPhotoView.swift
//  PyeonHae
//
//  Created by 이주화 on 2023/02/09.
//

import SwiftUI
import PhotosUI

class ImageSelection: ObservableObject {
    @Published var images: [UIImage] = []
}

struct ReviewPhotoView: View {
    @StateObject private var imageSelection = ImageSelection()
    @State private var showImagePicker = false
    
    var body: some View {
        VStack {
            HStack {
                Button(action: {
                    showImagePicker.toggle()
                }) {
                    Image(name: .addPhoto)
                        .resizable()
                        .frame(width: 72, height: 72)
                }
                ForEach(imageSelection.images.indices, id: \.self) { index in
                    ZStack {
                        Image(uiImage: imageSelection.images[index])
                            .resizable()
                            .frame(width: 72, height: 72)
                            .aspectRatio(contentMode: .fit)
                            .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.grayscale30, lineWidth: 1)
                        HStack {
                            Spacer()
                            VStack {
                                Button(action: {
                                    if imageSelection.images[safe: index] != nil {
                                        imageSelection.images.remove(at: index)
                                    }
                                }) {
                                    Image(name: .deletePhoto)
                                        .padding([.top, .trailing], 4)
                                }
                                Spacer()
                            }
                        }
                    }
                    .frame(width: 72, height: 72)
                }
                Spacer()
            }
            .padding(.horizontal, 20)
            .padding(.top, 16)
        }
        .background(Color.white)
        .sheet(isPresented: $showImagePicker) {
            ImagePicker(images: $imageSelection.images)
        }
    }
}

struct ReviewPhotoView_Previews: PreviewProvider {
    static var previews: some View {
        ReviewPhotoView()
    }
}

