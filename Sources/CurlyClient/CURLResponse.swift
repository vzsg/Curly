//
//  CURLResponse.swift
//  PerfectCURL
//
//  Created by Kyle Jessup on 2017-05-10.
//	Copyright (C) 2017 PerfectlySoft, Inc.
//
//===----------------------------------------------------------------------===//
//
// This source file is part of the Perfect.org open source project
//
// Copyright (c) 2015 - 2017 PerfectlySoft Inc. and the Perfect project authors
// Licensed under Apache License v2.0
//
// See http://perfect.org/licensing.html for license information
//
//===----------------------------------------------------------------------===//
//

import CCurlyCURL
import Foundation

enum ResponseReadState {
	case status, headers, body
}

public typealias CurlyError = CURLResponse.Error

/// Response for a CURLRequest. 
/// Obtained by calling CURLResponse.perform.
public class CURLResponse {
	/// A response header that can be retreived.
	typealias Header = HTTPResponseHeader
	/// A confirmation func thats used to obtain an asynchrnous response.
	typealias Confirmation = () throws -> CURLResponse
	/// An error thrown while retrieving a response.
	public struct Error: Swift.Error {
        public enum Code: Int {
            case unsupportedProtocol = 1
            case failedInit             /* 2 */
            case urlMalformat           /* 3 */
            case notBuiltIn            /* 4 - [was obsoleted in August 2007 for
             7.17.0, reused in April 2011 for 7.21.5] */
            case couldntResolveProxy   /* 5 */
            case couldntResolveHost    /* 6 */
            case couldntConnect         /* 7 */
            case weirdServerReply      /* 8 */
            case remoteAccessDenied    /* 9 a service was denied by the server
             due to lack of access - when login fails
             this is not returned. */
            case ftpAcceptFailed       /* 10 - [was obsoleted in April 2006 for
             7.15.4, reused in Dec 2011 for 7.24.0]*/
            case ftpWeirdPassReply    /* 11 */
            case ftpAcceptTimeout      /* 12 - timeout occurred accepting server
             [was obsoleted in August 2007 for 7.17.0,
             reused in Dec 2011 for 7.24.0]*/
            case ftpWeirdPasvReply    /* 13 */
            case ftpWeird227Format    /* 14 */
            case ftpCantGetHost       /* 15 */
            case http2                   /* 16 - A problem in the http2 framing layer.
             [was obsoleted in August 2007 for 7.17.0,
             reused in July 2014 for 7.38.0] */
            case ftpCouldntSetType    /* 17 */
            case partialFile            /* 18 */
            case ftpCouldntRetrFile   /* 19 */
            case obsolete20              /* 20 - NOT USED */
            case quoteError             /* 21 - quote command failure */
            case httpReturnedError     /* 22 */
            case writeError             /* 23 */
            case obsolete24              /* 24 - NOT USED */
            case uploadFailed           /* 25 - failed upload "command" */
            case readError              /* 26 - couldn't open/read from file */
            case outOfMemory           /* 27 */
            /* Note: CURLE_OUT_OF_MEMORY may sometimes indicate a conversion error
             instead of a memory allocation error if CURL_DOES_CONVERSIONS
             is defined
             */
            case operationTimedout      /* 28 - the timeout time was reached */
            case obsolete29              /* 29 - NOT USED */
            case ftpPortFailed         /* 30 - FTP PORT operation failed */
            case ftpCouldntUseRest    /* 31 - the REST command failed */
            case obsolete32              /* 32 - NOT USED */
            case rangeError             /* 33 - RANGE "command" didn't work */
            case httpPostError         /* 34 */
            case sslConnectError       /* 35 - wrong when connecting with SSL */
            case badDownloadResume     /* 36 - couldn't resume download */
            case fileCouldntReadFile  /* 37 */
            case ldapCannotBind        /* 38 */
            case ldapSearchFailed      /* 39 */
            case obsolete40              /* 40 - NOT USED */
            case functionNotFound      /* 41 - NOT USED starting with 7.53.0 */
            case abortedByCallback     /* 42 */
            case badFunctionArgument   /* 43 */
            case obsolete44              /* 44 - NOT USED */
            case interfaceFailed        /* 45 - CURLOPT_INTERFACE failed */
            case obsolete46              /* 46 - NOT USED */
            case tooManyRedirects      /* 47 - catch endless re-direct loops */
            case unknownOption          /* 48 - User specified an unknown option */
            case telnetOptionSyntax    /* 49 - Malformed telnet option */
            case obsolete50              /* 50 - NOT USED */
            case peerFailedVerification /* 51 - peer's certificate or fingerprint
             wasn't verified fine */
            case gotNothing             /* 52 - when this is a specific error */
            case sslEngineNotfound     /* 53 - SSL crypto engine not found */
            case sslEngineSetfailed    /* 54 - can not set SSL crypto engine as
             default */
            case sendError              /* 55 - failed sending network data */
            case recvError              /* 56 - failure in receiving network data */
            case obsolete57              /* 57 - NOT IN USE */
            case sslCertproblem         /* 58 - problem with the local certificate */
            case sslCipher              /* 59 - couldn't use specified cipher */
            case sslCacert              /* 60 - problem with the CA cert (path?) */
            case badContentEncoding    /* 61 - Unrecognized/bad encoding */
            case ldapInvalidUrl        /* 62 - Invalid LDAP URL */
            case filesizeExceeded       /* 63 - Maximum file size exceeded */
            case useSslFailed          /* 64 - Requested FTP SSL level failed */
            case sendFailRewind        /* 65 - Sending the data requires a rewind
             that failed */
            case sslEngineInitfailed   /* 66 - failed to initialise ENGINE */
            case loginDenied            /* 67 - user, password or similar was not
             accepted and we failed to login */
            case tftpNotfound           /* 68 - file not found on server */
            case tftpPerm               /* 69 - permission problem on server */
            case remoteDiskFull        /* 70 - out of disk space on server */
            case tftpIllegal            /* 71 - Illegal TFTP operation */
            case tftpUnknownid          /* 72 - Unknown transfer ID */
            case remoteFileExists      /* 73 - File already exists */
            case tftpNosuchuser         /* 74 - No such user */
            case convFailed             /* 75 - conversion failed */
            case convReqd               /* 76 - caller must register conversion
             callbacks using curl_easy_setopt options
             CURLOPT_CONV_FROM_NETWORK_FUNCTION,
             CURLOPT_CONV_TO_NETWORK_FUNCTION, and
             CURLOPT_CONV_FROM_UTF8_FUNCTION */
            case sslCacertBadfile      /* 77 - could not load CACERT file, missing
             or wrong format */
            case remoteFileNotFound   /* 78 - remote file not found */
            case ssh                     /* 79 - error from the SSH layer, somewhat
             generic so the error message will be of
             interest when this has happened */
            
