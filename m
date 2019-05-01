Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Message-ID: <1689977da7b323b360c35fc021a67e766c3347bb.camel@infradead.org>
Subject: Re: [SeaBIOS] Real mode kexec failure with non-IDE disk
From: David Woodhouse <dwmw2@infradead.org>
Date: Wed, 01 May 2019 23:16:03 +0300
In-Reply-To: <20190501025601.GA5342@morn.lan>
References: <e5872703412f9a56c10df52d9793ca2a6401d7f0.camel@infradead.org>
 <20190501025601.GA5342@morn.lan>
Mime-Version: 1.0
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============7052497537021981380=="
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Kevin O'Connor <kevin@koconnor.net>
Cc: seabios@seabios.org, kexec <kexec@lists.infradead.org>


--===============7052497537021981380==
Content-Type: multipart/signed; micalg="sha-256";
	protocol="application/x-pkcs7-signature";
	boundary="=-AHPUHpYFwrFM7Ps8W61U"


--=-AHPUHpYFwrFM7Ps8W61U
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2019-04-30 at 22:56 -0400, Kevin O'Connor wrote:
> Hi David,
>=20
> That call trace certainly looks odd.  The SeaBIOS debugging info would
> help - try compiling SeaBIOS with debug level 8 and grab the log (as
> described at: https://www.seabios.org/Debugging#Diagnostic_information
> ).

Choosing Xen because it actually succeeds, while Linux real-mode boot
then dies a bit later even if I use IDE disks...

This SeaBIOS git master (f4c6e4c1) with an IDE disk, from the moment of
kexec:

unimplemented handle_15XX:330:
   a=3D0000ec00  b=3D00000002  c=3D00000000  d=3D00000000 ds=3D8f00 es=3D8f=
00 ss=3Dd980
  si=3D00000000 di=3D00000000 bp=3D00000000 sp=3D0000fe8e cs=3D8f00 ip=3D00=
60  f=3D0246
enter handle_12:
   a=3D534d3c00  b=3D0000befe  c=3D00003c00  d=3D002ffb80 ds=3D8f00 es=3D8f=
00 ss=3Dd980
  si=3D00000000 di=3D00000af1 bp=3D00000000 sp=3D0000fe8e cs=3D8f00 ip=3D01=
43  f=3D0202
invalid handle_legacy_disk:729:
   a=3D534d4139  b=3D000055aa  c=3D0000fe03  d=3D002ffb81 ds=3D8f00 es=3D8f=
00 ss=3Dd980
  si=3D00001539 di=3D00000000 bp=3D00000000 sp=3D0000fe8e cs=3D8f00 ip=3D01=
5b  f=3D0293
invalid handle_legacy_disk:729:
   a=3D534d0201  b=3D00000000  c=3D889f0001  d=3D002f0081 ds=3D8f00 es=3D8e=
e0 ss=3Dd980
  si=3D0000aa55 di=3D00000000 bp=3D00000000 sp=3D0000fe8e cs=3D8f00 ip=3D02=
02  f=3D0247
 Xen 4.11.2-pre
(XEN) Xen version 4.11.2-pre (dwmw@ant.amazon.com) (gcc (Ubuntu 7.3.0-27ubu=
ntu1~18.04) 7.3.0) debug=3Dn  Wed May  1 22:08:39 IDT 2019
(XEN) Latest ChangeSet: Wed May 1 13:37:09 2019 +0300 git:7c281700a8
(XEN) Bootloader: kexec 2.0.19.git
(XEN) Command line: console=3Dvga,com1
(XEN) Xen image load base address: 0
(XEN) Video information:
(XEN)  VGA is text mode 80x25, font 8x16
(XEN) Disc information:
(XEN)  Found 1 MBR signatures
(XEN)  Found 1 EDD information structures

And this is all I see when the disk is virtio:

unimplemented handle_15XX:330:
   a=3D0000ec00  b=3D00000002  c=3D00000000  d=3D00000000 ds=3D8f00 es=3D8f=
00 ss=3Dd980
  si=3D00000000 di=3D00000000 bp=3D00000000 sp=3D0000fe8e cs=3D8f00 ip=3D00=
