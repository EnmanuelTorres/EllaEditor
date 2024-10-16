//
//  SelectedPhotoView.swift
//  EllaEditor
//
//  Created by ENMANUEL TORRES on 14/10/24.
//

import SwiftUI

struct SelectedPhotoView: View {
    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>
    
    @ObservedObject var viewModel: PhotoEditorViewModel
    @State private var isExpanded: Bool = false
    @State private var editPhoto: Bool = false
    
    var image: UIImage {
        viewModel.originalImage!
    }
    
    var body: some View {
        
        ZStack {
            Color.black
                .ignoresSafeArea(.all)
            
            VStack {
                Spacer()
                
                photoView
 
                Spacer()
                
                if !isExpanded {
                    
                    HStack(alignment: .top) {
                        Spacer()
                            .frame(width: 160)
                        Button(action: {
                            
                            print("Open photoEditorView")
                            editPhoto.toggle()
                            print(editPhoto.description)
                            
                        }) {
                            Image(systemName: "slider.horizontal.3")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 20, height: 20)
                                .foregroundColor(.blue)
                                .padding()
                        }
                        .background(Color.white.opacity(0.2))
                        .clipShape(Capsule())
                        
                        Spacer()
                            .frame(width: 90)
                        
                        Button(action: {
                            print("Remove image")
                            presentationMode.wrappedValue.dismiss()
                        }) {
                            Image(systemName: "trash")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 20, height: 20)
                                .foregroundColor(.blue)
                                .padding()
                        }
                        .background(Color.white.opacity(0.2))
                        .clipShape(Circle())
                    }
                    Spacer()
                        .frame(height: 10)
                }
            }
        }
        .navigationDestination(isPresented: $editPhoto) {
            PhotoEditorView(viewModel: viewModel)
                .navigationBarBackButtonHidden()
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        CustomBackButton{
                            viewModel.editedImage = nil
                        }
                    }
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button(action: {
                            // replace original photo with edited photo
                           
                            viewModel.originalImage = viewModel.editedImage
                            viewModel.resetFilters()
                            editPhoto.toggle()
                            
                        }) {
                            RoundedRectangle(cornerRadius: 16)
                                .foregroundColor(.yellow)
                                .frame(width: 75,  height: 35)
                                .opacity(!viewModel.hasChanges ? 0.6 : 1)
                                .overlay(
                                    Text("Done")
                                        .font(.headline)
                                        .fontWeight(.bold)
                                        .foregroundColor(Color.black)
                                        .opacity(!viewModel.hasChanges ? 0.6 : 1)
                                    
                                )
                            
                        }
                        .disabled(!viewModel.hasChanges)
                    }
                }
            
        }
    }
    
    private var photoView: some View {
        Image(uiImage: viewModel.originalImage ?? UIImage())
            .resizable()
            .scaledToFit()
            .cornerRadius(isExpanded ? 0 : 10)
            .frame(width: isExpanded ? UIScreen.main.bounds.width : 400,
                   height: isExpanded ? UIScreen.main.bounds.height : 400)
            .onTapGesture {
                withAnimation {
                    isExpanded.toggle()
                }
            }
    }
}



#Preview {
    SelectedPhotoView(viewModel: PhotoEditorViewModel(image: UIImage(named: "paris")))
}
