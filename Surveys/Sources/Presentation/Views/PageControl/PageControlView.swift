//
//  PageControlView.swift
//  Surveys
//
//  Created by David Bui on 13/12/2022.
//  Copyright © 2022 Nimble. All rights reserved.
//

import SwiftUI

struct PageControlView: UIViewRepresentable {

    final class Coordinator: NSObject {

        var control: PageControlView

        init(_ control: PageControlView) {
            self.control = control
        }

        @objc func updateCurrentPage(sender: UIPageControl) {
            guard control.currentPage != sender.currentPage else { return }
            control.currentPage = sender.currentPage
        }
    }

    @Binding var currentPage: Int
    var numberOfPages: Int

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    func makeUIView(context: Context) -> UIPageControl {
        let pageControl = UIPageControl()
        pageControl.backgroundStyle = .minimal
        pageControl.currentPage = currentPage
        pageControl.numberOfPages = numberOfPages
        pageControl.addTarget(
            context.coordinator,
            action: #selector(Coordinator.updateCurrentPage(sender:)),
            for: .valueChanged
        )
        return pageControl
    }

    func updateUIView(_ pageControl: UIPageControl, context: Context) {
        pageControl.currentPage = currentPage
        pageControl.numberOfPages = numberOfPages
    }
}