60  f=3D0246
enter handle_12:
   a=3D534d3c00  b=3D0000befd  c=3D00003c00  d=3D002ffb40 ds=3D8f00 es=3D8f=
00 ss=3Dd980
  si=3D00000000 di=3D00000af1 bp=3D00000000 sp=3D0000fe8e cs=3D8f00 ip=3D01=
43  f=3D0202
invalid handle_legacy_disk:729:
   a=3D534d4139  b=3D000055aa  c=3D0000fe03  d=3D002ffb81 ds=3D8f00 es=3D8f=
00 ss=3Dd980
  si=3D00001539 di=3D00000000 bp=3D00000000 sp=3D0000fe8e cs=3D8f00 ip=3D01=
5b  f=3D0293

Increasing debug to 9, I see:

enter handle_15:
   a=3D0000ec00  b=3D00000002  c=3D00000000  d=3D00000000 ds=3D8f00 es=3D8f=
00 ss=3Dd980
  si=3D00000000 di=3D00000000 bp=3D00000000 sp=3D0000f96e cs=3D8f00 ip=3D00=
60  f=3D0246
unimplemented handle_15XX:330:
   a=3D0000ec00  b=3D00000002  c=3D00000000  d=3D00000000 ds=3D8f00 es=3D8f=
00 ss=3Dd980
  si=3D00000000 di=3D00000000 bp=3D00000000 sp=3D0000f96e cs=3D8f00 ip=3D00=
60  f=3D0246
enter handle_15:
   a=3D0000e820  b=3D00000000  c=3D00000014  d=3D534d4150 ds=3D8f00 es=3D8f=
00 ss=3Dd980
  si=3D00000000 di=3D00000a51 bp=3D00000000 sp=3D0000f96e cs=3D8f00 ip=3D00=
ec  f=3D0246
enter handle_15:
   a=3D0000e820  b=3D00000001  c=3D00000014  d=3D534d4150 ds=3D8f00 es=3D8f=
00 ss=3Dd980
  si=3D00000000 di=3D00000a65 bp=3D00000000 sp=3D0000f96e cs=3D8f00 ip=3D00=
ec  f=3D0202
enter handle_15:
   a=3D0000e820  b=3D00000002  c=3D00000014  d=3D534d4150 ds=3D8f00 es=3D8f=
00 ss=3Dd980
  si=3D00000000 di=3D00000a79 bp=3D00000000 sp=3D0000f96e cs=3D8f00 ip=3D00=
ec  f=3D0202
enter handle_15:
   a=3D0000e820  b=3D00000003  c=3D00000014  d=3D534d4150 ds=3D8f00 es=3D8f=
00 ss=3Dd980
  si=3D00000000 di=3D00000a8d bp=3D00000000 sp=3D0000f96e cs=3D8f00 ip=3D00=
ec  f=3D0206
enter handle_15:
   a=3D0000e820  b=3D00000004  c=3D00000014  d=3D534d4150 ds=3D8f00 es=3D8f=
00 ss=3Dd980
  si=3D00000000 di=3D00000aa1 bp=3D00000000 sp=3D0000f96e cs=3D8f00 ip=3D00=
ec  f=3D0202
enter handle_15:
   a=3D0000e820  b=3D00000005  c=3D00000014  d=3D534d4150 ds=3D8f00 es=3D8f=
00 ss=3Dd980
  si=3D00000000 di=3D00000ab5 bp=3D00000000 sp=3D0000f96e cs=3D8f00 ip=3D00=
ec  f=3D0206
enter handle_15:
   a=3D0000e820  b=3D00000006  c=3D00000014  d=3D534d4150 ds=3D8f00 es=3D8f=
00 ss=3Dd980
  si=3D00000000 di=3D00000ac9 bp=3D00000000 sp=3D0000f96e cs=3D8f00 ip=3D00=
ec  f=3D0206
enter handle_15:
   a=3D0000e820  b=3D00000007  c=3D00000014  d=3D534d4150 ds=3D8f00 es=3D8f=
00 ss=3Dd980
  si=3D00000000 di=3D00000add bp=3D00000000 sp=3D0000f96e cs=3D8f00 ip=3D00=
