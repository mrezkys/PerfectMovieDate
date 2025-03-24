//
//  ModalViewController.swift
//  PerfectMovieDate
//
//  Created by Muhammad Rezky on 24/03/25.
//

import UIKit

class ModalViewController: UIViewController {
    // UI Components
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 12
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.2
        view.layer.shadowOffset = CGSize(width: 0, height: 2)
        view.layer.shadowRadius = 4
        return view
    }()
    
    private let movieImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textAlignment = .center
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let cancelButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Cancel", for: .normal)
        button.setTitleColor(.red, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let agreeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Agree", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 8
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // Closure properties
    private let onCancel: (() -> Void)?
    private let onAgree: (() -> Void)?
    
    // Initializer
    init(
        image: UIImage?,
        title: String,
        agreeTitle: String? = nil,
        cancelTitle: String? = nil,
        onCancel: (() -> Void)? = nil,
        onAgree: (() -> Void)? = nil
    ) {
        self.onCancel = onCancel
        self.onAgree = onAgree
        super.init(nibName: nil, bundle: nil)
        
        // Configure view
        modalPresentationStyle = .overCurrentContext
        modalTransitionStyle = .crossDissolve
        
        // Set image and title
        movieImageView.image = image
        titleLabel.text = title
        
        if let agreeTitle = agreeTitle {
            agreeButton.setTitle(agreeTitle, for: .normal)
        }
        
        
        if let cancelTitle = cancelTitle {
            cancelButton.setTitle(cancelTitle, for: .normal)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBackground()
        setupViews()
        setupConstraints()
        setupActions()
    }
    
    private func setupBackground() {
        view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
    }
    
    private func setupViews() {
        view.addSubview(containerView)
        containerView.addSubview(movieImageView)
        containerView.addSubview(titleLabel)
        containerView.addSubview(cancelButton)
        containerView.addSubview(agreeButton)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            // Container View
            containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            containerView.widthAnchor.constraint(equalToConstant: 300),
            containerView.heightAnchor.constraint(equalToConstant: 400),
            
            // Movie Image
            movieImageView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 20),
            movieImageView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            movieImageView.widthAnchor.constraint(equalToConstant: 250),
            movieImageView.heightAnchor.constraint(equalToConstant: 250),
            
            // Title Label
            titleLabel.topAnchor.constraint(equalTo: movieImageView.bottomAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),
            
            // Buttons
            cancelButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -20),
            cancelButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            
            agreeButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -20),
            agreeButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),
            agreeButton.widthAnchor.constraint(equalToConstant: 100),
            agreeButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    private func setupActions() {
        cancelButton.addTarget(self, action: #selector(cancelTapped), for: .touchUpInside)
        agreeButton.addTarget(self, action: #selector(agreeTapped), for: .touchUpInside)
        
        // Add tap gesture to dismiss when tapping outside the container
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(backgroundTapped))
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc private func cancelTapped() {
        onCancel?()
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func agreeTapped() {
        onAgree?()
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func backgroundTapped(_ gesture: UITapGestureRecognizer) {
        let location = gesture.location(in: view)
        if !containerView.frame.contains(location) {
            dismiss(animated: true, completion: nil)
        }
    }
}
