//
//  UserMainProfileView.swift
//  KoreanMasterAppPreBuild
//
//  Created by Malte Ruff on 26.03.24.
//

import SwiftUI

struct UserMainProfileView: View {
	
	@EnvironmentObject var loginCon: LoginController
	@AppStorage("selectedTintColor") var selectedTintColor: ColorEnum = .blue
	@AppStorage("hapticsEnabled") var hapticsEnabled: Bool = true

    var body: some View {
		NavigationStack {
			if loginCon.currentFirestoreUser != nil {
				Form {
					Section {
						UserProfileHeaderView()
					}
					
					Section {
						MaltesColorPicker(color: $selectedTintColor, colorPickerStyle: .list)
						
						NavigationLink {
							
						} label: {
							Label("App icon", systemImage: "square.inset.filled")
						}

						
						Toggle(isOn: $hapticsEnabled, label: {
							Label("Haptics", systemImage: "iphone.radiowaves.left.and.right")
						})
					} header: {
						Text("General")
					}
					.onChange(of: hapticsEnabled) { oldValue, newValue in
						playNotificationHaptic(.success)
					}
					
					
					Section {
						NavigationLink {
							
						} label: {
							Label("Help Center", systemImage: "questionmark.circle.fill")
						}

						
						NavigationLink {
							
						} label: {
							Label("Feedback", systemImage: "envelope.fill")
						}

						NavigationLink {
							
						} label: {
							Label("Privacy Policy", systemImage: "lock.fill")
						}
					} header: {
						Text("Other")
					}
					
					Section {
						HStack(alignment: .center) {
							Spacer()
							Text("Made with ❤️ by Malte Ruff in 🇩🇪")
								.foregroundStyle(.secondary)
								.font(.system(.subheadline, design: .rounded, weight: .bold))
							Spacer()
						}
					}
					.listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 5, trailing: 0))
					.listRowBackground(Color.clear)
					
				}
				.navigationTitle("Settings")
				.navigationBarTitleDisplayMode(.inline)
			} else {
				NoUserSettingsView()
			}
		}
    }
}

#Preview {
    UserMainProfileView()
		.withEnvironmentObjects()
}
//
//  UserMainProfileView.swift
//  KoreanMasterAppPreBuild
//
//  Created by Malte Ruff on 26.03.24.
//

import SwiftUI

struct UserMainProfileView: View {
	
	@EnvironmentObject var loginCon: LoginController
	@AppStorage("selectedTintColor") var selectedTintColor: ColorEnum = .blue
	@AppStorage("hapticsEnabled") var hapticsEnabled: Bool = true

    var body: some View {
		NavigationStack {
			if loginCon.currentFirestoreUser != nil {
				Form {
					Section {
						UserProfileHeaderView()
					}
					.listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 5, trailing: 0))
					.listRowBackground(Color.clear)
					
					Section {
						MaltesColorPicker(color: $selectedTintColor, colorPickerStyle: .list)
						
						NavigationLink {
							
						} label: {
							Label("App icon", systemImage: "square.inset.filled")
						}

						
						Toggle(isOn: $hapticsEnabled, label: {
							Label("Haptics", systemImage: "iphone.radiowaves.left.and.right")
						})
					} header: {
						Text("General")
					}
					.onChange(of: hapticsEnabled) { oldValue, newValue in
						playNotificationHaptic(.success)
					}
					
					
					Section {
						NavigationLink {
							
						} label: {
							Label("Help Center", systemImage: "questionmark.circle.fill")
						}

						
						NavigationLink {
							
						} label: {
							Label("Feedback", systemImage: "envelope.fill")
						}

						NavigationLink {
							
						} label: {
							Label("Privacy Policy", systemImage: "lock.fill")
						}
					} header: {
						Text("Other")
					}
					
					Section {
						HStack(alignment: .center) {
							Spacer()
							Text("Made with ❤️ by Malte Ruff in 🇩🇪")
								.foregroundStyle(.secondary)
								.font(.system(.subheadline, design: .rounded, weight: .bold))
							Spacer()
						}
					}
					.listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 5, trailing: 0))
					.listRowBackground(Color.clear)
					
				}
				.navigationTitle("Settings")
				.navigationBarTitleDisplayMode(.inline)
			} else {
				NoUserSettingsView()
			}
		}
    }
}

#Preview {
    UserMainProfileView()
		.withEnvironmentObjects()
}
