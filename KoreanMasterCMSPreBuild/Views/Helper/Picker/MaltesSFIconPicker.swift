//
//  MaltesSFIconPicker.swift
//  KoreanMasterCMSPreBuild
//
//  Created by Malte Ruff on 24.03.24.
//

import SwiftUI

struct MaltesSFIconPicker: View {
	
	@Binding var selectedIcon: String
	var displayStyle: SelectedIconDisplayStyle
	
	var allSelectedIcons: [String] = [
		"person.fill",
		"heart.fill",
		"paperplane.fill",
		"archivebox.fill",
		"book.pages.fill",
		"character.book.closed.fill",
		"backpack.fill",
		"studentdesk",
		"person.crop.artframe",
		"person.bust.fill",
		"photo.artframe",
		"figure.stand",
		"figure.run",
		"dumbbell.fill",
		"sportscourt.fill",
		"soccerball.inverse",
		"basketball.fill",
		"tennis.racket",
		"skateboard.fill",
		"skis.fill",
		"snowboard.fill",
		"trophy.fill",
		"medal.fill",
		"globe.americas.fill",
		"globe.europe.africa.fill",
		"globe.asia.australia.fill",
		"globe.central.south.asia.fill",
		"zzz",
		"moon.fill",
		"moon.zzz.fill",
		"moon.stars.fill",
		"sparkles",
		"rainbow",
		"flame.fill",
		"suit.club.fill",
		"suit.spade.fill",
		"suit.diamond.fill",
		"star.fill",
		"shield.fill",
		"calendar",
		"quote.closing",
		"scissors",
		"bag.fill",
		"giftcard.fill",
		"wand.and.stars",
		"pianokeys.inverse",
		"paintbrush.pointed.fill",
		"screwdriver.fill",
		"case.fill",
		"suitcase.cart.fill",
		"theatermasks.fill",
		"house.fill",
		"storefront.fill",
		"balloon.fill",
		"laser.burst",
		"fireworks",
		"frying.pan.fill",
		"popcorn.fill",
		"bed.double.fill",
		"sofa.fill",
		"fireplace.fill",
		"tent.fill",
		"mountain.2.fill",
		"hifispeaker.fill",
		"tv",
		"airplane.arrival",
		"car.rear.fill",
		"bus.doubledecker",
		"hare.fill",
		"tortoise.fill",
		"dog.fill",
		"cat.fill",
		"lizard.fill",
		"bird.fill",
		"ant.fill",
		"ladybug.fill",
		"fish.fill",
		"pawprint.fill",
		"teddybear.fill",
		"leaf.fill",
		"tree.fill",
		"crown.fill",
		"shoe.2.fill",
		"movieclapper.fill",
		"eyes.inverse",
		"brain.fill",
		"hands.and.sparkles.fill",
		"photo.fill",
		"gamecontroller.fill",
		"carrot.fill",
		"birthday.cake.fill",
		"wineglass.fill",
		"mug.fill",
		"cup.and.saucer.fill",
		"swatchpalette.fill",
		"gearshift.layout.sixspeed",
		"fork.knife",
		"fossil.shell.fill",
		"ellipsis.curlybraces"
	]
	
	@State var searchText: String = ""
	var filteredIcons: [String] {
		if searchText.isEmpty {
			return allSelectedIcons
		} else {
			return allSelectedIcons.filter { $0.contains(searchText) }
		}
	}
	
	
	@State private var isShowingPicker: Bool = false
	
    var body: some View {
		Button {
			isShowingPicker.toggle()
		} label: {
			VStack {
				switch displayStyle {
				case .small:
					HStack {
						Label {
							if selectedIcon.isEmpty {
								Text("…")
							} else {
								Image(systemName: selectedIcon)
							}
						} icon: {
							Image(systemName: "chevron.down")
								.foregroundStyle(.tint)
						}
					}
				case .medium:
					HStack {
						Label {
							if selectedIcon.isEmpty {
								Text("…")
							} else {
								Image(systemName: selectedIcon)
							}
						} icon: {
							Label {
								Text("Select Icon")
							} icon: {
								Image(systemName: "chevron.down")
									.foregroundStyle(.tint)
							}
						}
					}
				}
			}
		}
		.buttonStyle(.plain)
		.popover(isPresented: $isShowingPicker) {
			MaltesSFIconPickerPopoverView(selectedIcon: $selectedIcon, filteredIcons: filteredIcons)
			.frame(width: 300, height: 500)
			
		}
    }
	enum SelectedIconDisplayStyle {
		case small
		case medium
	}
}


struct MaltesSFIconPickerPopoverView: View {
	
	@Binding var selectedIcon: String

	var filteredIcons: [String]
	
	private let columns = [
		GridItem(.adaptive(minimum: 60))
	]
	
	var body: some View {
		NavigationStack {
			ScrollView {
				LazyVGrid(columns: columns, spacing: 10) {
					ForEach(filteredIcons, id: \.self) { item in
						Button {
							withAnimation {
								selectedIcon = item
							}
						} label: {
							Image(systemName: item)
								.foregroundStyle(.primary)
								.font(.system(.body, design: .rounded, weight: .bold))
								.padding(10)
								.background {
									Circle()
										.foregroundStyle(Color.background)
								}
								.padding(5)
								.background {
									if selectedIcon == item {
										Circle()
											.stroke(lineWidth: 3)
											.foregroundStyle(.tint)
											.shadow(radius: 2)
									}
								}
						}
						.buttonStyle(.plain)
					}
				}
			}
			.padding()
			.navigationTitle("Pick an Icon")
		}
	}
}



#Preview {
	MaltesSFIconPicker(selectedIcon: .constant("book"), displayStyle: .small)
}
