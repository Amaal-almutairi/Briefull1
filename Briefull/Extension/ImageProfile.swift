//
//  ImageProfile.swift
//  Briefull
//
//  Created by Amaal Almutairi on 13/07/1444 AH.
//

import SwiftUI
import PhotosUI


struct ImageProfile: View {
    @State private var selectedImage:[PhotosPickerItem] = []
    @State private var selectedImageData: [Data] = []
    
    var body: some View {
        NavigationStack {
            VStack{
                if selectedImageData.count > 0{
                    // Show Image
                    ScrollView{
                        LazyVGrid(columns: [.init(.adaptive(minimum: 200)), .init(.adaptive(minimum: 200))]){
                            ForEach(selectedImageData, id: \.self){dataItem in
                                if let dataItem = dataItem, let uiImage = UIImage(data: dataItem){
                                    Image(uiImage: uiImage).resizable().frame(width: 180, height: 150).aspectRatio(contentMode: .fill).cornerRadius(10)
                                }
                            }
                        }
                        .padding()
                    }
                }
                else{
                    Spacer()
                    Text("Please select image by tapping on photo icon on toolbar").foregroundColor(.gray).font(.system(size: 25)).bold().multilineTextAlignment(.center)
                }
                Spacer()
                //                Text("\(selectedImageData.count) photos")
            }
            .navigationTitle("Profile").navigationBarTitleDisplayMode(.inline)
            
                .toolbar{
                    NavigationLink(destination: EditPersonalInfo()) {
                        Text("edit")
                            .foregroundColor(.red)
                    }
                        }
                PhotosPicker(selection: $selectedImage,maxSelectionCount: 50 ,matching: .images, label: {
                    Image(systemName: "photo.fill").tint(.mint)
                })
                .onChange(of: selectedImage){newItem in
                    Task{
                        selectedImage = []
                        for item in newItem {
                            if let data = try? await item.loadTransferable(type: Data.self){
                                selectedImageData.append(data)
                            }
                        }
                    }
                }
           // }
        }
    }
}




struct ImageProfile_Previews: PreviewProvider {
    static var previews: some View {
        ImageProfile()
    }
}

//
//    @Binding var isShown: Bool
//    @Binding var uiImage: UIImage?
//
//    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
//
//        @Binding var isShown: Bool
//        @Binding var uiImage: UIImage?
//
//        init(isShown: Binding<Bool>, uiImage: Binding<UIImage?>) {
//            _isShown = isShown
//            _uiImage = uiImage
//        }
//
//        func imagePickerController(_ picker: UIImagePickerController,
//                                   didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
//            let imagePicked = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
//            uiImage = imagePicked
//            isShown = false
//        }
//
//        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
//            isShown = false
//        }
//
//    }
//
//    func makeCoordinator() -> Coordinator {
//        return Coordinator(isShown: $isShown, uiImage: $uiImage)
//    }
//
//    func makeUIViewController(context: UIViewControllerRepresentableContext<ImageProfile>) -> UIImagePickerController {
//        let picker = UIImagePickerController()
//        picker.delegate = context.coordinator
//        return picker
//    }
//
//    func updateUIViewController(_ uiViewController: UIImagePickerController,
//                                context: UIViewControllerRepresentableContext<ImageProfile>) {
//
//    }
//
//}
//
//import SwiftUI
//
//struct ImagePickerView:View {
//    var body: some View {
//
//}
//
//
//}
//

//    private let sourceType: UIImagePickerController.SourceType
//    private let onImagePicked: (UIImage) -> Void
//    @Environment(\.presentationMode) private var presentationMode
//
//    public init(sourceType: UIImagePickerController.SourceType, onImagePicked: @escaping (UIImage) -> Void) {
//        self.sourceType = sourceType
//        self.onImagePicked = onImagePicked
//    }
//
//    public func makeUIViewController(context: Context) -> UIImagePickerController {
//        let picker = UIImagePickerController()
//        picker.sourceType = self.sourceType
//        picker.delegate = context.coordinator
//        return picker
//    }
//
//    public func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}
//
//    public func makeCoordinator() -> Coordinator {
//        Coordinator(
//            onDismiss: { self.presentationMode.wrappedValue.dismiss() },
//            onImagePicked: self.onImagePicked
//        )
//    }
//
//    final public class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
//
//        private let onDismiss: () -> Void
//        private let onImagePicked: (UIImage) -> Void
//
//        init(onDismiss: @escaping () -> Void, onImagePicked: @escaping (UIImage) -> Void) {
//            self.onDismiss = onDismiss
//            self.onImagePicked = onImagePicked
//        }
//
//        public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
//            if let image = info[.originalImage] as? UIImage {
//                self.onImagePicked(image)
//            }
//            self.onDismiss()
//        }
//
//        public func imagePickerControllerDidCancel(_: UIImagePickerController) {
//            self.onDismiss()
//        }
//
//    }


