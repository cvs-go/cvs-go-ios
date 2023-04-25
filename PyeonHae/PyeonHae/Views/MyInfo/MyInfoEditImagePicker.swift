//
//  MyInfoEditImagePicker.swift
//  PyeonHae
//
//  Created by 이주화 on 2023/04/25.
//

import SwiftUI
import PhotosUI

struct MyInfoEditImagePicker: UIViewControllerRepresentable {
    @Environment(\.presentationMode) var presentationMode
    @Binding var images: [UIImage]
    
    func makeUIViewController(context: Context) -> PHPickerViewController {
        var configuration = PHPickerConfiguration()
        configuration.filter = .images
        configuration.selectionLimit = 1
        let picker = PHPickerViewController(configuration: configuration)
        picker.delegate = context.coordinator
        return picker
    }
    
    func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) {}
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: PHPickerViewControllerDelegate {
        let parent: MyInfoEditImagePicker
        
        init(_ parent: MyInfoEditImagePicker) {
            self.parent = parent
        }
        
        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            for result in results {
                let itemProvider = result.itemProvider
                if itemProvider.canLoadObject(ofClass: UIImage.self) {
                    itemProvider.loadFileRepresentation(forTypeIdentifier: UTType.image.identifier) { url, error in
                        if let error = error {
                            print("Error loading item: \(error.localizedDescription)")
                        } else if let url = url {
                            do {
                                let imageData = try Data(contentsOf: url)
                                if let imageBuffer = UIImage(data: imageData) {
                                    DispatchQueue.main.async {
                                        self.parent.images.removeAll()
                                        self.parent.images.append(imageBuffer)
                                    }
                                }
                            } catch {
                                print("Error loading image data: \(error.localizedDescription)")
                            }
                        }
                    }
                }
            }
            parent.presentationMode.wrappedValue.dismiss()
        }
    }
}

