//
//  HomeController_Extension.swift
//  Hsin_Resume
//
//  Created by Chung Han Hsin on 2019/2/23.
//  Copyright © 2019 Chung Han Hsin. All rights reserved.
//

import Foundation
import Firebase
extension HomeController{
    func setupIntroductionDataBase(){
        let introDocData: [String:Any] = [
            "name": "Hsin, Chung-Han",
            "profession": "IOS Application Developer",
            "email": "hooy123456@gapp.nthu.edu.tw",
            "images": ["i0", "i1", "i2","i3","i4", "i5", "i6", "i7","i8", "i9"],
            "descriptions": ["2019-01-18\nGo to National Cheng Kung University teach Python!\nThree times a week","2018-11-10\nVisit Belize Embassador and sign a contract of Belize City Tour App with her!","2018-10-24/nSelected as a good solider because of the outstanding performance during military service!", "2018-07-12\nReport to Taiwnan's president about the project I did in Belize!","2018-06-27\nInvite Taiwan's experts to Belize to discuss a new project in Belize", "2018-04-28\nHelp Belize Administry of Traffic make an application to test trafiic knowledge!", "2017-07-10\nGraduated from National Tsing Hua University\nMajored in Computer Science Information Engineer\nMaster degree", "2016-07-01 to 2017-01-30\nBe an IOS Application Developer in KKBOX!", "2016-04-01 to 2016-07-30\nBe an IOS Application Developer intern in Watics!"]
        ]
        Firestore.firestore().collection("Hsin").document("Introduction").setData(introDocData) { (error) in
            if let error = error{
                print(error.localizedDescription)
                return
            }
        }
    }
    
    func setupPortfolioDataBase(){
        let introDocData: [String:Any] = [
            "name": "Application Portfolio",
            "profession": "",
            "email": "",
            "images": ["portfolio", "BZ1", "Bus1", "TE1", "tinder1",  "IN0","PO0", "password1"],
            "descriptions": ["Belize City Tour", "Belize Bus Time", "Belize Traffic Knowledge Test", "Hsinder", "Hsintagram", "PodCast", "Lazy Password"]
        ]
        Firestore.firestore().collection("Hsin").document("ApplicationPortfolio").setData(introDocData) { (error) in
            if let error = error{
                print(error.localizedDescription)
                return
            }
        }
    }
    
    
    func setupBelizeCityTourDataBase(){
        let introDocData: [String:Any] = [
            "name": "Belize City Tour",
            "profession":"Cooperated with Taiwan's Administry of Foreign Affair",
            "email": "and Belize's Administry of Culture",
            "images": ["BZ1","BZ2","BZ3","BZ4","BZ5","BZ6","BZ7","BZ8","BZ9","BZ10","BZ11", "BZ12"],
            "descriptions": ["Using fancy animation to welcome our user!", "You can find all of monument on this page!", "More detail information view will pop up from the bottom! -- iPhone Version", "iPad Version", "Here we present the story of monument for our user!", "Some information about this monument!", "You can find the path to mounment from apple map!", "The story of Belize City Tour project!", "An introduction of International Cooperation and Development found!", "We report this applicatin to Taiwan's president, Tsai, Ing-Wen!", "Please go to App Store and type in 'Belize Cuty Tour'! Thanks lot!"]
        ]
        Firestore.firestore().collection("Hsin").document("BelizeCityTour").setData(introDocData) { (error) in
            if let error = error{
                print(error.localizedDescription)
                return
            }
        }
    }
    
    func setupBelizeBusTimeDataBase(){
        let introDocData: [String:Any] = [
            "name": "Belize Bus Time",
            "profession": "Cooperated with Belize Administry of Traffic",
            "email": "and Belize Private Bus Companies",
            "images": ["Bus1","Bus2","Bus3","Bus4","Bus5", "Bus6"],
            "descriptions": ["Just choos start location and destination, then we'll caculate the bus schedule for you!", "Tap search to see schedule!", "Here's your schedule, enjoy it!", "If you need to transfer, we will display all the messages you must know on the card.", "Please go to App Store and type in 'Belize Bus Time Tour'! Thanks lot!"]
        ]
        Firestore.firestore().collection("Hsin").document("BelizeBusTime").setData(introDocData) { (error) in
            if let error = error{
                print(error.localizedDescription)
                return
            }
        }
    }
    
    func setupBelizeTrafficExamDataBase(){
        let introDocData: [String:Any] = [
            "name": "Belize Traffic Knowledge Test",
            "profession": "Cooperated with Belize Administry of Traffic",
            "email": "",
            "images": ["TE1", "TE2", "TE3", "TE4", "TE5", "TE6", "TE7", "TE8", "TE9", "TE10", "TE11"],
            "descriptions": ["Let's start the simple traffic knowledge test", "Question View! Watch out your time!", "Correct View", "Incorrect View", "Time's up!", "Remember this traffic sign!", "Swipe it then continue to next question!", "Taiwan's projects in Belize", "Taiwan always be your friend, Belize!", "Congratuation, you've finished this test!"]
        ]
        Firestore.firestore().collection("Hsin").document("BelizeTrafficExam").setData(introDocData) { (error) in
            if let error = error{
                print(error.localizedDescription)
                return
            }
        }
    }
    
