//
//  EditButton.swift
//  BookLog
//
//  Created by Jay Lee on 2020/10/27.
//

import SwiftUI

struct EditButton: View {
    @Binding var editMode: EditMode

    var body: some View {
        Button {
            switch editMode {
            case .active: editMode = .inactive
            case .inactive: editMode = .active
            default: break
            }
        } label: {
            if let isEditing = editMode.isEditing, isEditing {
                Text("Done")
            } else {
                Text("Edit")
            }
        }
    }
}
