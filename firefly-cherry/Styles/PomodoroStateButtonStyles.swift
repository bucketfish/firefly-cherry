//
//  PomodoroStateButtonStyles.swift
//  firefly-cherry
//
//  Created by Tongyu Jiang on 6/9/23.
//

import Foundation
import SwiftUI

struct PomodoroStateButton: ButtonStyle {
    var selected: Bool = false
    func makeBody(configuration: Configuration) -> some View {
        
        configuration.label
            .padding(.horizontal, 15)
            .padding(.vertical, 10)
            .background(selected ? .white : .clear)
            .cornerRadius(10)
            .font(.title2)
            .contentShape(Rectangle())
            .overlay (
                RoundedRectangle(cornerRadius: 10)
                    .strokeBorder(.white, lineWidth: 2)
            )
            .foregroundColor(selected ? .black : .white)
    }
}



struct PomodoroStateButton_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            Button("test button!") {}
                .buttonStyle(PomodoroStateButton())
        }

    }
}
