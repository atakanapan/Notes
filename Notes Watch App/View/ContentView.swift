//
//  ContentView.swift
//  Notes Watch App
//
//  Created by Atakan Apan on 7/20/23.
//

import SwiftUI

struct ContentView: View {
    
    //MARK: Properties
    @State private var notes: [Note] = [Note]()
    @State private var text: String = ""
    
    //MARK: Functions
    
    func getDocumentDirectory() -> URL {
        let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return path[0]
    }
    
    func save(){
        DispatchQueue.main.async {
            do {
                // 1. Convert the notes array to data using JSONEncoder
                let data = try JSONEncoder().encode(notes)
                
                // 2. Create a new URL to save the file using getDocumentDirectory
                let url = getDocumentDirectory().appendingPathComponent("notes")
                
                // 3. Write the data to given URL
                try data.write(to: url)
                
            } catch {
                print("Saving data has failed!")
            }
        }
    }
    
    func load() {
        do {
            // 1. Get the notes URL path
            let url = getDocumentDirectory().appendingPathComponent("notes")
            
            // 2. Create a new property for the data
            let data = try Data(contentsOf: url)
            
            // 3. Decode the data
            notes = try JSONDecoder().decode([Note].self, from: data)
            
        } catch {
            
        }
    }
    
    func delete(offsets: IndexSet) {
        withAnimation {
            notes.remove(atOffsets: offsets)
            save()
        }
    }
    
    //MARK: Body
    
    var body: some View {
        NavigationStack {
            VStack {
                HStack(alignment: .center, spacing: 6) {
                    TextField("Add New Note", text: $text)
                    Button {
                        // Actions
                        
                        // 1. Only run the button's action when the text field is not empty
                        guard text.isEmpty == false else { return }
                        
                        // 2. Create a new note item and initilize it with the text value
                        let note = Note(id: UUID(), text: text)
                        
                        // 3. Add the new note item to the notes array (append)
                        notes.append(note)
                        
                        // 4. Save the note with function
                        save()
                        
                        // 5. Make the text field empty
                        text = ""
                        
                    } label: {
                        Image(systemName: "plus.circle")
                            .font(.system(size: 42, weight: .semibold))
                    }
                    .fixedSize()
                    .buttonStyle(PlainButtonStyle())
                    .foregroundColor(.accentColor)
                } //HStack
                Spacer()
                if notes.count >= 1 {
                    List {
                        ForEach(0..<notes.count, id: \.self) { i in
                            NavigationLink(destination: DetailView(note: notes[i], count: notes.count, index: i)) {
                                HStack {
                                    Capsule()
                                        .frame(width: 4)
                                        .foregroundColor(.accentColor)
                                    Text(notes[i].text)
                                        .lineLimit(1)
                                        .padding(.leading, 5)
                                
                                }
                            }//HStack
                        }//ForEachLoop
                        .onDelete(perform: delete)
                    }
                } else {
                    Spacer(minLength: 30)
                    Image(systemName: "note.text")
                        .resizable()
                        .scaledToFit()
                        .foregroundColor(.gray)
                        .opacity(0.25)
                        .padding(5)
                    Spacer()
                }
            } //VStack
            .navigationTitle("Notes")
            .navigationBarTitleDisplayMode(.inline)
            .padding()
        } //NavStack
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