    func setupHsinderDataBase(){
        let introDocData: [String:Any] = [
            "name": "Hsinder",
            "profession": "Miciced real App - Tinder!",
            "email": "Inplement most of all functionalities of Tinder!",
            "images": ["tinder1", "tinder1", "tinder2", "tinder3", "tinder4", "tinder5", "tinder6"],
            "descriptions": ["Register a user to finde a new friends! We use Firebase to be our server side!", "Swiping to right to say 'like' to new friend!", "Nope this guy! ", "Click info icon to see more details about this user!","Set the desired age range, then system will give you right candidates!", "If you have liked each other, you will see this fancy matched view!"]
        ]
        Firestore.firestore().collection("Hsin").document("Hsinder").setData(introDocData) { (error) in
            if let error = error{
                print(error.localizedDescription)
                return
            }
        }
    }
    
    func setupHsintagramDataBase(){
        let introDocData: [String:Any] = [
            "name": "Hsintagram",
            "profession": "Miciced real App - Instagram!",
            "email": "Inplement most of all functionalities of Instagram!",
            "images": ["IN0","IN1","IN2","IN3","IN4","IN5","IN6","IN7","IN8","IN9","IN10","IN11","IN12","IN13","IN14","IN15"],
            "descriptions": ["Sign up a new user!", "User progile page's view!", "Use this app'sbuild-in camra to take a photo!", "Choose the photo fram image picker to post on Hsintagram!", "Write something for you post!", "Ha ha, here's your post!", "A fabulous app for you to search Belize bus time!", "Heard that Taiwan's president visit Belize!", "Go to discover page to find a new friend!", "Type your friend's name!", "Here's your friend! By the way, we use firebase to be our server!", "Follow this new friend!", "Unfollow he!", "Go to Home page and drag down to refresh posts!", "Leave a comment for a post!"]
        ]
        Firestore.firestore().collection("Hsin").document("Hsintagram").setData(introDocData) { (error) in
            if let error = error{
                print(error.localizedDescription)
                return
            }
        }
    }
    
    
    func setupPodcastDataBase(){
        let introDocData: [String:Any] = [
            "name": "Podcast",
            "profession": "Miciced real App - Podcast!",
            "email": "Using ITune search API to fetch podcast!",
            "images": ["PO0","PO1","PO2","PO3","PO4","PO5","PO6","PO7",],
            "descriptions": ["It's a simple search view! ", "Type 'J', then it will give a request to Apple server!", "The matched podcast will display down below!", "Tap a podcast!", "It's a control console, and all of buttons' functionalities are implemented!", "If you tsap 'stop' button, then the image will be zoomed out!", "Tap 'Dismiss' button, it will be a small control console! You can control it as well!"]
        ]
        Firestore.firestore().collection("Hsin").document("Podcast").setData(introDocData) { (error) in
            if let error = error{
                print(error.localizedDescription)
                return
            }
        }
    }
    
    
    
    func setupLazyPasswordDatabase(){
        let introDocData: [String:Any] = [
            "name": "Lazy Password",
            "profession": "For lazy guy only!",
            "email": "An easy but safe way to save password!",
            "images": ["password1", "password1", "password2", "password3", "password4", "password5"],
            "descriptions": ["Using fingerprint authentication to protect your password!", "Using Core Data to save your code in the APP!", "Scroll this row to right side, then you can copy the password directly!", "You can delete and edit this password row when scrolling to left side!", "Enjoy this way to remember all annoied password!"]
        ]
        Firestore.firestore().collection("Hsin").document("LazyPassword").setData(introDocData) { (error) in
            if let error = error{
                print(error.localizedDescription)
                return
            }
        }
    }
    
    
    
    
    
    func fatchIntroductionImageUrlToFiresotre(){
        let ref = Storage.storage().reference(withPath: "/Hsin/Introduction")
        let introFileNames = ["i0.png", "i1.png", "i2.png","i3.png","i4.png", "i5.png", "i6.png", "i7.png", "i8.png", "i9.png"]
        
        introFileNames.forEach { (fileName) in
            ref.child(fileName).downloadURL(completion: { (url, error) in
                if let error = error{
                    print(error.localizedDescription)
                    return
                }
                print(url?.absoluteString ?? "")
                print("-------------------")
                print("\n\n")
            })
        }
    }
    
