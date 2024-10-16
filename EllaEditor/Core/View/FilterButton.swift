//
//  FilterButtonView.swift
//  EllaEditor
//
//  Created by ENMANUEL TORRES on 15/10/24.
//

import SwiftUI


struct FilterButton: View {
     var value: Float
    
    var iconName: String
    var label: String
    var selected: Bool
    var action: () -> Void
    
   

    var body: some View {
        Button(action: action) {
            VStack {
                
                if selected {
                    
                    ZStack {
                     
                        Circle()
                            .stroke( Color.white, lineWidth: 3)
                            .frame(width: 35, height: 35)

                        
                        Text("\(Int(value))")
                            .font(.subheadline)
                            .foregroundColor(.white)
                            .padding()
                    }
                    
                }else {
                    Image(systemName: iconName)
                        .font(.title)
                        .foregroundColor(.white)
                        .padding(10)
                        .background(Color.gray.opacity(0.2))
                        .clipShape(Circle())
                }
                
                
                Text(label)
                    .font(.caption)
                    .foregroundColor(.white)
            }
        }
    }
}

#Preview {
    FilterButton(value: 100,
                     iconName: "sun.max.fill",
                     label: "vivid",
                    selected: true,
                     action: {print("pressed button")})
}
