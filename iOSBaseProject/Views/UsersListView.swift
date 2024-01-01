//
//  UsersListView.swift
//  iOSBaseProject
//
//  Created by Nilusha Niwanthaka Wimalasena on 1/1/24.
//

import SwiftUI

struct UsersListView: View {
    
    @StateObject var viewModel = UsersListViewModel(forPreview: false)
    
    var body: some View {
        NavigationView {
            List {
                
                ForEach(viewModel.users) { user in
                    NavigationLink{
                        PostsListView(userId: user.id)
                    } label: {
                        VStack(alignment: .leading) {
                            Text(user.name)
                                .font(.title)
                            Text(user.username)
                                .font(.caption)
                        }
                    }
                }
            }
            .overlay(content: {
                if viewModel.isLoading {
                    ProgressView()
                }
            })
            .alert("Application Error", isPresented: $viewModel.showAlert, actions: {
                Button("OK"){}
            },message: {
                if let errorMessage = viewModel.errorMessage {
                    Text(errorMessage)
                }
            })
            .navigationTitle("Users")
            .listStyle(.plain)
            .task {
                await viewModel.fetchUsers()
            }
        }
    }
}

struct UsersListView_Previews: PreviewProvider {
    static var previews: some View {
        UsersListView()
    }
}
