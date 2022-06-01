//
//  NotesListScreen.swift
//  CoreDataTest
//
//  Created by Артем Черненко on 01.06.2022.
//

import SwiftUI

struct NotesListScreen: View {
    @Environment(\.managedObjectContext) private var viewContext
    @State var selectedPet: NameList
    
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \NotesList.notesTitle, ascending: true)], animation: .default)
    private var test: FetchedResults<NotesList>
    
    private var notes: [NotesList] {
        selectedPet.nameToNotes?.allObjects as? [NotesList] ?? []
//        return set.shuffled()
//            .sorted {
//            $0.date ?? Date() < $1.date ?? Date()
//        }
    }
    
    var body: some View {
        VStack{
            List(test) { note in
                Text(note.notesTitle ?? "Empty title")
            }
            Button("add note") {
                addNewNote(for: selectedPet)
            }
        }
    }
    
    private func addNewNote(for pet: NameList){
        let newNote = NotesList(context: viewContext)
        newNote.notesID = UUID()
        newNote.notesTitle = "Test title"
        newNote.notesToName = pet
        
        do {
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("Fatal error \(nsError), \(nsError.userInfo)")
        }
    }
}

//struct NotesListScreen_Previews: PreviewProvider {
//    static var previews: some View {
//        NotesListScreen()
//    }
//}
