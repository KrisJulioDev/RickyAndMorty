//
//  CharacterDetailView.swift
//  RickAndMorty
//
//  Created by Kris Julio on 12/27/22.
//

import SwiftUI
import CachedAsyncImage

struct CharacterDetailView: View {
    @StateObject var viewModel: CharacterViewModel
    @State var showCharDetails : Bool = false
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    init(viewModel: CharacterViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
            VStack {
                CachedAsyncImage(url: URL(string: viewModel.character.image)) { img in
                    img.resizable().aspectRatio(contentMode: .fit)
                } placeholder: {
                    Image("pholder")
                }
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .frame(maxWidth: .infinity)
                .padding(.horizontal)
                .shadow(radius: 10)
                
                List {
                    VStack(alignment: .leading, spacing: 2) {
                        Text("Character Information")
                            .font(.title2)
                            .foregroundColor(.orange)
                            .fontWeight(.bold)
                            .frame(maxWidth: .infinity, alignment: .center)
                            .frame(height: 20, alignment: .top)
                            .padding()
                        InfoTile(title: "Name: ", desc: viewModel.character.name)
                        InfoTile(title: "Gender: ", desc: viewModel.character.gender)
                        InfoTile(title: "Status: ", desc: viewModel.character.status)
                        InfoTile(title: "Species: ", desc: viewModel.character.species)
                        InfoTile(title: "Type: ", desc: viewModel.character.type)
                        InfoTile(title: "Origin: ", desc: viewModel.character.origin?.name ?? "N/A")
                        InfoTile(title: "Location: ", desc: viewModel.character.location?.name ?? "N/A")
                        Spacer()
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color.black)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                
                Spacer()
        }
    }
}

struct InfoTile: View {
    let title: String
    let desc: String
    
    var body: some View {
        HStack {
            Text(title).font(.body).foregroundColor(.gray)
            Text(desc).font(.body).foregroundColor(.gray).fontWeight(.bold)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        .clipShape(RoundedRectangle(cornerRadius: 5))
        .padding(.horizontal)
    }
}
