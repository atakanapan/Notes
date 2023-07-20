//
//  DetailView.swift
//  Notes Watch App
//
//  Created by Atakan Apan on 7/21/23.
//

import SwiftUI

struct DetailView: View {
    
    //MARK: Properties
    let note: Note
    let count: Int
    let index: Int
    @State private var isCreditsPresented: Bool = false
    
    //MARK: Functions
    
    //MARK: Body
    var body: some View {
        VStack(alignment: .center, spacing: 3) {
            
            //Header
            HeaderView()
            
            //Content
            Spacer()
            ScrollView(.vertical){
                Text(note.text)
                    .font(.title3)
                    .fontWeight(.semibold)
                    .multilineTextAlignment(.center)
            }
            Spacer()
            
            //Footer
            HStack(alignment: .center) {
                Image(systemName: "gear")
                    .imageScale(.large)
                Spacer()
                Text("\(count) / \(index + 1)")
                Spacer()
                Image(systemName: "info.circle")
                    .imageScale(.large)
                    .onTapGesture {
                        isCreditsPresented.toggle()
                    }
                    .sheet(isPresented: $isCreditsPresented) {
                        CreditsView()
                    }
            }
            .foregroundColor(.secondary)
        }//VStack
        .padding(3)
    }
}

struct DetailView_Previews: PreviewProvider {
    static var sampleData: Note = Note(id: UUID(), text: "Hello World!")
    static var previews: some View {
        DetailView(note: sampleData, count: 5, index: 1)
    }
}
