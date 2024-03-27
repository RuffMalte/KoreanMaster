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

	struct PetData: Identifiable {
		var id: UUID = UUID()
		var year: Double
		var population: Double
	}
	
	let catData: [PetData] = [PetData(year: 2000, population: 6.8),
							  PetData(year: 2010, population: 8.2),
							  PetData(year: 2015, population: 12.9),
							  PetData(year: 2022, population: 15.2)]

    var body: some View {
		NavigationStack {
			if loginCon.currentFirestoreUser != nil {
				
				GeometryReader { geo in
					VStack {
						ZStack {
							Rectangle()
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
								UserProfileSubHeaderView(title: loginCon.currentFirestoreUser!.displayName) {
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
									Chart(catData) { data in
										LineMark(x: .value("Year", data.year),
												 y: .value("Population", data.population))
									}
									.frame(height: 200)
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
