//
//  Extension+Notification.swift
//  Hi FPT
//
//  Created by Jenny on 23/07/2021.
//

import UIKit

extension Notification.Name {
    static let didSelectContract = Notification.Name("didSelectContract")
    static let dismissRatingPopupNotif = Notification.Name("dismissRatingPopupNotif")
    static let listConversationNotif = Notification.Name("listConversationNotif")
    static let listMessageNotif = Notification.Name("listMessageNotif")
    static let reRenderSingleMessageNotif = Notification.Name("reRenderSingleMessageNotif")
    static let messageNotif = Notification.Name("messageNotif")
    static let createConversationNotif = Notification.Name("createConversationNotif")
    static let closeConversationNotif = Notification.Name("closeConversationNotif")
    static let errorConnectionNotif = Notification.Name("errorConnectionNotif")
    static let selectConversationNotif = Notification.Name("selectConversationNotif")
    
    static let editAutoPayNotif = Notification.Name("editAutoPayNotif")
    static let createAutoPayNotif = Notification.Name("createAutoPayNotif")
    static let receiveChatNotif = Notification.Name("receiveChatNotif")
    static let readConversationNotif = Notification.Name("readConversationNotif")
    static let newMessageNotif = Notification.Name("newMessageNotif")
    static let isGuestFoxPayNotifName = Notification.Name("isGuestFoxPayNotifName")
    //V5.13
    static let chatNotiWithConversationId = Notification.Name("chatNotiWithConversationId")
    //V5.13.1
    static let pncScanQRNotifName = Notification.Name("pncScanQRNotifName")
    //V6.5
    static let reloadModemSocketNotif = Notification.Name("socketReloadModemNoti")
    static let setShowTipFsafe = Notification.Name("setShowTipFsafe")
    static let transferDataForWebkit = Notification.Name("transferDataForWebkit")
}
