//
//  ConsentDocument.swift
//  BreastScreeningDecisions
//
//  Created by Victor Yurkin on 11/11/16.
//  Copyright © 2016 Weill Cornell Medicine. All rights reserved.
//


import ResearchKit

class ConsentDocument: ORKConsentDocument {
    // MARK: Properties
    
    let contentText = [
        "Breast Screening Decisions is an application to help you make informed, personalized decisions about when to start and how often to have screening mammograms.\n\nWho should use this application?\n\nBreast Screening Decisions is for women ages 40-49. If you are outside this age group, BSD is not for you.\nBreast screening Decisions is for women at low to average risk of breast cancer. BSD starts with a breast cancer risk assessment - a series of questions to help you find out your breast cancer risk. If you are at higher than average risk for breast cancer, BSD is not for you. We recommend that you speak with your doctor about which breast cancer screening schedule is best for you.",

        "You will be asked to complete a number of surveys in order to determine your risk of breast cancer.\n\nUsers of this application are responsible for the correctness of the answers they give to the risk assessment. If these answers are incorrect, the risk may not be accurate. If you are not certain about the answers to the risk questions, you should not rely on the risk data, but speak instead to your clinician, who can help you calculate your risks as best he/she can based on the information you provide.",
        
        "Information you enter here is anonymous, and we never ask your name or email address.\n\nWe do not collect any personally identifying information about you or your family. We do not collect IP addresses, email, names, birth date or any of the 18 HIPAA identfiers that could be used to identify you.",
        
        "The breast cancer risk given is based on the answers you provide to the risk assessment questions.\n\nIt is not our intention to provide specific medical advice to users of this application, but rather to provide users with information to help them make informed decisions about screening mammograms.\n\nNothing on this application is intended to replace the advice of your physician or other qualified health care provider.\n\nWe urge you to consult with your doctor for diagnosis and for answers to personal medical questions."
    ]
    
    // MARK: Initialization
    
    override init() {
        super.init()
        
        title = NSLocalizedString("Breast Screening Decisions Tool Consent Form", comment: "")
        
        let sectionTypes: [ORKConsentSectionType] = [
            .overview,
            .dataGathering,
            .privacy,
            .dataUse
        ]
        
        sections = zip(sectionTypes, contentText).map { sectionType, contentText in
            let section = ORKConsentSection(type: sectionType)
            
            let localizedContent = NSLocalizedString(contentText, comment: "")
            let localizedSummary = localizedContent.components(separatedBy: ".")[0] + "."
            
            section.summary = localizedSummary
            section.content = localizedContent
            
            return section
        }
        
        let signature = ORKConsentSignature(forPersonWithTitle: nil, dateFormatString: nil, identifier: "ConsentDocumentParticipantSignature")
        addSignature(signature)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ORKConsentSectionType: CustomStringConvertible {
    
    public var description: String {
        switch self {
        case .overview:
            return "Overview"
            
        case .dataGathering:
            return "DataGathering"
            
        case .privacy:
            return "Privacy"
            
        case .dataUse:
            return "DataUse"
            
        case .timeCommitment:
            return "TimeCommitment"
            
        case .studySurvey:
            return "StudySurvey"
            
        case .studyTasks:
            return "StudyTasks"
            
        case .withdrawing:
            return "Withdrawing"
            
        case .custom:
            return "Custom"
            
        case .onlyInDocument:
            return "OnlyInDocument"
        }
    }
}