            case sslShutdownFailed     /* 80 - Failed to shut down the SSL
             connection */
            case again                   /* 81 - socket is not ready for send/recv,
             wait till it's ready and try again (Added
             in 7.18.2) */
            case sslCrlBadfile         /* 82 - could not load CRL file, missing or
             wrong format (Added in 7.19.0) */
            case sslIssuerError        /* 83 - Issuer check failed.  (Added in
             7.19.0) */
            case ftpPretFailed         /* 84 - a PRET command failed */
            case rtspCseqError         /* 85 - mismatch of RTSP CSeq numbers */
            case rtspSessionError      /* 86 - mismatch of RTSP Session Ids */
            case ftpBadFileList       /* 87 - unable to parse FTP file list */
            case chunkFailed            /* 88 - chunk callback reported error */
            case noConnectionAvailable /* 89 - No connection available, the
             session will be queued */
            case sslPinnedpubkeynotmatch /* 90 - specified pinned public key did not
             match */
            case sslInvalidcertstatus   /* 91 - invalid certificate status */
            case http2Stream            /* 92 - stream error in HTTP/2 framing layer
//             */
            case unknownCode = -1
            
            static func from(_ curlCode: CURLcode) -> Code {
                guard let code = self.init(rawValue: Int(curlCode.rawValue)) else {
                    return .unknownCode
                }
                return code
            }
        }
		/// The curl specific request response code.
		public let code: Code
		/// The string message for the curl response code.
		public let description: String
		/// The response object for this error.
		public let response: CURLResponse
		
		init(_ response: CURLResponse, code: CURLcode) {
            self.code = Code.from(code)
			self.description = response.curl.strError(code: code)
			self.response = response
		}
	}
	
