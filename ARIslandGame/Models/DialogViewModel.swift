//
//  DialogViewModel.swift
//  ARIslandGame
//
//  Created by Ardelia on 22/05/25.
//

import Foundation
import SwiftUI
import Combine

class DialogViewModel: ObservableObject{
    @Published var currentIndex = 0
    
    let dialogPages : [dialogPage]
    
    init(dialogPages: [dialogPage]) {
        self.dialogPages = dialogPages
    }
    
    func nextPage(){
        if currentIndex < dialogPages.count - 1 {
            currentIndex += 1
        }
    }
    
    func isLastPage() -> Bool {
        return currentIndex == dialogPages.count - 1
    }
    
    func prevPage(){
        if currentIndex > 0 {
            currentIndex -= 1
        }
    }
    
    func isfirstPage() -> Bool{
        return currentIndex == 0
    }
    
}
