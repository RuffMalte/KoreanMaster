//
//  MaltesColorPicker.swift
//  KoreanMasterCMSPreBuild
//
//  Created by Malte Ruff on 08.03.24.
//

import SwiftUI

struct MaltesColorPicker: View {
	
	@Binding var color: ColorEnum
	
	var colorPickerStyle: colorPickerStyle
	
	enum colorPickerStyle {
		case menu
		case picker
	}
	
	
    var body: some View {
		VStack {
			switch self.colorPickerStyle {
			case .menu:
				Menu {
					ForEach(ColorEnum.allCases) { color in
						Button {
							self.color = color
						} label: {
							//TODO: Text presentation, since macos cant handle color the menu, find better way
							Text(color.toColorString)

//							Image(systemName: "circle.fill")
//								.foregroundStyle(color.toColor)
						}
					}
				} label: {
					Text(color.toColorString)

//					Image(systemName: "circle.fill")
//						.foregroundStyle(color.toColor)
				}
				.menuStyle(.borderlessButton)
				
			case .picker:
				
				EmptyView()
				
			}
		}
    }
}

#Preview {
	MaltesColorPicker(color: .constant(ColorEnum.blue), colorPickerStyle: .menu)
}
