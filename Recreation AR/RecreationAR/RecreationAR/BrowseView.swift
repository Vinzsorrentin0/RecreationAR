//
//  BrowseView.swift
//  RecreationAR
//
//  Created by Vincenzo Sorrentino on 14/12/21.
//

import SwiftUI
import CoreAudio

struct BrowseView: View {
    @Binding var ShowBrowse: Bool

    var body: some View {
        NavigationView {
            ScrollView(showsIndicators: false) {
                
//                grid view
                ModelByCategoryGrid(ShowBrowse: $ShowBrowse)
            }
            .navigationBarTitle(Text("Browse"), displayMode: .large)
            .navigationBarItems(trailing:
                                    Button(action: {
                self.ShowBrowse.toggle()
            }){
                Text("Done").bold()
            }
            )
        }
    }
}
       struct ModelByCategoryGrid: View {
           @Binding var ShowBrowse: Bool

           let models = Models ()

          var body: some View {
              VStack {
                  ForEach(ModelCategory.allCases, id: \.self) {
                      category in
                      if let modelsByCategory = models.get(category: category){
                          HorizontalGrid(ShowBrowse: $ShowBrowse, title: category.label, items: modelsByCategory)
                      }
                  }
                  
               }
           }
        }
struct Separator: View {
    var body: some View {
        Divider()
            .padding(.horizontal, 20)
            .padding(.vertical, 10)
    }
}

struct HorizontalGrid: View {
    
    @EnvironmentObject var placementSettings: PlacementSettings
    @Binding var ShowBrowse: Bool

    var title: String
    var items: [Model]
    
    private let gridItemLayout = [GridItem(.fixed(150))]
    var body: some View {
        VStack(alignment: .leading){
            
        Separator()
            
            Text(title)
                .font(.title2).bold()
                .padding(.leading, 22)
                .padding(.top, 10)
            
            ScrollView(.horizontal, showsIndicators: false){
                LazyHGrid(rows: gridItemLayout, spacing: 30) {
                    ForEach(0..<items.count) { index in
                        
                        let model = items[index]
                        ItemButton(model: model) {
                            model.asyncLoadModelEntity()
                            self.placementSettings.selectedModel = model 
                            print("BrowseView selected \(model.name) for placement.")
                            self.ShowBrowse = false
                        }
                    }
                }
                .padding(.horizontal, 22)
                .padding(.vertical, 10)

            }
        }
    }
}

struct ItemButton: View{
    let model: Model
    let action: () -> Void
    
    var body: some View {
        Button(action: {
            self.action()
            
        }){
            Image(uiImage: self.model.thumbnail)
                .resizable()
                .frame(height: 150)
                .aspectRatio(1/1, contentMode: .fit)
                .background(Color(UIColor.secondarySystemFill))
                .cornerRadius(8.0)
    }
}

}
