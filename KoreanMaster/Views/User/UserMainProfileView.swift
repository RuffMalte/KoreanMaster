//
//  UserMainProfileView.swift
//  KoreanMasterAppPreBuild
//
//  Created by Malte Ruff on 26.03.24.
//

import SwiftUI
import Charts

struct UserMainProfileView: View {
	
	@EnvironmentObject var loginCon: LoginController



    var body: some View {
		NavigationStack {
			if let currentUser = loginCon.currentFirestoreUser {
				
				GeometryReader { geo in
					VStack {
						ZStack {
							Rectangle()
								.foregroundStyle(.clear)
								.fadeToClear(startColor: .red.opacity(0.75), endColor: .blue.opacity(0.75), startPoint: .topLeading, endPoint: .bottomTrailing)
								.ignoresSafeArea()


							
							HStack {
								Spacer()
								
								UserProfileDefaultCircleView()
								
								Spacer()
							}
						}
						.frame(width: geo.size.width, height: geo.size.height / 5, alignment: .center)
						
						ScrollView(.vertical) {
							VStack {
								UserProfileSubHeaderView(title: currentUser.displayName) {
									HStack {
										VStack(alignment: .leading, spacing: 5) {
											Label {
												Text("Joined: ") + Text(loginCon.currentFirestoreUser!.createdAt, format: .dateTime.day().month(.wide).year())
											} icon: {
												Image(systemName: "clock.fill")
											}
												
											
											Label {
												Text("Total liked: ") + Text("\(loginCon.currentFirestoreUser!.totalLiked)")
											} icon: {
												Image(systemName: "heart.fill")
											}

											
										}
										.font(.system(.subheadline, design: .rounded, weight: .regular))
										.foregroundStyle(.secondary)
										
										Spacer()
									}
								}
								.padding()
								
								Divider()
								
								UserProfileSubHeaderView(title: "Stats") {
									UserStatisticsView()
								}
								.padding()

								Divider()
								
								UserProfileSubHeaderView(title: "XP Gained") {
									UserXpGainedGraphView()
								}
								.padding()

							}
						}

					}
				}
				.navigationTitle("Profile")
				.navigationBarTitleDisplayMode(.inline)
				.toolbar {
					ToolbarItem(placement: .primaryAction) {
						NavigationLink {
							UserSettingsMainView()
						} label: {
							Label("Settings", systemImage: "gearshape.fill")
								.labelStyle(.iconOnly)
						}

					}
				}
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
