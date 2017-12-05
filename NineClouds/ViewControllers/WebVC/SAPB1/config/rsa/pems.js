/**
 * Created by air on 2016/5/27.
 */
/**
 * 2015-02-03
 * zhaomaoxin
 * import keys
 */

var ursa = require('ursa');


var client_public  =    '-----BEGIN PUBLIC KEY-----\n'+
    'MFwwDQYJKoZIhvcNAQEBBQADSwAwSAJBAMNMx5+UbJhsSjh5a5kGT2cqJUNvQ19x\n'+
    '4gMjO9A37sc03TL6iZtwi2ddKyMuWEWUVBC6pAhAeHK2DzXOl4GzUasCAwEAAQ==\n'+
    '-----END PUBLIC KEY-----';


var client_private =    '-----BEGIN RSA PRIVATE KEY-----\n'+
    'MIIBVQIBADANBgkqhkiG9w0BAQEFAASCAT8wggE7AgEAAkEAw0zHn5RsmGxKOHlr\n'+
    'mQZPZyolQ29DX3HiAyM70DfuxzTdMvqJm3CLZ10rIy5YRZRUELqkCEB4crYPNc6X\n'+
    'gbNRqwIDAQABAkAyzAeoFBzi0FfFtJ8t4BxLAwVKMuhdLOvSURm/oKy0lzDYNZgI\n'+
    'fzZnE2RMXTdCMMgVoBTN1gJj50C3U45f4KFxAiEA7sTyhB/Y5s/UakN17jLuH3EP\n'+
    'dz0vanylmETmDhmhoh0CIQDRZMYHIifGI2L6IHxv+AlSSyTQ2mcqWMyaZ8IYPOv4\n'+
    'ZwIhALZrNbWH91jwM6M0AyeHNbJD2MMKte0vafyZtwHSx1BpAiEArxd2I6bi3WLf\n'+
    's8oQY8xjdwXQvjeyho2EYSSb/4qJwscCIHGmK7X2hHe5s4gBYbS047S9b068JhR4\n'+
    'lnKt7gUbncxP\n'+
    '-----END RSA PRIVATE KEY-----';
//var client_public  =    '-----BEGIN PUBLIC KEY-----\n'+
//    'MFwwDQYJKoZIhvcNAQEBBQADSwAwSAJBAJbG1KkX8YMwmnPxXWd1Z6jR7J0CX7mytecQF/+X5tn6\n'+
//    'Ta0d2oZj2AaQclSTCYbRix3dc5CdMUP00BTIxuE52sMCAwEAAQ==\n'+
//    '-----END PUBLIC KEY-----';
//
//
//var client_private =    '-----BEGIN RSA PRIVATE KEY-----\n'+
//    'MIIBVAIBADANBgkqhkiG9w0BAQEFAASCAT4wggE6AgEAAkEAlsbUqRfxgzCac/FdZ3VnqNHsnQJf\n'+
//'ubK15xAX/5fm2fpNrR3ahmPYBpByVJMJhtGLHd1zkJ0xQ/TQFMjG4TnawwIDAQABAkBu275cnYgr\n'+
//'hz7o5Jxih0YyMDcisi4j4SwxufmLKerIdUpjDxvXDcoseT8/t1d3RrzQilV/j5MzWqA9qCBbVDkh\n'+
//'AiEAxOu1mZQ9BADxpCQzP2xtYeOjKUyufjCDHXy62vVsDUkCIQDEAxNRwSuMzvn7+BZ6WEieiWcb\n'+
//'tHuJUBWxkomtNlwjqwIgadUcdnvbBwnS1Jq4CEAn0VJcYFfb9+nuraxZaFA6UDECIELPUYxyLSfn\n'+
//'fGmX3AGDie0PpGdbEyhwdZR7ABZcCvfVAiEAjWIOfWEKMzNbghDmuEDrEmkeMrM2Kp0aOgbOU7WE\n'+
//'kfs=\n'+
//    '-----END RSA PRIVATE KEY-----';


