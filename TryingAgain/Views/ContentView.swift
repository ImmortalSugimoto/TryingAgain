//
//  ContentView.swift
//  TryingAgain
//
//  Created by Liban Abdinur on 7/23/22.
//

import SwiftUI

struct ContentView: View {
    @State var authors: [AuthorModel] = []
    
    var body: some View {
        
        NavigationView{
            List(authors.sorted(by: {$0.authorName < $1.authorName}), id:\.authorName){
                author in
                NavigationLink(author.authorName){
                    AuthorView(authors: author)
                }
            }
            .navigationTitle("List of Authors")
            
        }
        .onAppear(perform: loadData)
    }// end of body
    
    func loadData(){
        guard let url = URL(string: "https://mocki.io/v1/e860a172-2605-4afe-bcba-dfd071e8256e") else{
            print("url is not valid")
            return
        }
        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request){
            data, response, error in
            if let data = data{
                if let response = try?
                    JSONDecoder().decode([AuthorModel].self, from: data){
                    DispatchQueue.main.async {
                        self.authors = response
                    }
                }
                else{
                    print("Json decoder cant decode the data")
                }
            }
            else{
                print("NO data from URLRequest")
            }
        }.resume()
    }
}

struct AuthorView: View{
    var authors: AuthorModel
    
    var body: some View{
        
        NavigationView{
            
            List(authors.books.filter ({book in
                book.title != ""
            }), id:\.title){ book in
                
                
                HStack{
                    if let url = URL(string: book.cover_image){
                        AsyncImage(url: url)
                    }
                    VStack(alignment:.leading){
                        Text(book.title)
                        HStack{
                            Text("Pages: \(book.pages) release: \(book.releaseDate)")
                        }
                    }
                    
                }
                
            }
            
            
            
        }
        
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