ec  f=3D0202
enter handle_15:
   a=3D534d88f1  b=3D00000000  c=3D00000014  d=3D534d4150 ds=3D8f00 es=3D8f=
00 ss=3Dd980
  si=3D00000000 di=3D00000af1 bp=3D00000000 sp=3D0000f96e cs=3D8f00 ip=3D01=
12  f=3D0246
enter handle_15:
   a=3D534de801  b=3D00000000  c=3D00000000  d=3D534d0000 ds=3D8f00 es=3D8f=
00 ss=3Dd980
  si=3D00000000 di=3D00000af1 bp=3D00000000 sp=3D0000f96e cs=3D8f00 ip=3D01=
1f  f=3D0246
enter handle_12:
   a=3D534d3c00  b=3D0000befd  c=3D00003c00  d=3D002ffb40 ds=3D8f00 es=3D8f=
00 ss=3Dd980
  si=3D00000000 di=3D00000af1 bp=3D00000000 sp=3D0000f96e cs=3D8f00 ip=3D01=
43  f=3D0202
invalid handle_legacy_disk:729:
   a=3D534d4139  b=3D000055aa  c=3D0000fe03  d=3D002ffb81 ds=3D8f00 es=3D8f=
00 ss=3Dd980
  si=3D00001539 di=3D00000000 bp=3D00000000 sp=3D0000f96e cs=3D8f00 ip=3D01=
5b  f=3D0293
call32_smm 0x000ed91a e9120
handle_smi cmd=3Db5 smbase=3D0x000a0000
vp notify fe003000 (2) -- 0x0
call16_smm 0x00007a79 0 0
handle_smi cmd=3Db5 smbase=3D0x000a0000
handle_smi cmd=3Db5 smbase=3D0x000a0000
call16_smm 0x00007a79 0 0
handle_smi cmd=3Db5 smbase=3D0x000a0000
handle_smi cmd=3Db5 smbase=3D0x000a0000
call16_smm 0x00007a79 0 0
handle_smi cmd=3Db5 smbase=3D0x000a0000
handle_smi cmd=3Db5 smbase=3D0x000a0000
call16_smm 0x00007a79 0 0
handle_smi cmd=3Db5 smbase=3D0x000a0000
handle_smi cmd=3Db5 smbase=3D0x000a0000
call16_smm 0x00007a79 0 0
handle_smi cmd=3Db5 smbase=3D0x000a0000
handle_smi cmd=3Db5 smbase=3D0x000a0000
call16_smm 0x00007a79 0 0
handle_smi cmd=3Db5 smbase=3D0x000a0000
handle_smi cmd=3Db5 smbase=3D0x000a0000
call16_smm 0x00007a79 0 0
handle_smi cmd=3Db5 smbase=3D0x000a0000
handle_smi cmd=3Db5 smbase=3D0x000a0000
call16_smm 0x00007a79 0 0
handle_smi cmd=3Db5 smbase=3D0x000a0000
handle_smi cmd=3Db5 smbase=3D0x000a0000
call16_smm 0x00007a79 0 0
handle_smi cmd=3Db5 smbase=3D0x000a0000
handle_smi cmd=3Db5 smbase=3D0x000a0000
call16_smm 0x00007a79 0 0
handle_smi cmd=3Db5 smbase=3D0x000a0000
handle_smi cmd=3Db5 smbase=3D0x000a0000
call16_smm 0x00007a79 0 0
handle_smi cmd=3Db5 smbase=3D0x000a0000
handle_smi cmd=3Db5 smbase=3D0x000a0000
call16_smm 0x00007a79 0 0
...=20

That just goes on for ever. The full log from boot (including the boot
of the first kernel) is at http://david.woodhou.se/smi-wtf.txt



--=-AHPUHpYFwrFM7Ps8W61U
Content-Type: application/x-pkcs7-signature; name="smime.p7s"
Content-Disposition: attachment; filename="smime.p7s"
Content-Transfer-Encoding: base64