//var server_public  =    '-----BEGIN PUBLIC KEY-----\n'+
//    'MFwwDQYJKoZIhvcNAQEBBQADSwAwSAJBALFSzfjrIl8Vj0dbUVTvVEXnGMOL3O6I\n'+
//    'OWsK0EJcEk18BktuaIGC0gWb8f9MpL3cqouRaDuS2JM+xIZrocyA5YECAwEAAQ==\n'+
//    '-----END PUBLIC KEY-----';
var server_public  =    '-----BEGIN PUBLIC KEY-----\n'+
    'MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDvjMbSZ94Q7XJq+vJxdKlbTaAd\n'+
    'bqz/Ycxb5u2IPGbt5YjgDjQM2Pi/3m/J9q0Wx+w2kmX78eKH5o8D+T8jPP2CGxhd\n'+
    'kWh5jnh5gx6nOFUv3ddzl8R4mHKrd5jHji9Pjy2U7YDDPlth14aTqghbzRyKSmq+\n'+
    '/1OrsXbhXtW1X03n7wIDAQAB\n'+
    '-----END PUBLIC KEY-----';


//var server_private  =   '-----BEGIN RSA PRIVATE KEY-----\n'+
//    'MIIBPQIBAAJBALFSzfjrIl8Vj0dbUVTvVEXnGMOL3O6IOWsK0EJcEk18BktuaIGC\n'+
//    '0gWb8f9MpL3cqouRaDuS2JM+xIZrocyA5YECAwEAAQJBAJzBNaIZws3JklqjSFfM\n'+
//    'JnSRIZwkNQ+Mzy1oZshy+h8RznAxD0yQRgHvlU+cUhjLr4znQpyVSZ5686Ay9LI1\n'+
//    'eVECIQDhrcCUzOKsVhEjlotfDpBHixWdJNzt62UcLwdXthW/dQIhAMkl3fDGE7wR\n'+
//    'ZIjRSVOgGU8VgR67WV14DNXD8cqVffhdAiEAkVu8wxsElUQKXgXFV0CmJa6sCT+J\n'+
//    'HaWUxoZ0EEaz01ECIQC++sUOpgJ2vczGWm9Uht2AyNofY6IlrKYDEFeyEN3ZwQIh\n'+
//    'AJ+UaCEDeiFRwSxFYnCpkhTU1ZUVrzo4HaZuAt780KBD\n'+
//    '-----END RSA PRIVATE KEY-----';
var server_private  =   '-----BEGIN RSA PRIVATE KEY-----\n'+
    'MIICeAIBADANBgkqhkiG9w0BAQEFAASCAmIwggJeAgEAAoGBAO+MxtJn3hDtcmr6\n'+
'8nF0qVtNoB1urP9hzFvm7Yg8Zu3liOAONAzY+L/eb8n2rRbH7DaSZfvx4ofmjwP5\n'+
'PyM8/YIbGF2RaHmOeHmDHqc4VS/d13OXxHiYcqt3mMeOL0+PLZTtgMM+W2HXhpOq\n'+
'CFvNHIpKar7/U6uxduFe1bVfTefvAgMBAAECgYEAjavdPjytiadUXs6xKcZMDrJ2\n'+
'+lElQRguyz9kxYirexCgBZqA0ARWAOtlg7U+otVz7sZgSEPCrIr/k+MJoyaD6hRo\n'+
'HSEZh4hySH/QcpSrIq+hIQUGWAtexRAk2dicf4pUqEgTFjQl9VPhKn5yZZcca2Sn\n'+
'9V/DQgPTGuB6WvOOEokCQQD9/DJyrR3VNXPq3d2CFa1RVBYmFiRAMgScCBLF4SHh\n'+
'PiPJZb8cScUO9KNJmB9wUXxnwDys91aJjm1N2pD0jfPtAkEA8XNDke40k5T7jfuX\n'+
'mzI7UrA1R07a3MSrA0Lp3PTpdwiwQmgN1zvoPTdc/0SBH3dpr8k6dJitN/199Obo\n'+
'lxoHywJAMk2k4DmRUw0HLFlM6drJPPZefKSeAWjmqNCghziTsTzRca4JL90cfl3N\n'+
'iWHruB8reJEGc2t5ZD0lQOotE4KZ8QJBAKhHWVSf3GzvbNNsAiHcRJRA0yE7yDYN\n'+
'q9K+FBg3aW/Y0l+1/c+ApT/lEh+nMwcnRrWJXgBdWHypY9wIAxssvTkCQQD0WPMm\n'+
'MO2ji36N0LFmb3O14eJN+JpznSR0SS+LPa4kW3DoZfuSGEBwkJ10PTrKMC3VC8bt\n'+
'yoypieVTmKfT7qdh\n'+
'-----END RSA PRIVATE KEY-----';

var server = {
    pem :ursa.createPrivateKey(server_private),
    pub :ursa.createPublicKey(server_public)
};

var client = {
    pub :ursa.createPublicKey(client_public),
    pem :ursa.createPrivateKey(client_private)
};

exports.server = server;
exports.client = client;