//
//  NetworkService.swift
//  NetworkExample
//
//  Created by Vasiliy Shannikov on 05.03.2024.
//

import UIKit

struct NetworkService {
    func fetchData(urlString: String, completion: @escaping (Result<ArticleModel, Error>) -> Void) {
        guard let url = URL(string: urlString) else { return }

        let request = URLRequest(url: url)
        let session = URLSession.shared
        let task = session.dataTask(with: request) { data, _, error in
            guard let data else {
                DispatchQueue.main.async {
                    completion(.failure(error!))

                }

                return
            }

            let decoder = JSONDecoder()
            do {
                let listModels = try decoder.decode(ListModel.self, from: data)
                let model = listModels.articles.first

                DispatchQueue.main.async {
                    completion(.success(model!))
                }

            } catch {
                print(error)
            }
        }

        task.resume()
    }
}
