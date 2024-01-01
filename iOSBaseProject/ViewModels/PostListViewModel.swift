//
//  PostListViewModel.swift
//  iOSBaseProject
//
//  Created by Nilusha Niwanthaka Wimalasena on 1/1/24.
//

import Foundation

class PostListViewModel: ObservableObject {
    @Published var posts: [Post] = []
    var userId: Int?
    @Published var isLoading: Bool = false
    @Published var showAlert: Bool = false
    @Published var errorMessage: String?
    
    func fetchPosts() async {
        if let userId = userId {
            let apiService = ApiService(urlString: "https://jsonplaceholder.typicode.com/users/\(userId)/posts")
            isLoading.toggle()
            defer {
                isLoading.toggle()
            }
            do {
                posts = try await apiService.getJSON()
            } catch {
                showAlert = true
                errorMessage = error.localizedDescription + "\n Please contact the developer"
            }
            
            
//            apiService.getJSON { (result: Result<[Post], APIError>) in
//                switch result {
//                case .success(let posts):
//                    DispatchQueue.main.async {
//                        self.posts = posts
//                    }
//             
//                case .failure(let error):
//                    print(error)
//                    DispatchQueue.main.async {
//                        self.showAlert = true
//                        self.errorMessage = error.localizedDescription + "\n Please contact the developer"
//                    }
//                }
//            }
        }
    }
}

extension PostListViewModel {
    convenience init(forPreview: Bool = false) {
        self.init()
        if forPreview {
            self.posts = Post.mockPosts
        }
    }
}
