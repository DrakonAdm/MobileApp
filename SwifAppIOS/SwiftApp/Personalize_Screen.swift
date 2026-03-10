import UIKit
import SwiftUI

final class PersonalizeViewController: UIViewController {


    private let backgroundImageView = UIImageView()
    private let titleStackView = UIStackView()
    private let progressBackground = UIView()
    private let progressForeground = UIView()
    private let startButton = UIButton(type: .system)

    private let gradientLayer = CAGradientLayer()


    private let pages = 2
    private var currentPage = 0

    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstraints()
        setupGradient()

        navigationController?.setNavigationBarHidden(true, animated: false)
        navigationItem.hidesBackButton = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        navigationController?.navigationBar.isHidden = true
        navigationController?.navigationBar.tintColor = .clear
        navigationController?.navigationBar.barTintColor = .clear
    }



    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        gradientLayer.frame = view.bounds
    }


    private func setupUI() {
        view.backgroundColor = .black

        backgroundImageView.image = UIImage(named: "personalize")
        backgroundImageView.contentMode = .scaleAspectFill
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(backgroundImageView)

        view.layer.addSublayer(gradientLayer)

        progressBackground.backgroundColor = UIColor.white.withAlphaComponent(0.18)
        progressBackground.layer.cornerRadius = 3
        progressBackground.translatesAutoresizingMaskIntoConstraints = false

        progressForeground.backgroundColor = .white
        progressForeground.layer.cornerRadius = 3
        progressForeground.translatesAutoresizingMaskIntoConstraints = false

        progressBackground.addSubview(progressForeground)
        view.addSubview(progressBackground)

        titleStackView.axis = .vertical
        titleStackView.spacing = 2
        titleStackView.translatesAutoresizingMaskIntoConstraints = false

        let titles = [
            "To personalize your",
            "experience and",
            "connect you to sport,",
            "we've got a few",
            "questions for you."
        ]

        titles.forEach {
            let label = UILabel()
            label.text = $0
            label.font = .systemFont(ofSize: 30, weight: .bold)
            label.textColor = .white
            titleStackView.addArrangedSubview(label)
        }

        view.addSubview(titleStackView)

        startButton.setTitle("Get Started", for: .normal)
        startButton.setTitleColor(.black, for: .normal)
        startButton.backgroundColor = .white
        startButton.titleLabel?.font = .systemFont(ofSize: 18, weight: .semibold)
        startButton.layer.cornerRadius = 27
        startButton.layer.shadowColor = UIColor.black.cgColor
        startButton.layer.shadowOpacity = 0.25
        startButton.layer.shadowRadius = 8
        startButton.layer.shadowOffset = CGSize(width: 0, height: 6)
        startButton.translatesAutoresizingMaskIntoConstraints = false
        startButton.addTarget(self, action: #selector(startTapped), for: .touchUpInside)

        view.addSubview(startButton)
    }

    private func setupGradient() {
        gradientLayer.colors = [
            UIColor.black.withAlphaComponent(0.65).cgColor,
            UIColor.black.withAlphaComponent(0.35).cgColor
        ]
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1.0)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([

            backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),

            progressBackground.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 14),
            progressBackground.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            progressBackground.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.44),
            progressBackground.heightAnchor.constraint(equalToConstant: 6),

            progressForeground.leadingAnchor.constraint(equalTo: progressBackground.leadingAnchor),
            progressForeground.topAnchor.constraint(equalTo: progressBackground.topAnchor),
            progressForeground.bottomAnchor.constraint(equalTo: progressBackground.bottomAnchor),
            progressForeground.widthAnchor.constraint(
                equalTo: progressBackground.widthAnchor,
                multiplier: CGFloat(currentPage + 1) / CGFloat(pages)
            ),

            titleStackView.topAnchor.constraint(equalTo: progressBackground.bottomAnchor, constant: 20),
            titleStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            titleStackView.trailingAnchor.constraint(lessThanOrEqualTo: view.trailingAnchor, constant: -20),

            startButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            startButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            startButton.widthAnchor.constraint(equalToConstant: 220),
            startButton.heightAnchor.constraint(equalToConstant: 54)
        ])
    }


    @objc private func startTapped() {
        let vc = ClothingSectionViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
}
    
