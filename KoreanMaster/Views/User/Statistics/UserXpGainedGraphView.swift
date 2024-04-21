//
//  UserXpGainedGraphView.swift
//  KoreanMasterAppPreBuild
//
//  Created by Malte Ruff on 27.03.24.
//

import SwiftUI
import Charts

struct UserXpGainedGraphView: View {
	
	@EnvironmentObject var loginCon: LoginController
	
	
	@State var selectedDate: Date?
	@State var selectedValue: Double?
	var body: some View {
		if let currentUser = loginCon.currentFirestoreUser {
			VStack {
				VStack {
					if let selectedDate = selectedDate, let selectedValue = selectedValue {
						HStack {
							VStack(alignment: .leading) {
								Text("RANGE")
									.font(.system(.caption, design: .rounded, weight: .bold))
									.foregroundStyle(.secondary)
								
								HStack {
									Text("\(Int(selectedValue))")
										.font(.system(.title3, design: .rounded, weight: .semibold))
									
									Image(systemName: "sparkles")
										.foregroundStyle(.yellow.gradient)
										.font(.subheadline)
								}
								
								Text("\(selectedDate, format: .dateTime.day().month(.wide).year())")
									.font(.system(.caption, design: .rounded, weight: .semibold))
									.foregroundStyle(.secondary)
							}
						}
						.padding(4)
						.background {
							RoundedRectangle(cornerRadius: 10)
								.fill(.bar)
						}
					} else {
						HStack {
							VStack(alignment: .leading) {
								Text("RANGE")
									.font(.system(.caption, design: .rounded, weight: .bold))
									.foregroundStyle(.secondary)
								
								
								if let heigestXP = currentUser.streaks.max(by: { $0.xpGained < $1.xpGained}), let lowestXP = currentUser.streaks.min(by: { $0.xpGained < $1.xpGained}) {
									HStack {
										Text("\(heigestXP.xpGained) - \(lowestXP.xpGained)")
											.font(.system(.title3, design: .rounded, weight: .semibold))
										
										Image(systemName: "sparkles")
											.foregroundStyle(.yellow.gradient)
											.font(.subheadline)
									}
								}
								
								
								if let firstDate = currentUser.streaks.first?.date, let lastDate = currentUser.streaks.last?.date {
									Text("\(firstDate, format: .dateTime.day().month()) - \(lastDate, format: .dateTime.day().month(.wide).year())")
										.font(.system(.caption, design: .rounded, weight: .semibold))
										.foregroundStyle(.secondary)
									
								}
							}
							Spacer()
						}
					}
				}
				.frame(height: 50)
				
				
				Chart(currentUser.streaks) { data in
					LineMark(x: .value("Year", data.date),
							 y: .value("Population", data.xpGained))
					.symbol {
						Circle()
							.fill(.tint)
							.frame(width: 8)
					}
				}
				.chartXAxis {
					AxisMarks(values: .stride(by: Calendar.Component.day)) { _ in
						AxisGridLine()
						AxisValueLabel(format: .dateTime.day()) // This formats the labels to show only the day
					}
				}
				.chartYScale(domain: .automatic)
				.chartXScale(domain: Date().addingTimeInterval(-TimeInterval(60*60*24*14))...Date())
				.chartOverlay { proxy in
					GeometryReader { geo in
						Rectangle().fill(.clear).contentShape(Rectangle())
							.gesture(
								DragGesture(minimumDistance: 10)
									.onChanged { value in
										let location = value.location
										let x = location.x - geo[proxy.plotAreaFrame].origin.x
										// Convert the x position to a date using the chart's scale
										let touchDate: Date = proxy.value(atX: x) ?? Date()
										
										// Find the date in your data that is closest to the touchDate
										let closest = currentUser.streaks.min(by: { abs($0.date.timeIntervalSince(touchDate)) < abs($1.date.timeIntervalSince(touchDate)) })
										
										withAnimation {
											if let closestDataPoint = closest {
												selectedDate = closestDataPoint.date
												selectedValue = Double(closestDataPoint.xpGained)
											}
										}
									}
									.onEnded { _ in
										withAnimation {
											selectedDate = nil
											selectedValue = nil
										}
									}
							)
					}
				}
				.frame(height: 200)
			}
		}
	}
}

#Preview {
	UserXpGainedGraphView()
		.withEnvironmentObjects()
		.padding()
}
