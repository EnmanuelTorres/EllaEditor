//
//  ChoosePhotoView.swift
//  EllaEditor
//
//  Created by ENMANUEL TORRES on 14/10/24.
//

import SwiftUI
import PhotosUI

struct ChoosePhotoView: View {
    @State private var selectedItem: PhotosPickerItem? = nil
    @State private var isNavigating = false
    @StateObject private var viewModel = PhotoEditorViewModel(image: nil)
    
    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                displayPlaceholderImage()
                
                choosePhotoButton()
                    .onChange(of: selectedItem) { oldValue, newValue in
                        Task {
                            if let data = try? await newValue?.loadTransferable(type: Data.self),
                               let uiImage = UIImage(data: data) {
                                viewModel.originalImage = uiImage
                                viewModel.editedImage = uiImage
                                isNavigating = true
                            }
                        }
                    }
                
                Spacer()
                    .frame(height: 30)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.black)
            .edgesIgnoringSafeArea(.all)
            .navigationDestination(isPresented: $isNavigating) {
                if selectedItem != nil {
                    SelectedPhotoView(viewModel: viewModel)
                        .navigationBarBackButtonHidden()
                        .transition(.move(edge: .top))
                    
                }
            }
        }
    }
    
    @ViewBuilder
    private func displayPlaceholderImage() -> some View {
        Image("ChoosePhoto")
            .resizable()
            .scaledToFit()
            .cornerRadius(10)
            .frame(width: 400, height: 400)
            .padding(.bottom, 30)
    }
    
    @ViewBuilder
    private func choosePhotoButton() -> some View {
        PhotosPicker(selection: $selectedItem, matching: .images) {
            HStack {
                Text("Choose a photo")
                    .font(.title)
                    .foregroundColor(.blue)
                    .padding(.leading, 10)
                
                Image(systemName: "camera.aperture")
                    .font(.title)
                    .foregroundColor(.blue)
                    .padding(10)
                    .clipShape(Circle())
            }
            .padding(10)
            .background(Color.gray.opacity(0.2))
            .clipShape(Capsule())
            .overlay(Capsule().stroke(Color.blue, lineWidth: 2))
        }
    }
}

#Preview {
    ChoosePhotoView()
}
