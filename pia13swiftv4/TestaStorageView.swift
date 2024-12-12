//
//  TestaStorageView.swift
//  pia13swiftv4
//
//  Created by BillU on 2024-12-12.
//

import SwiftUI
import FirebaseStorage
import PhotosUI

struct TestaStorageView: View {
    
    @State private var userphotoItem: PhotosPickerItem?
    @State private var userphotoImage: Image?

    
    @State var fancyimage : Image?
    
    var body: some View {
        VStack {
            Text("Frog")
            
            if fancyimage != nil {
                fancyimage!
                    .resizable()
                    .frame(width: 100, height: 100)
            }
            
            PhotosPicker("Select some image", selection: $userphotoItem, matching: .images)

            userphotoImage?
                .resizable()
                .scaledToFit()
                .frame(width: 200, height: 200)
            
        }
        .onAppear() {
            //dostorage()
        }
        .onChange(of: userphotoItem) {
            Task {
                if let loaded = try? await userphotoItem?.loadTransferable(type: Image.self) {
                    userphotoImage = loaded
                    
                    uploadToStorage(uploadimage: loaded)
                } else {
                    print("Failed")
                }
            }
        }
    }
    
    func dostorage() {
        let storage = Storage.storage()

        let storageRef = storage.reference()
        
        let imagesRef = storageRef.child("frog.jpg")
        
        imagesRef.getData(maxSize: 1_000_000) { data, error in
            
            if error != nil {
                // FEL FEL FEL
            }
            
            if let data = data {
                let uiimage = UIImage(data: data)!
                fancyimage = Image(uiImage: uiimage)
            }
            
        }
    }
    
    func uploadToStorage(uploadimage : Image) {
        
        let smallerImage = uploadimage.resizable().scaledToFit().frame(width: 200, height: 200)
        
        let storage = Storage.storage()

        let storageRef = storage.reference()
        
        let imagesRef = storageRef.child("userselectimage.jpg")
        
        let imagedata = ImageRenderer(content: smallerImage).uiImage!.jpegData(compressionQuality: 0.8)
        
        imagesRef.putData(imagedata!, metadata: nil) { (metadata, error) in
            if error != nil {
                print("Failed")
            } else {
                print("Upload ok")
            }
        }
    }
}

#Preview {
    TestaStorageView()
}
