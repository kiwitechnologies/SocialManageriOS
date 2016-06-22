//
//  ServiceManager.swift
//  TSGServiceClient
//
//  Created by Yogesh Bhatt on 14/06/16.
//  Copyright © 2016 kiwitech. All rights reserved.
//

import Foundation

public class ServiceManager {
    
    /*********************************************************************************************************************
     
     These methods would be used when We are not using WebTool
     ********************************************************************************************************************/

    /**
     *	@functionName	: setBaseURL
     *	@parameters		: url : It would be the baseURL of app
     */
    
    public class func setBaseURL(url:String)->() {
        TSGHelper.setBaseURL(url)
    }
    
    
    
    /**
     *	@functionName	: setHeader
     *	@parameters		: someDict : It would be dictionary of required set of Headers
     *	@description	: Call services for device reg and google analytics
     */
    
    public class func setHeader(someDict:[NSObject:AnyObject])
    {
        
        TSGHelper.setCustomHeader(someDict)
    }
    
    /**
     *	@functionName           : removeHeader
     *	@completion Block		: deviceTokeString : It would be a unique identifier of device
     *	@description            : It would be used to remove Headers
     */
    
    public class func removeHeader()
    {
        TSGHelper.removeCustomHeader()
        
    }
    /**
     *	@functionName	: cancelAllRequest
     *	@description	: It would be used to cancel request
     */
    
    public class func cancelAllRequest(completion:(Bool)->())
    {
        TSGHelper.cancelAllRequests()
    }
    
    /**
     *	@functionName	: cancelRequestWithActionID
     *	@description	: It would be used to cancel request
     */
    
    public class func cancelRequestWithTagId(tagID:String)->()
    {
        TSGHelper.cancelRequestWithTag(tagID)
    }
    
    /**
     *	@functionName	: downloadData
     *	@parameters		: url : It would be a unique identifier of device
                        :  completion block : It would be a unique identifier of device
     *	@description	: It would be used to download any Data
     */
    
    public class func downloadWith(path:String, param:NSDictionary?=nil,requestType:RequestType, downloadType:DownloadType = DownloadType.PARALLEL, withApiTag apiTag:String?=nil,prority:Bool, progress:(percentage: Float)->Void, success:(response:AnyObject)->Void, failure:NSError-> Void){

        TSGHelper.downloadFile(path, param: param,requestType: requestType,downloadType: downloadType,withApiTag: apiTag, priority:prority,  progressValue: { (percentage) in
            progress(percentage: percentage)
            }, success: { (response) in
                success(response: response)
        }) { (NSError) in
            failure(NSError)
        }
    }
    
 
    /**
     *	@functionName	: hitRequestForAPI
     *	@parameters		: name : It would the name of API to hit for getting response
                        : requestType  : It would be HTTP action i.e GET,POST,DELTE,PUT
                        : responseType : It would be responseType i.e JSON,XML, RAW
     
     *	@description	: It would be used to download any Data
     */
    
    public class func hitRequestForAPI(path:String, withQueryParam queryParam:[String:String]?=nil, bodyParam:NSDictionary?=nil,typeOfRequest:RequestType, typeOFResponse:ResponseMethod, withApiTag apiTag:String?=nil, success:AnyObject->Void, failure:NSError -> Void){
        
        TSGHelper.hitRequestForAPI(path, withQueryParam: queryParam, bodyParam: bodyParam, typeOfRequest: typeOfRequest, typeOFResponse: typeOFResponse, withApiTag: apiTag, success: { (object) in
            success(object)
            }) { (error) in
                failure(error)
        }
    }
    
    public class func uploadWithPath(path: String,bodyParams:NSDictionary, dataKeyName:String,mimeType:MimeType,imageQuality:ImageQuality?=ImageQuality.HIGH,uploadType:UploadType = UploadType.PARALLEL,prority:Bool, progress: (percent: Float) -> Void, Success:(response:AnyObject) -> Void, Failure:ErrorType->Void){
        
        TSGHelper.uploadWith(path, bodyParams: bodyParams, dataKeyName: dataKeyName, mimeType: mimeType,imageQuality: imageQuality,uploadType:uploadType,priority:true, progress: { (percent) in
            progress(percent: percent)
            
            }, success: { (response) in
                Success(response: response)
                
        }) { (error) in
            Failure(error)
        }
    }
    
 }

