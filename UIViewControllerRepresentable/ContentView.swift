//
//  ContentView.swift
//  UIViewControllerRepresentable
//
//  Created by Florian on 03/02/2022.
//

import SwiftUI

struct ContentView: View {

    @State var showScreen: Bool = false
    @State var image: UIImage? = nil

    var body: some View {
        VStack {
            if let image = image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
            }
            
            Button {
                showScreen.toggle()
            } label: {
                Text("Click me")
            }
        }
        .sheet(isPresented: $showScreen) {
            UIImagePickerControllerRepresentable(showScreen: $showScreen, image: $image)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct UIImagePickerControllerRepresentable: UIViewControllerRepresentable {
    
    @Binding var showScreen: Bool
    @Binding var image: UIImage?

    func makeUIViewController(context: Context) -> UIImagePickerController {
        let vc = UIImagePickerController()
        vc.allowsEditing = false
        vc.delegate = context.coordinator
        return vc
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
        
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(showScreen: $showScreen, image: $image)
    }
    
    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        @Binding var showScreen: Bool
        @Binding var image: UIImage?

        init(showScreen: Binding<Bool>, image: Binding<UIImage?>) {
            self._showScreen = showScreen
            self._image = image
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            guard let newImage = info[.originalImage] as? UIImage else { return }
            image = newImage
            showScreen = false
        }
    }
}
