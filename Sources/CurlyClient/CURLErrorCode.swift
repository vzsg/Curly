import CCurlyCURL

public enum CURLErrorCode: Int {
    case unsupportedProtocol = 1
    case failedInit             /* 2 */
    case urlMalformat           /* 3 */
    case notBuiltIn            /* 4 - [was obsoleted in August 2007 for 7.17.0, reused in April 2011 for 7.21.5] */
    case couldntResolveProxy   /* 5 */
    case couldntResolveHost    /* 6 */
    case couldntConnect         /* 7 */
    case weirdServerReply      /* 8 */
    case remoteAccessDenied    /* 9 a service was denied by the server due to lack of access - when login fails this is not returned. */
    case ftpAcceptFailed       /* 10 - [was obsoleted in April 2006 for 7.15.4, reused in Dec 2011 for 7.24.0]*/
    case ftpWeirdPassReply    /* 11 */
    case ftpAcceptTimeout      /* 12 - timeout occurred accepting server
     [was obsoleted in August 2007 for 7.17.0, reused in Dec 2011 for 7.24.0]*/
    case ftpWeirdPasvReply    /* 13 */
    case ftpWeird227Format    /* 14 */
    case ftpCantGetHost       /* 15 */
    case http2                   /* 16 - A problem in the http2 framing layer.
     [was obsoleted in August 2007 for 7.17.0, reused in July 2014 for 7.38.0] */
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
    case peerFailedVerification /* 51 - peer's certificate or fingerprint wasn't verified fine */
    case gotNothing             /* 52 - when this is a specific error */
    case sslEngineNotfound     /* 53 - SSL crypto engine not found */
    case sslEngineSetfailed    /* 54 - can not set SSL crypto engine as default */
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
    case sendFailRewind        /* 65 - Sending the data requires a rewind that failed */
    case sslEngineInitfailed   /* 66 - failed to initialise ENGINE */
    case loginDenied            /* 67 - user, password or similar was not accepted and we failed to login */
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
    case sslCacertBadfile      /* 77 - could not load CACERT file, missing or wrong format */
    case remoteFileNotFound   /* 78 - remote file not found */
    case ssh                     /* 79 - error from the SSH layer, somewhat generic so the error message will be of interest when this has happened */
    case sslShutdownFailed     /* 80 - Failed to shut down the SSL connection */
    case again                   /* 81 - socket is not ready for send/recv, wait till it's ready and try again (Added in 7.18.2) */
    case sslCrlBadfile         /* 82 - could not load CRL file, missing or wrong format (Added in 7.19.0) */
    case sslIssuerError        /* 83 - Issuer check failed.  (Added in 7.19.0) */
    case ftpPretFailed         /* 84 - a PRET command failed */
    case rtspCseqError         /* 85 - mismatch of RTSP CSeq numbers */
    case rtspSessionError      /* 86 - mismatch of RTSP Session Ids */
    case ftpBadFileList       /* 87 - unable to parse FTP file list */
    case chunkFailed            /* 88 - chunk callback reported error */
    case noConnectionAvailable /* 89 - No connection available, the session will be queued */
    case sslPinnedpubkeynotmatch /* 90 - specified pinned public key did not match */
    case sslInvalidcertstatus   /* 91 - invalid certificate status */
    case http2Stream            /* 92 - stream error in HTTP/2 framing layer */
    case unknownCode = -1

    static func from(_ curlCode: CURLcode) -> CURLErrorCode {
        guard let code = self.init(rawValue: Int(curlCode.rawValue)) else {
            return .unknownCode
        }
        return code
    }
}
