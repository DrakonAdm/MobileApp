import SwiftUI
import UIKit

struct PersonalizeView: UIViewControllerRepresentable {

    func makeUIViewController(context: Context) -> UIViewController {
        let vc = PersonalizeViewController()
        vc.modalPresentationStyle = .fullScreen
        return vc
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
}
