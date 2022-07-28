//
//  secondView.swift
//  TryingAgain
//
//  Created by Liban Abdinur on 7/23/22.
//

import SwiftUI

struct secondView: View {
    @State var authors: [AuthorModel] = []
    
    var body: some View {
        List(){
            Text("Pizza")
            Text("Dominoes")
            Text("Pumpkin")
        }
    }
    
    
    func loadData(){
        
        guard let url = URL(string: "") else{
            print("Url is not valid")
            return
        }
        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request){ data, response, error in
            if let data = data{
                if let response = try?
                    JSONDecoder().decode([AuthorModel].self, from: data) {
                    DispatchQueue.main.async {
                        self.authors = response
                        
                    }
                }
                else{
                    print("JSON decoder can't decode the data")
                }
            }
            else{
                print("NO data from the URL request")
            }
            
        }.resume()
        
    }
    
}

struct secondView_Previews: PreviewProvider {
    static var previews: some View {
        secondView()
    }
}
