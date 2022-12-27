//
//  CharacterListView.swift
//  RickAndMorty
//
//  Created by Kris Julio on 12/27/22.
//

import SwiftUI
import CachedAsyncImage

struct CharacterListView: View {
     
    @StateObject var viewModel: CharacterListViewModel
    @State private var showDetails: Bool = false
    
    init(viewModel: CharacterListViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
     
    var body: some View {
        ZStack {
            NavigationView {
                List(viewModel.characters, id: \.self) { item in
                    let cvm = CharacterViewModel(character: item)
                    NavigationLink {
                        CharacterDetailView(viewModel: cvm)
                    } label: {
                        CardView(viewModel: cvm)
                            .onAppear {
                                viewModel.loadMoreContentIfNeeded(item: item)
                            }
                    }
                }
                .listStyle(PlainListStyle())
                .frame(maxWidth: .infinity)
                .navigationBarTitle("Rick & Morty", displayMode: .large)
            }
            .navigationViewStyle(.automatic)
        }
    }
}

 
struct CardView: View {
    let viewModel: CharacterViewModel
    
    var body: some View {
            VStack {
                HStack() {
                    CachedAsyncImage(url: URL(string: viewModel.character.image)) { img in
                        ZStack {
                            img.resizable().aspectRatio(contentMode: .fit)
                        }
                        
                    } placeholder: {
                        Image("pholder")
                    }
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .frame(width: 150, height: 150)
                    .padding()
                         
                    Spacer()
                    
                    VStack {
                        Text(viewModel.character.name)
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                          
                        Text(viewModel.character.species)
                            .font(.title3)
                            .foregroundColor(.orange)
                    }
                    
                    Spacer()
                }
                .frame(maxWidth: .infinity)
            }
            .background(viewModel.character.isFavourite ?? false ? Color(.red.withAlphaComponent(0.4)) : Color(.black))
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .shadow(radius: 10)
    }
}

struct CharacterListView_Previews: PreviewProvider {
    static var previews: some View {
        CharacterListView(viewModel: CharacterListViewModel(service: CharacterService()))
    }
}

