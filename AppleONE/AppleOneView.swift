//
//  AppleOneView.swift
//  AppleONE
//
//  Created by Darío González Martínez on 01/11/2020.
//

import SwiftUI

struct AppleOneView: View {
    @Environment(\.colorScheme) var colorScheme
    @State var selected = 1
    
    var body: some View {
        ZStack {
            
            if (colorScheme == .dark) {
                Color(.secondarySystemGroupedBackground)
                    .ignoresSafeArea(.all, edges: .all)
            } else {
                Color(.tertiarySystemGroupedBackground)
                    .ignoresSafeArea(.all, edges: .all)
            }
            
            VStack {
                HStack {
                    Spacer()
                    Image(systemName: "xmark.circle.fill")
                        .padding([.trailing])
                        .font(.title)
                        .foregroundColor(.gray)
                }
                .padding(.bottom)
                HStack {
                    Image(systemName: "applelogo")
                        .font(.system(size: 30))
                    Text("One")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                }
                .padding(.bottom, 4)
                Text("Disfruta de millones de canciones, más de ciem juegos, programas y películas Apple Originals y mucho más. Y ahorra cuando lo unes todo en un pack.")
                    .multilineTextAlignment(.center)
                    .fixedSize(horizontal: false, vertical: true)
                    .padding(.horizontal, 32)
                    .padding(.bottom)
                CategoryPanel(selected: $selected, index: 0, nombre: "Individual", precio: "14,95")
                    .padding(.bottom, 6)
                CategoryPanel(selected: $selected, index: 1, nombre: "Familiar", precio: "19,95")
                Spacer()
                Text("1 mes gratis, luego \(selected == 0 ? "14,95" : "19,95")€ al mes")
                    .font(.subheadline)
                    .foregroundColor(Color.gray)
                Button(action: {}) {
                    Text("Empezar prueba gratuita")
                        .fontWeight(.semibold)
                        .foregroundColor(Color.white)
                        .padding(.horizontal, 64)
                        .padding(.vertical)
                        .background(Color.blue)
                        .cornerRadius(16)
                }
            }
        }
    }
}


struct CategoryPanel: View {
    @Environment(\.colorScheme) var colorScheme
    @Namespace private var animation
    @Binding var selected: Int
    let index: Int
    let nombre: String
    let precio: String
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(nombre)
                    .font(.title3)
                    .fontWeight(.bold)
                    .padding(.bottom, 4.0)
                Spacer()
                Image(systemName: selected == index ? "checkmark.circle.fill" : "circle")
                    .resizable()
                    .frame(width: 22, height: 22, alignment: .center)
                    .foregroundColor(selected == index ? .blue : .gray)
            }
            Text("1 mes gratis, luego \(precio) € al mes")
                .font(.callout)
                .padding(.bottom, 2.0)
            Text("Tus suscripciones no son compatibles con el modo de prueba.")
                .fixedSize(horizontal: false, vertical: true)
                .font(.footnote)
                .foregroundColor(Color.gray)
            if (index == 1) {
                HStack(alignment: .center) {
                    Image(systemName: "star.fill")
                        .foregroundColor(.blue)
                    Text("RECOMENDADO")
                        .fontWeight(.bold)
                        .foregroundColor(.gray)
                }.padding(.vertical, 2.0).font(.caption)
            }
            if (selected == index) {
                Divider()
                VStack(alignment: .leading) {
                    ServiceLabel(namespace: animation, name: "applemusic", description: "Más de 70 millones de canciones sin anuncios")
                    ServiceLabel(namespace: animation, name: "appletv", description: "Programas y películas Apple Origianls")
                    ServiceLabel(namespace: animation, name: "applearcade", description: "Más de 100 juegos sin anuncios")
                    ServiceLabel(namespace: animation, name: "icloud", description: "50 GB de espacio en iCloud")
                }
            } else {
                HStack {
                    ServiceIcon(namespace: animation, name: "applemusic", size: 32)
                    ServiceIcon(namespace: animation, name: "appletv", size: 32)
                    ServiceIcon(namespace: animation, name: "applearcade", size: 32)
                    ServiceIcon(namespace: animation, name: "icloud", size: 32)
                }
            }
        }
        .padding(12)
        .background(colorScheme == .dark ? Color(.tertiarySystemGroupedBackground) : Color(.white))
        .cornerRadius(16)
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(selected == index ? Color.blue : colorScheme == .dark ? Color.clear : Color.white, lineWidth: 2)
        )
        .padding(.horizontal, 16)
        .shadow(color: Color.black.opacity(colorScheme == .dark ? 0.6 : 0.1), radius: 6, x: 0.0, y: 0.0)
        .onTapGesture {
            withAnimation {
                selected = index
            }
        }
    }
}

struct ServiceIcon: View {
    var namespace: Namespace.ID
    let name: String
    let size: CGFloat
    
    var body: some View {
        Image(name)
            .resizable()
            .frame(width: size, height: size, alignment: .center)
            .cornerRadius(size/4)
            .overlay(
                RoundedRectangle(cornerRadius: size/4)
                    .stroke(Color.gray, lineWidth: 0.5)
            )
            .matchedGeometryEffect(id: name, in: namespace)
    }
}

struct ServiceLabel: View {
    var namespace: Namespace.ID
    let name: String
    let description: String
    
    var body: some View {
        HStack {
            ServiceIcon(namespace: namespace, name: name, size: 26)
            Text(description)
        }
    }
}


struct AppleOneView_Previews: PreviewProvider {
    static var previews: some View {
        AppleOneView()
    }
}
