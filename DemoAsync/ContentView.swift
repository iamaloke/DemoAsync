//
//  ContentView.swift
//  DemoAsync
//
//  Created by Alok Kumar on 11/04/25.
//

import SwiftUI

struct ContentView: View {
    
    @State private var selectedProduct: Product?
    @StateObject var viewModel = ViewModel()
    
    var body: some View {
        GeometryReader { geo in
            NavigationStack {
                List {
                    Section(
                        header: VStack {
                            Divider()
                                .background(Color.gray)
                                .frame(height: 1)
                            
                            Text("Top Picks").font(.title2)
                            
                            Divider()
                                .background(Color.black)
                                .frame(height: 1)
                        }
                            .listRowInsets(EdgeInsets())
                    ) {
                        ForEach(viewModel.products) { product in
                            ProductRow(product: product, width: geo.size.width * 0.3)
                                .contentShape(Rectangle()) // Full row tappable
                                .onTapGesture {
                                    selectedProduct = product
                                }
                                .listRowInsets(EdgeInsets(top: 20, leading: 0, bottom: 0, trailing: 0))
                                .listRowSeparator(.hidden)
                        }
                    }
                }
                .navigationTitle("Products")
                .listStyle(.plain)
                .navigationDestination(item: $selectedProduct) { product in
                    ProductDetail(product: product)
                }
                .task {
                    await viewModel.getProducts()
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
