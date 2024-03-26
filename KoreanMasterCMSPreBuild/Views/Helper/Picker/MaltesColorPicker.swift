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
		case list
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
							Text(color.toColorString)
						}
					}
				} label: {
					Text(color.toColorString)
				}
				.menuStyle(.borderlessButton)
				
			case .list:
				
				ScrollView(.horizontal, showsIndicators: false) {
					HStack {
						ForEach(ColorEnum.allCases) { color in
							Button {
								withAnimation(.easeInOut(duration: 0.1)) {
									self.color = color
								}
							} label: {
								Image(systemName: "checkmark")
									.foregroundStyle(.primary)
									.font(.system(.title3, design: .default, weight: .bold))
									.opacity(self.color == color ? 1 : 0)
									.padding()
									.background {
										RoundedRectangle(cornerRadius: 8)
											.foregroundStyle(color.toColor.gradient)
											.shadow(radius: 2)
									}
							}
							
							.buttonStyle(.plain)
						}
						
					}
					
				}
				
			}
		}
    }
}

#Preview {
	MaltesColorPicker(color: .constant(ColorEnum.blue), colorPickerStyle: .list)
}
