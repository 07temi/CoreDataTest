//
//  NotesListScreen.swift
//  CoreDataTest
//
//  Created by Артем Черненко on 01.06.2022.
//

import SwiftUI

struct NotesListScreen: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \NotesList.notesDate, ascending: true)], animation: .default)
    private var test: FetchedResults<NotesList>
    let selectedPet: NameList
    
    private var notes: [NotesList] {
        selectedPet.nameToNotes?.allObjects as? [NotesList] ?? []
//        return set.shuffled()
//            .sorted {
//            $0.date ?? Date() < $1.date ?? Date()
//        }
    }
    
    var body: some View {
        VStack{
            List {
                ForEach(notes){note in
                    VStack(alignment: .leading){
                        Text(note.notesTitle ?? "Empty title")
                            .font(.system(size: 16))
                        Text("\(note.notesDate?.formatted(date: .long, time: .omitted) ?? "")")
                            .font(.system(size: 10))
                    }
                    .padding(2)
                }
                .onDelete(perform: deleteNote)
            }
            NavigationLink(destination: AddNoteScreen(selectedPet: selectedPet)) {
                Text("Добавить заметку")
            }
        }
    }
    
    private func addNewNote(for pet: NameList){
        let newNote = NotesList(context: viewContext)
        newNote.notesID = UUID()
        newNote.notesTitle = "Test title"
        newNote.notesDate = Date()
        newNote.notesToName = pet
        viewContext.refreshAllObjects()
        do {
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("Fatal error \(nsError), \(nsError.userInfo)")
        }
    }
    
    private func deleteNote(at offsets: IndexSet) {
        for index in offsets {
            let note = notes[index]
            viewContext.delete(note)
            viewContext.refreshAllObjects()
        }
        do {
            try viewContext.save()
        } catch {
            }
    }
}

//struct NotesListScreen_Previews: PreviewProvider {
//    static var previews: some View {
//        NotesListScreen()
//    }
//}