    func fatchBelizeCityTuorImageUrlToFiresotre(){
        let ref = Storage.storage().reference(withPath: "/Hsin/BelizeCityTourApp")
        let introFileNames = ["BZ1.png", "BZ2.png","BZ3.png","BZ4.png", "BZ5.png", "BZ6.png", "BZ7.png", "BZ8.png", "BZ9.png", "BZ10.png", "BZ11.png", "BZ12.png",]
        
        introFileNames.forEach { (fileName) in
            ref.child(fileName).downloadURL(completion: { (url, error) in
                if let error = error{
                    print(error.localizedDescription)
                    return
                }
                print(url?.absoluteString ?? "")
                print("-------------------")
                print("\n\n")
            })
        }
    }
    
    func fatchBusTimeBelizeImageUrlToFiresotre(){
        let ref = Storage.storage().reference(withPath: "/Hsin/BusTimeBelize")
        let introFileNames = ["Bus1.png", "Bus2.png","Bus3.png","Bus4.png", "Bus5.png", "Bus6.png"]
        
        introFileNames.forEach { (fileName) in
            ref.child(fileName).downloadURL(completion: { (url, error) in
                if let error = error{
                    print(error.localizedDescription)
                    return
                }
                print(url?.absoluteString ?? "")
                print("-------------------")
                print("\n\n")
            })
        }
    }
    
    func fatchHsinderImageUrlToFiresotre(){
        let ref = Storage.storage().reference(withPath: "/Hsin/Hsinder")
        let introFileNames = ["tinder0.png","tinder1.png", "tinder2.png","tinder3.png","tinder4.png", "tinder5.png", "tinder6.png"]
        
        introFileNames.forEach { (fileName) in
            ref.child(fileName).downloadURL(completion: { (url, error) in
                if let error = error{
                    print(error.localizedDescription)
                    return
                }
                print(url?.absoluteString ?? "")
                print("-------------------")
                print("\n\n")
            })
        }
    }
    
    func fatchHsintagramUrlToFiresotre(){
        let ref = Storage.storage().reference(withPath: "/Hsin/Hsintagram")
        let introFileNames = ["IN0.png", "IN1.png", "IN2.png","IN3.png","IN4.png", "IN5.png", "IN6.png", "IN7.png", "IN8.png", "IN9.png", "IN10.png", "IN11.png", "IN12.png", "IN13.png", "IN14.png", "IN15.png"]
        
        introFileNames.forEach { (fileName) in
            ref.child(fileName).downloadURL(completion: { (url, error) in
                if let error = error{
                    print(error.localizedDescription)
                    return
                }
                print(url?.absoluteString ?? "")
                print("-------------------")
                print("\n\n")
            })
        }
    }
    
    func fatchPasswordUrlToFiresotre(){
        let ref = Storage.storage().reference(withPath: "/Hsin/Password")
        let introFileNames = ["password1.png", "password1.png", "password2.png", "password3.png", "password4.png", "password5.png"]
        
        introFileNames.forEach { (fileName) in
            ref.child(fileName).downloadURL(completion: { (url, error) in
                if let error = error{
                    print(error.localizedDescription)
                    return
                }
                print(url?.absoluteString ?? "")
                print("-------------------")
                print("\n\n")
            })
        }
    }
    
    func fatchPodcastUrlToFiresotre(){
        let ref = Storage.storage().reference(withPath: "/Hsin/Podcast")
        let introFileNames = ["PO0.png","PO1.png","PO2.png","PO3.png","PO4.png","PO5.png","PO6.png","PO7.png",]
        
        introFileNames.forEach { (fileName) in
            ref.child(fileName).downloadURL(completion: { (url, error) in
                if let error = error{
                    print(error.localizedDescription)
                    return
                }
                print(url?.absoluteString ?? "")
                print("-------------------")
                print("\n\n")
            })
        }
    }
    
    func fatchPortfolioUrlToFiresotre(){
        let ref = Storage.storage().reference(withPath: "/Hsin/Portfolio")
        let introFileNames = ["P0.png","P1.png","P2.png","P3.png","P4.png","P5.png","P6.png","P7.png",]
        
        introFileNames.forEach { (fileName) in
            ref.child(fileName).downloadURL(completion: { (url, error) in
                if let error = error{
                    print(error.localizedDescription)
                    return
                }
                print(url?.absoluteString ?? "")
                print("-------------------")
                print("\n\n")
            })
        }
    }
    
    func fatchTrafficExamUrlToFiresotre(){
        let ref = Storage.storage().reference(withPath: "/Hsin/TrafficExam")
        let introFileNames =  ["TE1.png", "TE2.png", "TE3.png", "TE4.png", "TE5.png", "TE6.png", "TE7.png", "TE8.png", "TE9.png", "TE10.png", "TE11.png"]
        
        introFileNames.forEach { (fileName) in
            ref.child(fileName).downloadURL(completion: { (url, error) in
                if let error = error{
                    print(error.localizedDescription)
                    return
                }
                print(url?.absoluteString ?? "")
                print("-------------------")
                print("\n\n")
            })
        }
    }
}
