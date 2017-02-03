/* This is the CA certificate for the CA trust chain of
   www.howsmyssl.com in PEM format, as dumped via:
   openssl s_client -showcerts -connect www.howsmyssl.com:443 </dev/null
   The CA cert is the last cert in the chain output by the server.

   For Mainflux case, we can use:
		cat certs/ca.crt | sed 's/^\(.*\)$/"\1\\r\\n"/'
*/
#include <stdio.h>
#include <stdint.h>
#include <string.h>

/*
 1 s:/C=US/O=Let's Encrypt/CN=Let's Encrypt Authority X3
   i:/O=Digital Signature Trust Co./CN=DST Root CA X3
 */
const char *mainflux_ca_cert = "-----BEGIN CERTIFICATE-----\r\n"
"MIIDhDCCAmygAwIBAgIJAPOWQ/k/52/dMA0GCSqGSIb3DQEBDQUAMFcxEjAQBgNV\r\n"
"BAMMCWxvY2FsaG9zdDERMA8GA1UECgwITWFpbmZsdXgxDDAKBgNVBAsMA0lvVDEg\r\n"
"MB4GCSqGSIb3DQEJARYRaW5mb0BtYWluZmx1eC5jb20wHhcNMTcwMTA3MDA0MzE4\r\n"
"WhcNMzIwMTA0MDA0MzE4WjBXMRIwEAYDVQQDDAlsb2NhbGhvc3QxETAPBgNVBAoM\r\n"
"CE1haW5mbHV4MQwwCgYDVQQLDANJb1QxIDAeBgkqhkiG9w0BCQEWEWluZm9AbWFp\r\n"
"bmZsdXguY29tMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAzOueTshY\r\n"
"eIDpcedEB+QcgmON72NXVkZ9s9rbNMCCLRoEl947m0SBfz4RXXXRh/plHNgEInsC\r\n"
"Z90LpKhyo5X8U1FIzTNefg3iMdov+wOGnGQJHydLSEbzWCDHjP54+W7XlQaA4/GT\r\n"
"76Os4m6e5LyLdb6jIQQx7EzZnJFQ9g85eldqEGz/tBn6eDLpHSt0ZidClUEGIJcV\r\n"
"5eeGRxKTrExnD1mSkDa63/s6M4fxkacxrwxnwVUdnSvHDxTOt5Mctrqlun63Sn+W\r\n"
"+9Afr5fZUdgROLkLhxWRVUbXMvh3OI5zMHpcONCvIr+gMEeM4q+AyVjCzYzMrDZ7\r\n"
"pvuhM4PGeAMAIwIDAQABo1MwUTAdBgNVHQ4EFgQUiBGMTsVJvNuSKvwoi/7aEvGf\r\n"
"RX0wHwYDVR0jBBgwFoAUiBGMTsVJvNuSKvwoi/7aEvGfRX0wDwYDVR0TAQH/BAUw\r\n"
"AwEB/zANBgkqhkiG9w0BAQ0FAAOCAQEARgi7Cr4JJmoOuP795OYxpVxZBxqnHOMi\r\n"
"2qFeiAwlg3M310YvZaJoewVK44hGNKtRbxc1CelEhRMCFabU5/xQOJmmx3bogNUc\r\n"
"944IfreJyJuUy7q3/6Ix3jf/rH1dpUVZ0S6baldIPKPzNNvmO6VFfmb+dymrMPCM\r\n"
"VQ4w+XoipLS5lPvG4z2/xz2auEAM5qtVjWQFB51Ju63bqKDQTwi+TaQSAu+9Dwr+\r\n"
"10w7qRZogM0anb8Q4Aq14Y7kplnu22VTVHaTyWb5FW4loWKP8FabzNCTOWneidVV\r\n"
"ApEfujCy2Bxw+bNxDtIp1ovPv2vljtJfdnFAKfBElw9BSPg/exUMHw==\r\n"
"-----END CERTIFICATE-----\r\n";
