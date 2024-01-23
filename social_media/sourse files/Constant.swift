//
//  Constant.swift
//  MyResumeApp
//
//  Created by Jane Chao on 22/04/20.
//

import Foundation

typealias Experience = (title: String, company: String, start: String, end: String)

struct Resume {
    static let shared = Resume()
    let name     = "Jane Chao"
    let title    = "iOS Developer"
    let location = "位置：台灣"
    let bio      = "與 swift 熱戀中，經營 swift 教學頻道，希望讓更多人加入 coding 的美好世界 😊"
    let skills   = ["python", "swift", "mySQL", "xd"]
    let experiences: [Experience] = [("Swift Content Creator",
                                      "ChaoCode",
                                      "2022 年 4 月",
                                      "現在"),
                                     ("App Developer",
                                      "JC Studio",
                                      "2021 年 5 月",
                                      "2022 年 1 月"),
                                     ("Web Developer",
                                      "JC Studio",
                                      "2020 年 12 月",
                                      "2021 年 4 月")]
    let phoneUrl = "tel://0912345678"
    let socialMedia: [(name: String, url: String)] = [("LinkedIn","https://www.linkedin.com/in/profile/williamhgates"),
                                                      ("Line","https://line.me/ti/p/Fhgz4-NFLH"),
                                                      ("YouTube","https://www.youtube.com/channel/UCsssLDarjKe7K0YtuLrjpcw")]
}