	/// Enum wrapping the typed response info keys.
	enum Info {
		/// Info keys with String values.
		enum StringValue {
			case
				/// The effective URL for the request/response.
				/// This is ultimately the URL from which the response data came from.
				/// This may differ from the request's URL in the case of a redirect.
				url,
				/// The initial path that the request ended up at after logging in to the FTP server.
				ftpEntryPath,
				/// The URL that the request *would have* been redirected to.
				redirectURL,
				/// The local IP address that the request used most recently.
				localIP,
				/// The remote IP address that the request most recently connected to.
				primaryIP,
				/// The content type for the request. This is read from the "Content-Type" header.
				contentType // TODO: this is provided directly by curl (for obvious reason) but might 
							// be confusing given that we parse headers and make them all available through `get`
		}
		/// Info keys with Int values.
		enum IntValue {
			case
				/// The last received HTTP, FTP or SMTP response code.
				responseCode,
				/// The total size in bytes of all received headers.
				headerSize,
				/// The total size of the issued request in bytes.
				/// This will indicate the cumulative total of all requests sent in the case of a redirect.
				requestSize,
				/// The result of the SSL certificate verification.
				sslVerifyResult,
				// TODO: fileTime only works if the fileTime request option is set
				fileTime,
				/// The total number of redirections that were followed.
				redirectCount,
				/// The last received HTTP proxy response code to a CONNECT request.
				httpConnectCode,
				// TODO: this needs OptionSet enum
				httpAuthAvail,
				// TODO: this needs OptionSet enum
				proxyAuthAvail,
				/// The OS level errno which may have triggered a failure.
				osErrno,
				/// The number of connections that the request had to make in order to produce a response.
				numConnects,
				// TODO: requires the matching time condition options
				conditionUnmet,
				/// The remote port that the request most recently connected to
				primaryPort,
				/// The local port that the request used most recently
				localPort
//				httpVersion // not supported on ubuntu 16 curl??
		}
		/// Info keys with Double values.
		enum DoubleValue {
			case
				/// The total time in seconds for the previous request.
				totalTime,
				/// The total time in seconds from the start until the name resolving was completed.
				nameLookupTime,
				/// The total time in seconds from the start until the connection to the remote host or proxy was completed.
				connectTime,
				/// The time, in seconds, it took from the start until the file transfer is just about to begin.
				preTransferTime,
				/// The total number of bytes uploaded.
				sizeUpload, // TODO: why is this a double? curl has it as a double
				/// The total number of bytes downloaded.
				sizeDownload, // TODO: why is this a double? curl has it as a double
				/// The average download speed measured in bytes/second.
				speedDownload,
				/// The average upload speed measured in bytes/second.
				speedUpload,
				/// The content-length of the download. This value is obtained from the Content-Length header field.
				contentLengthDownload,
				/// The specified size of the upload.
				contentLengthUpload,
				/// The time, in seconds, it took from the start of the request until the first byte was received.
				startTransferTime,
				/// The total time, in seconds, it took for all redirection steps include name lookup, connect, pretransfer and transfer before final transaction was started.
				redirectTime,
				/// The time, in seconds, it took from the start until the SSL/SSH connect/handshake to the remote host was completed.
				appConnectTime
		}
//		cookieList, // SLIST
//		certInfo // SLIST
	}
	
	let curl: CURL
	var headers = Array<(Header.Name, String)>()
	
	/// The response's raw content body bytes.
	var bodyBytes = [UInt8]()
	
	var readState = ResponseReadState.status
	// these need to persist until the request has completed execution.
	// this is set by the CURLRequest
	var postFields: CURLRequest.POSTFields?
	
	init(_ curl: CURL, postFields: CURLRequest.POSTFields?) {
		self.curl = curl
		self.postFields = postFields
	}
}

extension CURLResponse {
	/// Get an response info String value.
	func get(_ stringValue: Info.StringValue) -> String? {
		return stringValue.get(self)
	}
	/// Get an response info Int value.
	func get(_ intValue: Info.IntValue) -> Int? {
		return intValue.get(self)
	}
	/// Get an response info Double value.
	func get(_ doubleValue: Info.DoubleValue) -> Double? {
		return doubleValue.get(self)
	}
	/// Get a response header value. Returns the first found instance or nil.
	func get(_ header: Header.Name) -> String? {
		return headers.first { header.standardName == $0.0.standardName }?.1
	}
	/// Get a response header's values. Returns all found instances.
	func get(all header: Header.Name) -> [String] {
		return headers.filter { header.standardName == $0.0.standardName }.map { $0.1 }
	}
}

