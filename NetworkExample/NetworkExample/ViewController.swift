//
//  ViewController.swift
//  NetworkExample
//
//  Created by Vasiliy Shannikov on 05.03.2024.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    private var article: ArticleModel?
    private let loader = UIActivityIndicatorView(style: .large)
    private lazy var service = NetworkService()

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 22, weight: .semibold)
        label.isHidden = true
        label.numberOfLines = 0
        
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        [loader, titleLabel].forEach { view.addSubview($0) }


        loader.hidesWhenStopped = true
        loader.startAnimating()
        setupConstraints()

        service.fetchData(urlString: "https://newsapi.org/v2/everything?q=apple&from=2024-03-04&to=2024-03-04&sortBy=popularity&apiKey=0cab1c880a58484fb199721d9d1eb541") { [weak self] result in
            guard let self else { return }
            
            switch result {
            case .success(let model):
                self.loader.stopAnimating()
                self.article = model
                self.setupView(with: model)
            case .failure(_):
                print("Error")
            }
        }
    }

    private func setupConstraints() {
        loader.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }

        titleLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }
    }

    private func setupView(with model: ArticleModel) {
        titleLabel.text = model.title
        titleLabel.isHidden = false
    }

}

