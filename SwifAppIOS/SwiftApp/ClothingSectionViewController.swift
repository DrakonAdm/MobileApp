import UIKit
import SwiftUI

struct ClothingRowModel {
    let title: String
    let imageName: String
    var isSelected: Bool
}

final class ClothingSectionViewController: UIViewController {

    private var items: [ClothingRowModel] = [
        .init(title: "Baseball", imageName: "Baseball", isSelected: false),
        .init(title: "Big & Tall", imageName: "Tall", isSelected: false),
        .init(title: "Cross-Training", imageName: "Cross-Training", isSelected: false),
        .init(title: "Dance", imageName: "Dance", isSelected: false),
        .init(title: "Lacrosse", imageName: "Lacrosse", isSelected: false),
        .init(title: "Maternity", imageName: "Maternity", isSelected: false),
        .init(title: "N7", imageName: "N7", isSelected: false),
        .init(title: "Nike Sportswear", imageName: "Sportswear", isSelected: false)
    ]

    private let tableView = UITableView()
    private let nextButton = UIButton(type: .system)
    private let topDivider = UIView()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstraints()
    }

    private func setupUI() {
        view.backgroundColor = .black
        navigationController?.setNavigationBarHidden(true, animated: false)

        topDivider.backgroundColor = UIColor.white.withAlphaComponent(0.8)
        topDivider.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(topDivider)

        tableView.backgroundColor = .black
        tableView.separatorStyle = .none
        tableView.rowHeight = 88
        tableView.contentInset = UIEdgeInsets(
            top: 20,
            left: 0,
            bottom: 120,
            right: 0
        )
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(ClothingCell.self, forCellReuseIdentifier: ClothingCell.id)
        view.addSubview(tableView)

        nextButton.setTitle("Next", for: .normal)
        nextButton.setTitleColor(.black, for: .normal)
        nextButton.backgroundColor = .white
        nextButton.titleLabel?.font = .systemFont(ofSize: 18, weight: .semibold)
        nextButton.layer.cornerRadius = 26
        nextButton.layer.shadowColor = UIColor.black.cgColor
        nextButton.layer.shadowOpacity = 0.25
        nextButton.layer.shadowRadius = 8
        nextButton.layer.shadowOffset = CGSize(width: 0, height: 6)
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        nextButton.addTarget(self, action: #selector(nextTapped), for: .touchUpInside)
        view.addSubview(nextButton)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([

            topDivider.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            topDivider.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            topDivider.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.4),
            topDivider.heightAnchor.constraint(equalToConstant: 3),

            tableView.topAnchor.constraint(equalTo: topDivider.bottomAnchor, constant: 16),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            nextButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            nextButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nextButton.widthAnchor.constraint(equalToConstant: 220),
            nextButton.heightAnchor.constraint(equalToConstant: 52)
        ])
    }

    @objc private func nextTapped() {
        let shopView = ShopScreen()
            .environmentObject(FavoritesManager())
            .environmentObject(BagManager())

        let hosting = UIHostingController(rootView: shopView)

        if let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let window = scene.windows.first {
            window.rootViewController = hosting
            window.makeKeyAndVisible()
        }
    }
}

extension ClothingSectionViewController: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        items.count
    }

    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(
            withIdentifier: ClothingCell.id,
            for: indexPath
        ) as! ClothingCell

        cell.configure(with: items[indexPath.row])
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        items[indexPath.row].isSelected.toggle()
        tableView.reloadRows(at: [indexPath], with: .none)
    }
}
