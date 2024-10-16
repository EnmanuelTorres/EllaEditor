//
//  CustomBackButton.swift
//  EllaEditor
//
//  Created by ENMANUEL TORRES on 14/10/24.
//

import SwiftUI

struct CustomBackButton: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    let action: () -> Void

    var body: some View {
        Button(action: {
           
            self.presentationMode.wrappedValue.dismiss()
            self.action()
        }) {
            RoundedRectangle(cornerRadius: 16)
                .foregroundColor(.gray)
                .frame(width: 75,  height: 35)
                .overlay(
                    Text("Cancel")
                        .font(.headline)
                        .fontWeight(.bold)
                        .foregroundColor(Color.black)
                    
                )
        }
        
    }
}

#Preview {
    CustomBackButton( action: {print("Button pressed")})
}
