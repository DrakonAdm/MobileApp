import SwiftUI
import UIKit

// MARK: - CategoryTableView (UITableView inside SwiftUI)

struct CategoryTableView: UIViewRepresentable {

    let items: [String]
    @Binding var selectedIndex: Int

    func makeUIView(context: Context) -> UITableView {
        let table = UITableView()
        table.separatorStyle = .none
        table.backgroundColor = .clear
        table.rowHeight = 50
        table.dataSource = context.coordinator
        table.delegate = context.coordinator
        table.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        return table
    }

    func updateUIView(_ uiView: UITableView, context: Context) {
        uiView.reloadData()
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    final class Coordinator: NSObject, UITableViewDataSource, UITableViewDelegate {

        let parent: CategoryTableView

        init(_ parent: CategoryTableView) {
            self.parent = parent
        }

        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            parent.items.count
        }

        func tableView(
            _ tableView: UITableView,
            cellForRowAt indexPath: IndexPath
        ) -> UITableViewCell {

            let cell = tableView.dequeueReusableCell(
                withIdentifier: "Cell",
                for: indexPath
            )

            cell.textLabel?.text = parent.items[indexPath.row]
            cell.textLabel?.textColor =
                indexPath.row == parent.selectedIndex ? .black : .gray
            cell.backgroundColor = .clear

            return cell
        }

        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            parent.selectedIndex = indexPath.row
        }
    }
}

// MARK: - ProductCollectionView (UICollectionView inside SwiftUI)

struct ProductCollectionView: UIViewRepresentable {

    let images: [String]

    func makeUIView(context: Context) -> UICollectionView {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 160, height: 200)
        layout.minimumLineSpacing = 12

        let collection = UICollectionView(
            frame: .zero,
            collectionViewLayout: layout
        )

        collection.backgroundColor = .clear
        collection.showsHorizontalScrollIndicator = false
        collection.dataSource = context.coordinator
        collection.register(
            UICollectionViewCell.self,
            forCellWithReuseIdentifier: "Cell"
        )

        return collection
    }

    func updateUIView(_ uiView: UICollectionView, context: Context) {
        uiView.reloadData()
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    final class Coordinator: NSObject, UICollectionViewDataSource {

        let parent: ProductCollectionView

        init(_ parent: ProductCollectionView) {
            self.parent = parent
        }

        func collectionView(
            _ collectionView: UICollectionView,
            numberOfItemsInSection section: Int
        ) -> Int {
            parent.images.count
        }

        func collectionView(
            _ collectionView: UICollectionView,
            cellForItemAt indexPath: IndexPath
        ) -> UICollectionViewCell {

            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: "Cell",
                for: indexPath
            )

            cell.contentView.subviews.forEach { $0.removeFromSuperview() }

            let imageView = UIImageView(
                image: UIImage(named: parent.images[indexPath.item])
            )
            imageView.contentMode = .scaleAspectFill
            imageView.clipsToBounds = true
            imageView.frame = cell.contentView.bounds
            imageView.layer.cornerRadius = 12

            cell.contentView.addSubview(imageView)
            return cell
        }
    }
}

