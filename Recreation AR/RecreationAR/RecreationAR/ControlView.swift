//
//  ControlView.swift
//  RecreationAR
//
//  Created by Vincenzo Sorrentino on 14/12/21.
//

import SwiftUI

struct ControlView: View {
    @Binding var isControlsVisible: Bool
    @Binding var showBrowse: Bool
    
    var body: some View {
        VStack {
            
            ControlVisibilityToggleButton(isControlsVisible: $isControlsVisible)
            
            Spacer()
            
            if isControlsVisible {
               ControlButtonBar(showBrowse: $showBrowse)
            }
        }
    }
}

// Turn ON/OFF the Navigation bar with this toggle

struct ControlVisibilityToggleButton: View {
    @Binding var isControlsVisible: Bool
    
    var body: some View {
        HStack {
            
            Spacer()
            
            ZStack {
                Color.black.opacity(0.25)
                Button(action: {
                    print("Control Visibility Button pressed.")
                    self.isControlsVisible.toggle()
                }){
                    Image (systemName: self.isControlsVisible ? "rectangle" : "slider.horizontal.below.rectangle")
                        .font(.system(size: 25))
                        .foregroundColor(.white)
                        .buttonStyle(PlainButtonStyle())
                }
            }
            
            .frame(width: 50, height: 50)
            .cornerRadius(8.0)
            
        }
        .padding(.top, 45)
        .padding(.trailing, 20)
    }
}
// Navigation Menu Browse and Setting

struct ControlButtonBar: View {
    
    @Binding var showBrowse: Bool
    
    var body: some View {
        HStack {
            
            ControlButton(systemIconName: "square.grid.2x2") {
                print("Browse button pressed.")
                self.showBrowse.toggle()
            }.sheet(isPresented: $showBrowse, content: {
                //                Browse View
                BrowseView(ShowBrowse: $showBrowse)
            })
            
            Spacer()
            
            ControlButton(systemIconName: "slider.horizontal.3") {
                print("Setting button pressed.")
            }
            
        }
        .frame(maxWidth: 500)
        .padding(30)
        .background(Color.black.opacity(0.25))
    }
}

struct ControlButton: View {
    
    let systemIconName: String
    let action: () -> Void
    
    var body: some View {
        
        Button(action: {
            self.action()
        }) {
            Image(systemName: systemIconName)
                .font(.system(size:35))
                .foregroundColor(.white)
                .buttonStyle(PlainButtonStyle())
        }
        .frame(width: 50, height:50)
    }
}
