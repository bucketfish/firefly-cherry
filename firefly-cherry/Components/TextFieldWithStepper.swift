//
//  TextFieldWithStepper.swift
//  firefly-cherry
//
//  Created by Tongyu Jiang on 6/9/23.
//

import SwiftUI

struct TextFieldWithStepper: View {
    @State var title: String
    @Binding var value: Int
    
    var body: some View {
        HStack {
            TextField(title, value: $value, format: .number)
                .textFieldStyle(.roundedBorder)
                .frame(maxWidth: 200)
                .fixedSize(horizontal: true, vertical: false)

            Stepper(title, value: $value)
                .labelsHidden()
        }
    }
}

//struct TextFieldWithStepper_Previews: PreviewProvider {
//    static var previews: some View {
//        TextFieldWithStepper()
//    }
//}