MIAGCSqGSIb3DQEHAqCAMIACAQExDzANBglghkgBZQMEAgEFADCABgkqhkiG9w0BBwEAAKCCECow
ggUcMIIEBKADAgECAhEA4rtJSHkq7AnpxKUY8ZlYZjANBgkqhkiG9w0BAQsFADCBlzELMAkGA1UE
BhMCR0IxGzAZBgNVBAgTEkdyZWF0ZXIgTWFuY2hlc3RlcjEQMA4GA1UEBxMHU2FsZm9yZDEaMBgG
A1UEChMRQ09NT0RPIENBIExpbWl0ZWQxPTA7BgNVBAMTNENPTU9ETyBSU0EgQ2xpZW50IEF1dGhl
bnRpY2F0aW9uIGFuZCBTZWN1cmUgRW1haWwgQ0EwHhcNMTkwMTAyMDAwMDAwWhcNMjIwMTAxMjM1
OTU5WjAkMSIwIAYJKoZIhvcNAQkBFhNkd213MkBpbmZyYWRlYWQub3JnMIIBIjANBgkqhkiG9w0B
AQEFAAOCAQ8AMIIBCgKCAQEAsv3wObLTCbUA7GJqKj9vHGf+Fa+tpkO+ZRVve9EpNsMsfXhvFpb8
RgL8vD+L133wK6csYoDU7zKiAo92FMUWaY1Hy6HqvVr9oevfTV3xhB5rQO1RHJoAfkvhy+wpjo7Q
cXuzkOpibq2YurVStHAiGqAOMGMXhcVGqPuGhcVcVzVUjsvEzAV9Po9K2rpZ52FE4rDkpDK1pBK+
uOAyOkgIg/cD8Kugav5tyapydeWMZRJQH1vMQ6OVT24CyAn2yXm2NgTQMS1mpzStP2ioPtTnszIQ
Ih7ASVzhV6csHb8Yrkx8mgllOyrt9Y2kWRRJFm/FPRNEurOeNV6lnYAXOymVJwIDAQABo4IB0zCC
Ac8wHwYDVR0jBBgwFoAUgq9sjPjF/pZhfOgfPStxSF7Ei8AwHQYDVR0OBBYEFLfuNf820LvaT4AK
xrGK3EKx1DE7MA4GA1UdDwEB/wQEAwIFoDAMBgNVHRMBAf8EAjAAMB0GA1UdJQQWMBQGCCsGAQUF
BwMEBggrBgEFBQcDAjBGBgNVHSAEPzA9MDsGDCsGAQQBsjEBAgEDBTArMCkGCCsGAQUFBwIBFh1o
dHRwczovL3NlY3VyZS5jb21vZG8ubmV0L0NQUzBaBgNVHR8EUzBRME+gTaBLhklodHRwOi8vY3Js
LmNvbW9kb2NhLmNvbS9DT01PRE9SU0FDbGllbnRBdXRoZW50aWNhdGlvbmFuZFNlY3VyZUVtYWls
Q0EuY3JsMIGLBggrBgEFBQcBAQR/MH0wVQYIKwYBBQUHMAKGSWh0dHA6Ly9jcnQuY29tb2RvY2Eu
Y29tL0NPTU9ET1JTQUNsaWVudEF1dGhlbnRpY2F0aW9uYW5kU2VjdXJlRW1haWxDQS5jcnQwJAYI
KwYBBQUHMAGGGGh0dHA6Ly9vY3NwLmNvbW9kb2NhLmNvbTAeBgNVHREEFzAVgRNkd213MkBpbmZy
YWRlYWQub3JnMA0GCSqGSIb3DQEBCwUAA4IBAQALbSykFusvvVkSIWttcEeifOGGKs7Wx2f5f45b
nv2ghcxK5URjUvCnJhg+soxOMoQLG6+nbhzzb2rLTdRVGbvjZH0fOOzq0LShq0EXsqnJbbuwJhK+
PnBtqX5O23PMHutP1l88AtVN+Rb72oSvnD+dK6708JqqUx2MAFLMevrhJRXLjKb2Mm+/8XBpEw+B
7DisN4TMlLB/d55WnT9UPNHmQ+3KFL7QrTO8hYExkU849g58Dn3Nw3oCbMUgny81ocrLlB2Z5fFG
Qu1AdNiBA+kg/UxzyJZpFbKfCITd5yX49bOriL692aMVDyqUvh8fP+T99PqorH4cIJP6OxSTdxKM
MIIFHDCCBASgAwIBAgIRAOK7SUh5KuwJ6cSlGPGZWGYwDQYJKoZIhvcNAQELBQAwgZcxCzAJBgNV
BAYTAkdCMRswGQYDVQQIExJHcmVhdGVyIE1hbmNoZXN0ZXIxEDAOBgNVBAcTB1NhbGZvcmQxGjAY
BgNVBAoTEUNPTU9ETyBDQSBMaW1pdGVkMT0wOwYDVQQDEzRDT01PRE8gUlNBIENsaWVudCBBdXRo
ZW50aWNhdGlvbiBhbmQgU2VjdXJlIEVtYWlsIENBMB4XDTE5MDEwMjAwMDAwMFoXDTIyMDEwMTIz
NTk1OVowJDEiMCAGCSqGSIb3DQEJARYTZHdtdzJAaW5mcmFkZWFkLm9yZzCCASIwDQYJKoZIhvcN
AQEBBQADggEPADCCAQoCggEBALL98Dmy0wm1AOxiaio/bxxn/hWvraZDvmUVb3vRKTbDLH14bxaW
/EYC/Lw/i9d98CunLGKA1O8yogKPdhTFFmmNR8uh6r1a/aHr301d8YQea0DtURyaAH5L4cvsKY6O
0HF7s5DqYm6tmLq1UrRwIhqgDjBjF4XFRqj7hoXFXFc1VI7LxMwFfT6PStq6WedhROKw5KQytaQS
vrjgMjpICIP3A/CroGr+bcmqcnXljGUSUB9bzEOjlU9uAsgJ9sl5tjYE0DEtZqc0rT9oqD7U57My
ECIewElc4VenLB2/GK5MfJoJZTsq7fWNpFkUSRZvxT0TRLqznjVepZ2AFzsplScCAwEAAaOCAdMw
ggHPMB8GA1UdIwQYMBaAFIKvbIz4xf6WYXzoHz0rcUhexIvAMB0GA1UdDgQWBBS37jX/NtC72k+A
CsaxitxCsdQxOzAOBgNVHQ8BAf8EBAMCBaAwDAYDVR0TAQH/BAIwADAdBgNVHSUEFjAUBggrBgEF
BQcDBAYIKwYBBQUHAwIwRgYDVR0gBD8wPTA7BgwrBgEEAbIxAQIBAwUwKzApBggrBgEFBQcCARYd
aHR0cHM6Ly9zZWN1cmUuY29tb2RvLm5ldC9DUFMwWgYDVR0fBFMwUTBPoE2gS4ZJaHR0cDovL2Ny
bC5jb21vZG9jYS5jb20vQ09NT0RPUlNBQ2xpZW50QXV0aGVudGljYXRpb25hbmRTZWN1cmVFbWFp
bENBLmNybDCBiwYIKwYBBQUHAQEEfzB9MFUGCCsGAQUFBzAChklodHRwOi8vY3J0LmNvbW9kb2Nh
LmNvbS9DT01PRE9SU0FDbGllbnRBdXRoZW50aWNhdGlvbmFuZFNlY3VyZUVtYWlsQ0EuY3J0MCQG
CCsGAQUFBzABhhhodHRwOi8vb2NzcC5jb21vZG9jYS5jb20wHgYDVR0RBBcwFYETZHdtdzJAaW5m
cmFkZWFkLm9yZzANBgkqhkiG9w0BAQsFAAOCAQEAC20spBbrL71ZEiFrbXBHonzhhirO1sdn+X+O
W579oIXMSuVEY1LwpyYYPrKMTjKECxuvp24c829qy03UVRm742R9Hzjs6tC0oatBF7KpyW27sCYS
vj5wbal+TttzzB7rT9ZfPALVTfkW+9qEr5w/nSuu9PCaqlMdjABSzHr64SUVy4ym9jJvv/FwaRMP
gew4rDeEzJSwf3eeVp0/VDzR5kPtyhS+0K0zvIWBMZFPOPYOfA59zcN6AmzFIJ8vNaHKy5QdmeXx
RkLtQHTYgQPpIP1Mc8iWaRWynwiE3ecl+PWzq4i+vdmjFQ8qlL4fHz/k/fT6qKx+HCCT+jsUk3cS
jDCCBeYwggPOoAMCAQICEGqb4Tg7/ytrnwHV2binUlYwDQYJKoZIhvcNAQEMBQAwgYUxCzAJBgNV
BAYTAkdCMRswGQYDVQQIExJHcmVhdGVyIE1hbmNoZXN0ZXIxEDAOBgNVBAcTB1NhbGZvcmQxGjAY
BgNVBAoTEUNPTU9ETyBDQSBMaW1pdGVkMSswKQYDVQQDEyJDT01PRE8gUlNBIENlcnRpZmljYXRp
b24gQXV0aG9yaXR5MB4XDTEzMDExMDAwMDAwMFoXDTI4MDEwOTIzNTk1OVowgZcxCzAJBgNVBAYT
AkdCMRswGQYDVQQIExJHcmVhdGVyIE1hbmNoZXN0ZXIxEDAOBgNVBAcTB1NhbGZvcmQxGjAYBgNV
BAoTEUNPTU9ETyBDQSBMaW1pdGVkMT0wOwYDVQQDEzRDT01PRE8gUlNBIENsaWVudCBBdXRoZW50
aWNhdGlvbiBhbmQgU2VjdXJlIEVtYWlsIENBMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKC
AQEAvrOeV6wodnVAFsc4A5jTxhh2IVDzJXkLTLWg0X06WD6cpzEup/Y0dtmEatrQPTRI5Or1u6zf
+bGBSyD9aH95dDSmeny1nxdlYCeXIoymMv6pQHJGNcIDpFDIMypVpVSRsivlJTRENf+RKwrB6vcf
WlP8dSsE3Rfywq09N0ZfxcBa39V0wsGtkGWC+eQKiz4pBZYKjrc5NOpG9qrxpZxyb4o4yNNwTqza
aPpGRqXB7IMjtf7tTmU2jqPMLxFNe1VXj9XB1rHvbRikw8lBoNoSWY66nJN/VCJv5ym6Q0mdCbDK
CMPybTjoNCQuelc0IAaO4nLUXk0BOSxSxt8kCvsUtQIDAQABo4IBPDCCATgwHwYDVR0jBBgwFoAU
u69+Aj36pvE8hI6t7jiY7NkyMtQwHQYDVR0OBBYEFIKvbIz4xf6WYXzoHz0rcUhexIvAMA4GA1Ud
DwEB/wQEAwIBhjASBgNVHRMBAf8ECDAGAQH/AgEAMBEGA1UdIAQKMAgwBgYEVR0gADBMBgNVHR8E
RTBDMEGgP6A9hjtodHRwOi8vY3JsLmNvbW9kb2NhLmNvbS9DT01PRE9SU0FDZXJ0aWZpY2F0aW9u
QXV0aG9yaXR5LmNybDBxBggrBgEFBQcBAQRlMGMwOwYIKwYBBQUHMAKGL2h0dHA6Ly9jcnQuY29t
b2RvY2EuY29tL0NPTU9ET1JTQUFkZFRydXN0Q0EuY3J0MCQGCCsGAQUFBzABhhhodHRwOi8vb2Nz
cC5jb21vZG9jYS5jb20wDQYJKoZIhvcNAQEMBQADggIBAHhcsoEoNE887l9Wzp+XVuyPomsX9vP2
SQgG1NgvNc3fQP7TcePo7EIMERoh42awGGsma65u/ITse2hKZHzT0CBxhuhb6txM1n/y78e/4ZOs
0j8CGpfb+SJA3GaBQ+394k+z3ZByWPQedXLL1OdK8aRINTsjk/H5Ns77zwbjOKkDamxlpZ4TKSDM
KVmU/PUWNMKSTvtlenlxBhh7ETrN543j/Q6qqgCWgWuMAXijnRglp9fyadqGOncjZjaaSOGTTFB+
E2pvOUtY+hPebuPtTbq7vODqzCM6ryEhNhzf+enm0zlpXK7q332nXttNtjv7VFNYG+I31gnMrwfH
M5tdhYF/8v5UY5g2xANPECTQdu9vWPoqNSGDt87b3gXb1AiGGaI06vzgkejL580ul+9hz9D0S0U4
jkhJiA7EuTecP/CFtR72uYRBcunwwH3fciPjviDDAI9SnC/2aPY8ydehzuZutLbZdRJ5PDEJM/1t
yZR2niOYihZ+FCbtf3D9mB12D4ln9icgc7CwaxpNSCPt8i/GqK2HsOgkL3VYnwtx7cJUmpvVdZ4o
gnzgXtgtdk3ShrtOS1iAN2ZBXFiRmjVzmehoMof06r1xub+85hFQzVxZx5/bRaTKTlL8YXLI8nAb
R9HWdFqzcOoB/hxfEyIQpx9/s81rgzdEZOofSlZHynoSMYIDyjCCA8YCAQEwga0wgZcxCzAJBgNV
BAYTAkdCMRswGQYDVQQIExJHcmVhdGVyIE1hbmNoZXN0ZXIxEDAOBgNVBAcTB1NhbGZvcmQxGjAY
BgNVBAoTEUNPTU9ETyBDQSBMaW1pdGVkMT0wOwYDVQQDEzRDT01PRE8gUlNBIENsaWVudCBBdXRo
ZW50aWNhdGlvbiBhbmQgU2VjdXJlIEVtYWlsIENBAhEA4rtJSHkq7AnpxKUY8ZlYZjANBglghkgB
ZQMEAgEFAKCCAe0wGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0BCQUxDxcNMTkw
NTAxMjAxNjAzWjAvBgkqhkiG9w0BCQQxIgQgMMlhGwGrPMmTj+0GLXYhYZ0EanETXRLuuxE91LqV
uvQwgb4GCSsGAQQBgjcQBDGBsDCBrTCBlzELMAkGA1UEBhMCR0IxGzAZBgNVBAgTEkdyZWF0ZXIg
TWFuY2hlc3RlcjEQMA4GA1UEBxMHU2FsZm9yZDEaMBgGA1UEChMRQ09NT0RPIENBIExpbWl0ZWQx
PTA7BgNVBAMTNENPTU9ETyBSU0EgQ2xpZW50IEF1dGhlbnRpY2F0aW9uIGFuZCBTZWN1cmUgRW1h
aWwgQ0ECEQDiu0lIeSrsCenEpRjxmVhmMIHABgsqhkiG9w0BCRACCzGBsKCBrTCBlzELMAkGA1UE
BhMCR0IxGzAZBgNVBAgTEkdyZWF0ZXIgTWFuY2hlc3RlcjEQMA4GA1UEBxMHU2FsZm9yZDEaMBgG
A1UEChMRQ09NT0RPIENBIExpbWl0ZWQxPTA7BgNVBAMTNENPTU9ETyBSU0EgQ2xpZW50IEF1dGhl
bnRpY2F0aW9uIGFuZCBTZWN1cmUgRW1haWwgQ0ECEQDiu0lIeSrsCenEpRjxmVhmMA0GCSqGSIb3
DQEBAQUABIIBAD6wa6LSe11W92BheWXkay+smkQqjA1q+L1oBQdheEkIMAjfDUVjxEdjFFAmTV+3
DCXqWedFRv18Iy/CxV121d5LArV1p+KhoGvws0RMT2W2IEkp9q+AfrHgY+oAjAukWlZTc555Gye/
nnCxSGUUiFR7yh2+8AGCa0MNnOsREtBXJEVmNbdTrnYy52WhzNkBb32vVDLdR+WMDcmtxzsIAtD8
LSmyGdVXfa+jcB1vFBIkWNX3ZA4uaIMnpuUcjqyR7Z08jxebqmrWHPDacqDOIAwKoQY8u+QBYfmW
bIUwWBJKx1Za/6ZEoH6wysfqamnj+aFv0/m1R8wk2jeZKrNS34kAAAAAAAA=


--=-AHPUHpYFwrFM7Ps8W61U--



--===============7052497537021981380==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

--===============7052497537021981380==--


