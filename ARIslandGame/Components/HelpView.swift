//
//  HelpView.swift
//  ARIslandGame
//
//  Created by Ardelia on 23/05/25.
//

import Foundation
import SwiftUI


struct HelpView: View {
    @ObservedObject var viewModel: DialogViewModel
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationView {
            List(viewModel.dialogPages) { page in
                VStack(alignment: .leading, spacing: 8) {
//                    Text(page.title)
//                        .font(.headline)
                    
                    Text(page.description)
                        .font(.subheadline)
                }
                .padding(.vertical, 4)
            }
            .navigationTitle("Hint")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Close") {
                        dismiss()
                    }
                }
            }
        }
    }
}

#Preview{
  HelpView(viewModel: DialogViewModel())
}
