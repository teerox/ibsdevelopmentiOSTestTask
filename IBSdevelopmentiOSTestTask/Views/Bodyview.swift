//
//  Bodyview.swift
//  IBSdevelopmentiOSTestTask
//
//  Created by Mac on 02/10/2022.
//

import SwiftUI

struct Bodyview: View {
    @ObservedObject var viewModel: ViewModel
    let layout = [
        GridItem(.flexible())
    ]
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Text("Search")
                    .font(.title)
                    .bold()
                Spacer()
            }
            HStack {
                TextField("Enter Search Text", text: $viewModel.searchText)
                    .padding(.horizontal, 40)
                    .frame(height: 45, alignment: .leading)
                    .background(Color(.systemGray5))
                    .foregroundColor(Color.black)
                    .clipped()
                    .cornerRadius(10)
                    .overlay(
                        HStack {
                            Image(systemName: "magnifyingglass")
                                .foregroundColor(.gray)
                                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                                .padding(.leading, 16)
                        }
                    )
                Spacer()
            }.padding(.horizontal)
            
            ScrollView(showsIndicators: false) {
                LazyVGrid(columns: layout, spacing: 12) {
                    ForEach(viewModel.searchResult, id: \.login?.uuid) { item in
                        SingleUserView(result: item)
                    }
                }
            }
        }
        .edgesIgnoringSafeArea(.bottom)
        .onAppear {
            viewModel.getAllData()
        }
       
    }
}

struct Bodyview_Previews: PreviewProvider {
    static var previews: some View {
        Bodyview(viewModel: ViewModel())
        Bodyview(viewModel: ViewModel())
            .preferredColorScheme(.dark)
    }
}
