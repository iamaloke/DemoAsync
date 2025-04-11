//
//  ProductRow.swift
//  DemoAsync
//
//  Created by Alok Kumar on 11/04/25.
//

import SwiftUI

struct ProductRow: View {
    
    var product: Product
    var width: CGFloat = 150
    
    var body: some View {
        VStack(spacing: 10) {
            HStack(alignment: .top, spacing: 10) {
                AsyncImage(url: product.image) { image in
                    image
                        .resizable()
                        .scaledToFit()
                        .frame(width: width, height: width * 1.15)
                } placeholder: {
                    ZStack {
                        Text("")
                            .frame(width: width, height: width * 1.15)
                            .background(Color.gray)
                        
                        Image(systemName: "apple.image.playground")
                            .font(.system(size: 48, weight: .bold))
                            .foregroundStyle(.white)
                    }
                }
                
                VStack(alignment: .leading, spacing: 6) {
                    Text(product.title.capitalized)
                        .modifier(TextModifier())
                        .lineLimit(2)
                        .fontWeight(.bold)
                    
                    Text(product.description)
                        .modifier(TextModifier())
                        .lineLimit(3)
                    
                    Text(product.category.capitalized)
                        .modifier(TextModifier())
                        .fontWeight(.bold)
                    
                    Text("Price: $\(String(format: "%.2f", product.price))")
                        .modifier(TextModifier())
                        .fontWeight(.bold)
                }
                .padding(.bottom, 20)
                
                Spacer()
            }
            .background(.white)
            .padding([.bottom], 15)
        }
        .background(Color.gray.opacity(0.25))
    }
}

#Preview {
    ProductRow(product: Product(id: 0, title: "demo", description: "demo", category: "demo", price: 100, image: URL(string: "https://example.com")!))
}

struct TextModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.system(size: 16, weight: .medium))
    }
}