extension CURLResponse {
	func complete() throws {
		setCURLOpts()
		curl.addSLists()
		let resultCode = curl_easy_perform(curl.curl)
		postFields = nil
		guard CURLE_OK == resultCode else {
			throw Error(self, code: resultCode)
		}
	}
	
	func complete(_ callback: @escaping (Confirmation) -> ()) {
		setCURLOpts()
		innerComplete(callback)
	}
	
	private func innerComplete(_ callback: @escaping (Confirmation) -> ()) {
		let (notDone, resultCode, _, _) = curl.perform()
		guard Int(CURLE_OK.rawValue) == resultCode else {
			postFields = nil
			return callback({ throw Error(self, code: CURLcode(rawValue: UInt32(resultCode))) })
		}
		if notDone {
			curl.ioWait {
				self.innerComplete(callback)
			}
		} else {
			postFields = nil
			callback({ return self })
		}
	}
	
	private func addHeaderLine(_ ptr: UnsafeBufferPointer<UInt8>) {
		if readState == .status {
			readState = .headers
		} else if ptr.count == 0 {
			readState = .body
		} else {
			let colon = 58 as UInt8, space = 32 as UInt8
			var pos = 0
			let max = ptr.count
			
			var tstNamePtr: UnsafeBufferPointer<UInt8>?
			
			while pos < max {
				defer {	pos += 1 }
				if ptr[pos] == colon {
					tstNamePtr = UnsafeBufferPointer(start: ptr.baseAddress, count: pos)
					while pos < max && ptr[pos+1] == space {
						pos += 1
					}
					break
				}
			}
			guard let namePtr = tstNamePtr, let base = ptr.baseAddress else {
				return
			}
			let valueStart = base+pos
			if valueStart[max-pos-1] == 10 {
				pos += 1
			}
			if valueStart[max-pos-1] == 13 {
				pos += 1
			}
			let valuePtr = UnsafeBufferPointer(start: valueStart, count: max-pos)
			let name = String(bytes: namePtr, encoding: .utf8) ?? ""
			let value = String(bytes: valuePtr, encoding: .utf8) ?? ""
			headers.append((Header.Name.fromStandard(name: name), value))
		}
	}
	
	private func addBodyData(_ ptr: UnsafeBufferPointer<UInt8>) {
		bodyBytes.append(contentsOf: ptr)
	}
	
	private func setCURLOpts() {
		let opaqueMe = UnsafeMutableRawPointer(Unmanaged.passUnretained(self).toOpaque())
		curl.setOption(CURLOPT_HEADERDATA, v: opaqueMe)
		curl.setOption(CURLOPT_WRITEDATA, v: opaqueMe)
		
		do {
			let readFunc: curl_func = {
				a, size, num, p -> Int in
				let crl = Unmanaged<CURLResponse>.fromOpaque(p!).takeUnretainedValue()
				if let bytes = a?.assumingMemoryBound(to: UInt8.self) {
					let fullCount = size*num
					let minimumHeaderLengthEvenAMalformedOne = 3
					crl.addHeaderLine(UnsafeBufferPointer(start: bytes,
					                                      count: fullCount >= minimumHeaderLengthEvenAMalformedOne ? fullCount : 0))
					return fullCount
				}
				return 0
			}
			curl.setOption(CURLOPT_HEADERFUNCTION, f: readFunc)
		}
		
		do {
			let readFunc: curl_func = {
				a, size, num, p -> Int in
				let crl = Unmanaged<CURLResponse>.fromOpaque(p!).takeUnretainedValue()
				if let bytes = a?.assumingMemoryBound(to: UInt8.self) {
					let fullCount = size*num
					crl.addBodyData(UnsafeBufferPointer(start: bytes, count: fullCount))
					return fullCount
				}
				return 0
			}
			curl.setOption(CURLOPT_WRITEFUNCTION, f: readFunc)
		}
	}
}

extension CURLResponse {
	/// Get the URL which the request may have been redirected to.
	var url: String { return get(.url) ?? "" }
	/// Get the HTTP response code
	var responseCode: Int { return get(.responseCode) ?? 0 }
}









