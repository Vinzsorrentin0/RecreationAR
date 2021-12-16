//
//  Model.swift
//  RecreationAR
//
//  Created by Vincenzo Sorrentino on 14/12/21.
//

import SwiftUI
import RealityKit
import Combine

enum ModelCategory: CaseIterable {
 case first
    case second
    case third
    case fourth
    
    var label: String {
        get {
            switch self {
            case .first:
                return "First"
            case .second:
                return "Second"
            case .third:
                return "Third"
            case .fourth:
                return "Fourth"
            }
        }
    }
}

class Model {
    var name: String
    var category: ModelCategory
    var thumbnail: UIImage
    var modelEntity: ModelEntity?
    var scaleCompensation: Float
    
    private var cancellable: AnyCancellable?
    
    init(name: String, category: ModelCategory, scaleCompensation: Float = 1.0) {
        self.name = name
        self.category = category
        self.thumbnail = UIImage(named: name) ?? UIImage (systemName: "photo")!
        self.scaleCompensation = scaleCompensation
    }
    
    func asyncLoadModelEntity() {
        let filename = self.name + ".usdz"
        
        self.cancellable = ModelEntity.loadModelAsync(named: filename)
            .sink(receiveCompletion: { loadCompletion in
                
                switch loadCompletion {
                case .failure(let error): print("Unable to load modelEntity for \(filename). Error: \(error.localizedDescription)")
                case .finished:
                    break
                }
            }, receiveValue: { modelEntity in
                
                self.modelEntity = modelEntity
                self.modelEntity?.scale *= self.scaleCompensation
                
                print("modelEntity for \(self.name) has been loaded.")
            })
    }
}

struct Models {
    var all: [Model] = []
    
    init() {
        //        1
        let Apple = Model(name: "Apple", category: .first, scaleCompensation: 2/100)
        self.all += [Apple]
        
        //        2
                let Cabbage = Model(name: "Cabbage", category: .second, scaleCompensation: 50/100)
        self.all += [Cabbage]

        //        3
        let Cake = Model(name: "Cake", category: .third, scaleCompensation: 60/100)
        self.all += [Cake]

        //        4
                let Potion = Model(name: "Potion", category: .fourth, scaleCompensation: 3/100)
        
        self.all += [Potion]
    }
    
    func get(category: ModelCategory) -> [Model] {
        return all.filter( {$0.category == category} )
    }
}
