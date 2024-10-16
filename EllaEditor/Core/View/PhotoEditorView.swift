//
//  PhotoEditorView.swift
//  EllaEditor
//
//  Created by ENMANUEL TORRES on 14/10/24.
//

import SwiftUI

struct PhotoEditorView: View {
    @ObservedObject var viewModel: PhotoEditorViewModel
    @State private var selectedOption: EditingOption? = .adjust
    
    var image : UIImage? {
        if viewModel.editedImage == nil {
            return viewModel.originalImage
        } else {
            return viewModel.editedImage
        }
    }
    var body: some View {
        ZStack {
            Color.black
            VStack{
            
                
                
                Spacer()
                Text(selectedOption == .adjust ? "ADJUST" : "FILTER")
                    .font(.headline)
                    .foregroundColor(.gray)
                
                
               Spacer()
                   
                
                if let image = image {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFit()
                        .cornerRadius(10)
                        .frame(width: 400, height: 400)
                    
                    //.aspectRatio(contentMode: .)
                }
                
                if let option = selectedOption {
                    switch option {
                    case .filters:
                        FiltersSelectionView(viewModel: viewModel)
                    case .adjust:
                        AdjustSelectionView(viewModel: viewModel)
                    }
                }
                
              //  Spacer()
             
                    HStack(spacing: 2){
                        //option buttons
                        OptionButtons(icon: "dial.low.fill", label: "Adjust", isSelected: selectedOption == .adjust) {
                            selectedOption = .adjust
                        }
                        
                        
                        OptionButtons(icon: "camera.filters", label: "Filters", isSelected: selectedOption == .filters) {
                            selectedOption = .filters
                        }
                    }
                Spacer()
                    .frame(height: 10)

            }
            
        }
        .frame(maxHeight: .infinity)
        .ignoresSafeArea(.all)
    }
}

#Preview {
    PhotoEditorView(viewModel: PhotoEditorViewModel(image: UIImage(named: "paris")!))
}
