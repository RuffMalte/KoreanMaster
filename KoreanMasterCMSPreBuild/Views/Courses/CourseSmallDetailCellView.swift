//
//  CourseSmallDetailCellView.swift
//  KoreanMasterCMSPreBuild
//
//  Created by Malte Ruff on 03.03.24.
//

import SwiftUI

struct CourseSmallDetailCellView: View {
	
	var course: Course
	
	@EnvironmentObject var coursesCon: CoursesController
	
    var body: some View {
		VStack(alignment: .leading) {
			HStack {
				Text(course.getCourseComputedName())
					.font(.title2)
				Spacer()
			}
			
			Text(course.id)
				.font(.caption)
				.foregroundStyle(.secondary)
		}
		.contextMenu {
			Button {
				PasteboardController().copyToPasteboard(string: course.id)
			} label: {
				Label("Copy id", systemImage: "doc.on.doc")
					.labelStyle(.titleAndIcon)
			}
			
			Divider()
			
			Button(role: .destructive) {
				coursesCon.deleteCourse(course: course)
			} label: {
				Label("Delete", systemImage: "trash")
					.foregroundStyle(.red)
					.labelStyle(.titleAndIcon)
			}
		}
    }
}

#Preview {
	CourseSmallDetailCellView(course: Course.detailExample)
}
