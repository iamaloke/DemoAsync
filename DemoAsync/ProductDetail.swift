//
//  ProductDetail.swift
//  DemoAsync
//
//  Created by Alok Kumar on 11/04/25.
//

import SwiftUI

struct ProductDetail: View {
    
    var product: Product
    var width: CGFloat = 250
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            AsyncImage(url: product.image) { image in
                HStack(alignment: .center) {
                    image
                        .resizable()
                        .scaledToFit()
                        .frame(height: 240)
                }
                .frame(maxWidth: .infinity)
            } placeholder: {
                Rectangle()
                    .frame(maxWidth: .infinity)
                    .frame(height: 240)
                    .foregroundColor(.gray.opacity(0.5))
            }
            
            ScrollView {
                VStack(alignment: .leading, spacing: 6) {
                    ProductSpecific(key: "Name", value: product.title.capitalized)
                    
                    ProductSpecific(key: "Description", value: product.description)
                    
                    ProductSpecific(key: "Category", value: product.category)
                    
                    ProductSpecific(key: "Price", value: "$\(String(format: "%.2f", product.price))")
                }
            }
            .padding(.bottom, 20)
            
            Spacer()
            
            HStack(spacing: 10) {
                Button {
                    
                } label: {
                    Text("Buy Now")
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                }
                
                Button {
                    
                } label: {
                    Text("Add to cart")
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                }
            }
            .padding(.bottom)
        }
        .padding()
    }
}

#Preview {
    ProductDetail(product: Product(id: 0, title: "demo", description: "demo", category: "demo", price: 100, image: URL(string: "https://example.com")!))
}

struct ProductSpecific: View {
    var key: String
    var value: String
    
    var body: some View {
        HStack(alignment: .top, spacing: 10) {
            Text(key)
                .modifier(TextModifier())
                .lineLimit(1)
                .fontWeight(.bold)
                .frame(width: 100, alignment: .leading)
            
            Text(value)
                .modifier(TextModifier())
                .fontWeight(.regular)
        }
    }
}
