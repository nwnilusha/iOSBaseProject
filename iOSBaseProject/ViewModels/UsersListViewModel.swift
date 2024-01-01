//
//  UsersListViewModel.swift
//  iOSBaseProject
//
//  Created by Nilusha Niwanthaka Wimalasena on 1/1/24.
//

import Foundation

class UsersListViewModel: ObservableObject {
    @Published var users: [User] = []
    @Published var isLoading: Bool = false
    @Published var showAlert: Bool = false
    @Published var errorMessage: String?
    
    @MainActor
    func fetchUsers() async {
        let apiService = ApiService(urlString: "https://jsonplaceholder.typicode.com/users")
        isLoading.toggle()
        defer {
            isLoading.toggle()
        }
        do {
            users = try await apiService.getJSON()
        } catch {
            showAlert = true
            errorMessage = error.localizedDescription + "\n Please contact the developer"
        }
        
//        apiService.getJSON { (result: Result<[User], APIError>) in
//            defer {
//                DispatchQueue.main.async {
//                    self.isLoading.toggle()
//                }
//            }
//            switch result {
//            case .success(let users):
//                DispatchQueue.main.async {
//                    self.users = users
//                }
//
//            case .failure(let error):
//                print(error)
//                DispatchQueue.main.async {
//                    self.showAlert = true
//                    self.errorMessage = error.localizedDescription + "\n Please contact the developer"
//                }
//            }
//        }
    }
}

extension UsersListViewModel {
    convenience init(forPreview: Bool = false) {
        self.init()
        if forPreview {
            self.users = User.mockUsers
        }
    }
}
