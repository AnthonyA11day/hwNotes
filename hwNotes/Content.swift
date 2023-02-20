//
//  File.swift
//  hwNotes
//
//  Created by Anthony on 11.02.2023.
//

import Foundation

struct Contents {
    let dataAndTime: String
    let location: String
    let massage: String
}

struct Source {
    
    static func makeContent() ->[Contents] {
        [.init(dataAndTime: "11.01.2023", location: "Россия, Москва", massage: "тест отображение многострочного текста"),
         .init(dataAndTime: "11.01.2023", location: "Россия, Санкт-Перербург", massage: "СПБ"),
         .init(dataAndTime: "11.01.2023", location: "Россия, Екатеринбург", massage: "ЕКБ"),
         .init(dataAndTime: "11.01.2023", location: "Россия, Ростов-на-Дону", massage: "папа"),
         .init(dataAndTime: "12.12.2023", location: "Казхстан, Астана", massage: "заметка"),
         .init(dataAndTime: "12.12.2023", location: "Казхстан, Алмата", massage: "яблоко"),
         .init(dataAndTime: "07.07.2023", location: "Украина, Киев", massage: "заметка"),
         .init(dataAndTime: "07.07.2023", location: "Украина, Одесса", massage: "мама"),
         .init(dataAndTime: "14.03.2023", location: "Грузия, Бaтуми", massage: "заметка"),
        ]
    }
}
