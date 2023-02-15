//
//  ImagePicker.swift
//  Briefull
//
//  Created by Amaal Almutairi on 15/07/1444 AH.
//


import SwiftUI



struct ImagePicker: UIViewControllerRepresentable {
    
//    @Binding var selectedImage: UIImage
    @Binding var selectedImage: Image?
    @Binding var showImagePiker: Bool
    @Binding var imageData:Data
    
    @Environment(\.presentationMode) private var presentationMode
    var sourceType: UIImagePickerController.SourceType = .photoLibrary
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        
        let imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = true
//        imagePicker.sourceType = sourceType
        imagePicker.delegate = context.coordinator
        
        return imagePicker
        
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
        //leave alone for right now
    }
    
    final class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
     
        var parent: ImagePicker
     
        init(_ parent: ImagePicker) {
            self.parent = parent
        }
        
    
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
     
            if let image = info[.editedImage] as? UIImage,let mediaData = image.jpegData(compressionQuality: 0.5){
                parent.selectedImage = Image(uiImage: image)
                parent.imageData = mediaData
            }
            parent.showImagePiker = false
     
//            parent.presentationMode.wrappedValue.dismiss()
        }
    }
    
    func makeCoordinator() -> ImagePicker.Coordinator {
        Coordinator(self)
    }
    
}


//func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
//
//    if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
//        parent.selectedImage = image
//    }
//
//    parent.presentationMode.wrappedValue.dismiss()
//}
