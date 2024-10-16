//
//  OptionButtons.swift
//  EllaEditor
//
//  Created by ENMANUEL TORRES on 14/10/24.
//

import SwiftUI

struct OptionButtons: View {
    var icon: String
    var label: String
    var isSelected: Bool
    var action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack{
                
                    Triangule()
                    .fill(isSelected ? Color.yellow : .black)
                        .frame(width: 15, height: 10)
                
                
                Image(systemName: icon)
                    .font(.title)
                    .foregroundStyle(isSelected ? Color.white : .gray)
                
                Text(label)
                    .font(.caption)
                    .foregroundStyle(isSelected ? Color.white : .gray)
                
            }
        }
        .foregroundColor(.primary)
        .padding()
        
    }
}

#Preview {
    OptionButtons(icon: "dial.low.fill",
                  label: "Filter",
                  isSelected: true,
                  action: {print("Botton pressed")})
}
