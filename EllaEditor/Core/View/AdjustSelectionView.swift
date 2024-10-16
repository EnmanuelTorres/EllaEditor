//
//  AdjustSelectionView.swift
//  EllaEditor
//
//  Created by ENMANUEL TORRES on 14/10/24.
//

import SwiftUI

struct AdjustSelectionView: View {
    @ObservedObject var viewModel: PhotoEditorViewModel
    @State private var selectedAdjustment: AdjustmentType = .exposure
    @State private var sliderValue: Float = 0.0 

    var body: some View {
        VStack {
            Text(selectedAdjustment.rawValue)
                .font(.headline)
                .padding(.top)
                .foregroundStyle(Color.white)

            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 25) {
                    ForEach(adjustmentButtons, id: \.type) { button in
                        AdjustmentButton(value: $sliderValue,
                                         range: -100...100,
                                         iconName: button.iconName,
                                         selected: selectedAdjustment == button.type) {
                            selectedAdjustment = button.type
                            sliderValue = viewModel.mapSliderValue(button.currentValue, for: selectedAdjustment)
                        
                        }
                        
                       
                    }
                }
                .padding()
            }
            .background(Color.black.edgesIgnoringSafeArea(.all))

            
            Slider(value: $sliderValue, in: -100...100, step: 1)
                .padding()
                .onChange(of: sliderValue) { oldValue, newValue in
                    viewModel.updateAdjustmentValue(newValue, for: selectedAdjustment)
                }
        }
        .frame(height: 190)
        .background(Color.black)
        .edgesIgnoringSafeArea(.all)
    }

   
    private var adjustmentButtons: [AdjustmentButtonModel] {
        [
            AdjustmentButtonModel(type: .exposure, iconName: "plusminus.circle", currentValue: viewModel.exposure),
            AdjustmentButtonModel(type: .brilliance, iconName: "sun.max.circle.fill", currentValue: viewModel.brilliance),
            AdjustmentButtonModel(type: .highlights, iconName: "sun.haze", currentValue: viewModel.highlights),
            AdjustmentButtonModel(type: .shadows, iconName: "cloud.moon.fill", currentValue: viewModel.shadows),
            AdjustmentButtonModel(type: .contrast, iconName: "circle.lefthalf.fill", currentValue: viewModel.contrast),
            AdjustmentButtonModel(type: .brightness, iconName: "sun.max", currentValue: viewModel.brightness),
            AdjustmentButtonModel(type: .saturation, iconName: "drop.fill", currentValue: viewModel.saturation),
            AdjustmentButtonModel(type: .blackPoint, iconName: "smallcircle.filled.circle.fill", currentValue: viewModel.blackPoint),
            AdjustmentButtonModel(type: .vibrance, iconName: "circle.hexagongrid.fill", currentValue: viewModel.vibrance),
            AdjustmentButtonModel(type: .warmth, iconName: "thermometer.sun.fill", currentValue: viewModel.warmth),
            AdjustmentButtonModel(type: .tint, iconName: "eyedropper.halffull", currentValue: viewModel.tint)
        ]
    }
    
     
}

// Modelo para almacenar información de los botones de ajuste
struct AdjustmentButtonModel {
    let type: AdjustmentType
    let iconName: String
    let currentValue: Float
}

#Preview {
    AdjustSelectionView(viewModel: PhotoEditorViewModel(image: UIImage(named: "paris")!))
}
