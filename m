Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from 54-240-197-238.amazon.com ([54.240.197.238]
 helo=u3832b3a9db3152.hfa13.amazon.com)
 by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
 id 1hKhPw-0007VX-7I
 for kexec@lists.infradead.org; Sun, 28 Apr 2019 10:52:20 +0000
Message-ID: <3d9c5c7c501b4d97feffae2bdb6fc84fb40e144a.camel@infradead.org>
Subject: [PATCH] xen: Avoid overlapping segments in low memory
From: David Woodhouse <dwmw2@infradead.org>
Date: Sun, 28 Apr 2019 13:52:12 +0300
Mime-Version: 1.0
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============6491993105850171727=="
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec <kexec@lists.infradead.org>


--===============6491993105850171727==
Content-Type: multipart/signed; micalg="sha-256";
	protocol="application/x-pkcs7-signature";
	boundary="=-zoREpeGRbNqEarK/1XXl"


--=-zoREpeGRbNqEarK/1XXl
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

From: David Woodhouse <dwmw@amazon.co.uk>

Unlike Linux which creates a full identity mapping, Xen only maps those
segments which are explicitly requested. Therefore, xen_kexec_load()
silently adds in a segment from zero to 1MiB to ensure that VGA memory
and other things are accessible.

However, this doesn't work when there are already segments to be loaded
under 1MiB, because the overlap causes Xen to reject the kexec_load.

Be more careful and just infill the ranges which are required instead
of na=C3=AFvely adding a full 0-1MiB segment at the end of the list.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
Of course, if kexec didn't choose to put a whole bunch of stuff
gratuitously below 1MiB =E2=80=94 especially, if it didn't choose to scribb=
le
over the BIOS Data Area in the zero page =E2=80=94 that would be kind of ni=
ce
too. qv.

 kexec/kexec-xen.c | 73 +++++++++++++++++++++++++++++++++++------------
 1 file changed, 54 insertions(+), 19 deletions(-)

diff --git a/kexec/kexec-xen.c b/kexec/kexec-xen.c
index 1887390..c326955 100644
--- a/kexec/kexec-xen.c
+++ b/kexec/kexec-xen.c
@@ -64,15 +64,18 @@ int __xc_interface_close(xc_interface *xch)
 }
 #endif /* CONFIG_LIBXENCTRL_DL */
=20
+#define IDENTMAP_1MiB (1024 * 1024)
+
 int xen_kexec_load(struct kexec_info *info)
 {
-	uint32_t nr_segments =3D info->nr_segments;
+	uint32_t nr_segments =3D info->nr_segments, nr_low_segments =3D 0;
 	struct kexec_segment *segments =3D info->segment;
+	uint64_t low_watermark =3D 0;
 	xc_interface *xch;
 	xc_hypercall_buffer_array_t *array =3D NULL;
 	uint8_t type;
 	uint8_t arch;
-	xen_kexec_segment_t *xen_segs;
+	xen_kexec_segment_t *xen_segs, *seg;
 	int s;
 	int ret =3D -1;
=20
@@ -80,7 +83,28 @@ int xen_kexec_load(struct kexec_info *info)
 	if (!xch)
 		return -1;
=20
-	xen_segs =3D calloc(nr_segments + 1, sizeof(*xen_segs));
+	/*
+	 * Ensure 0 - 1 MiB is mapped and accessible by the image.
+	 * This allows access to the VGA memory and the region
+	 * purgatory copies in the crash case.
+	 *
+	 * First, count the number of additional segments which will
+	 * need to be added in between the ones in segments[].
+	 *
+	 * The segments are already sorted.
+	 */
+	for (s =3D 0; s < nr_segments && (uint64_t)segments[s].mem <=3D IDENTMAP_=
1MiB; s++) {
+		if ((uint64_t)segments[s].mem > low_watermark)
+			nr_low_segments++;
+
+		low_watermark =3D (uint64_t)segments[s].mem + segments[s].memsz;
+	}
+	if (low_watermark < IDENTMAP_1MiB)
+		nr_low_segments++;
+
+	low_watermark =3D 0;
+
+	xen_segs =3D calloc(nr_segments + nr_low_segments, sizeof(*xen_segs));
 	if (!xen_segs)
 		goto out;
=20
@@ -88,32 +112,43 @@ int xen_kexec_load(struct kexec_info *info)
 	if (array =3D=3D NULL)
 		goto out;
=20
+	seg =3D xen_segs;
 	for (s =3D 0; s < nr_segments; s++) {
 		DECLARE_HYPERCALL_BUFFER(void, seg_buf);
=20
+		if (low_watermark < IDENTMAP_1MiB && (uint64_t)segments[s].mem > low_wat=
ermark) {
+			set_xen_guest_handle(seg->buf.h, HYPERCALL_BUFFER_NULL);
+			seg->buf_size =3D 0;
+			seg->dest_maddr =3D low_watermark;
+			low_watermark =3D (uint64_t)segments[s].mem;
+			if (low_watermark > IDENTMAP_1MiB)
+				low_watermark =3D IDENTMAP_1MiB;
+			seg->dest_size =3D low_watermark - seg->dest_maddr;
+			seg++;
+		}
+
 		seg_buf =3D xc_hypercall_buffer_array_alloc(xch, array, s,
 							  seg_buf, segments[s].bufsz);
 		if (seg_buf =3D=3D NULL)
 			goto out;
 		memcpy(seg_buf, segments[s].buf, segments[s].bufsz);
=20
-		set_xen_guest_handle(xen_segs[s].buf.h, seg_buf);
-		xen_segs[s].buf_size =3D segments[s].bufsz;
-		xen_segs[s].dest_maddr =3D (uint64_t)segments[s].mem;
-		xen_segs[s].dest_size =3D segments[s].memsz;
+		set_xen_guest_handle(seg->buf.h, seg_buf);
+		seg->buf_size =3D segments[s].bufsz;
+		seg->dest_maddr =3D (uint64_t)segments[s].mem;
+		seg->dest_size =3D segments[s].memsz;
+		seg++;
+
+		low_watermark =3D (uint64_t)segments[s].mem + segments[s].memsz;
 	}
=20
-	/*
-	 * Ensure 0 - 1 MiB is mapped and accessible by the image.
-	 *
-	 * This allows access to the VGA memory and the region
-	 * purgatory copies in the crash case.
-	 */
-	set_xen_guest_handle(xen_segs[s].buf.h, HYPERCALL_BUFFER_NULL);
-	xen_segs[s].buf_size =3D 0;
-	xen_segs[s].dest_maddr =3D 0;
-	xen_segs[s].dest_size =3D 1 * 1024 * 1024;
-	nr_segments++;
+	if ((uint64_t)low_watermark < IDENTMAP_1MiB) {
+		set_xen_guest_handle(seg->buf.h, HYPERCALL_BUFFER_NULL);
+		seg->buf_size =3D 0;
+		seg->dest_maddr =3D low_watermark;
+		seg->dest_size =3D IDENTMAP_1MiB - low_watermark;
+		seg++;
+	}
=20
 	type =3D (info->kexec_flags & KEXEC_ON_CRASH) ? KEXEC_TYPE_CRASH
 		: KEXEC_TYPE_DEFAULT;
@@ -125,7 +160,7 @@ int xen_kexec_load(struct kexec_info *info)
 #endif
=20
 	ret =3D xc_kexec_load(xch, type, arch, (uint64_t)info->entry,
-			    nr_segments, xen_segs);
+			    nr_segments + nr_low_segments, xen_segs);
=20
 out:
 	xc_hypercall_buffer_array_destroy(xch, array);


--=-zoREpeGRbNqEarK/1XXl
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
NDI4MTA1MjEyWjAvBgkqhkiG9w0BCQQxIgQgjh3X9sSOPGvvJlsXVtHjvtZXrPDfgUbu9y/OYalw
8Eowgb4GCSsGAQQBgjcQBDGBsDCBrTCBlzELMAkGA1UEBhMCR0IxGzAZBgNVBAgTEkdyZWF0ZXIg
TWFuY2hlc3RlcjEQMA4GA1UEBxMHU2FsZm9yZDEaMBgGA1UEChMRQ09NT0RPIENBIExpbWl0ZWQx
PTA7BgNVBAMTNENPTU9ETyBSU0EgQ2xpZW50IEF1dGhlbnRpY2F0aW9uIGFuZCBTZWN1cmUgRW1h
aWwgQ0ECEQDiu0lIeSrsCenEpRjxmVhmMIHABgsqhkiG9w0BCRACCzGBsKCBrTCBlzELMAkGA1UE
BhMCR0IxGzAZBgNVBAgTEkdyZWF0ZXIgTWFuY2hlc3RlcjEQMA4GA1UEBxMHU2FsZm9yZDEaMBgG
A1UEChMRQ09NT0RPIENBIExpbWl0ZWQxPTA7BgNVBAMTNENPTU9ETyBSU0EgQ2xpZW50IEF1dGhl
bnRpY2F0aW9uIGFuZCBTZWN1cmUgRW1haWwgQ0ECEQDiu0lIeSrsCenEpRjxmVhmMA0GCSqGSIb3
DQEBAQUABIIBACy0tumkFysyTZuzMB94285hy2VBeJTueCUk5/5TYHCzTxbCJvLP+PLHfvMKnBKO
ANFhOAVE0qLXfaSFALeymYRmkGRp30YV0lnq2bo0If9WutursofrLxGT3CG3EXz2YkRk2O8Nhu1M
JcQTbxsoJGuxGetbs0g2jJrvNnrT/4ul5DoYB+vRrmyeHDlN0KZnz7ojRbzTxmuLoADUgCK7a7kl
njL6n3Wrs+CTv2d3xUPJo4O/HglExQNBeJ/arDhePFCLh+28FJT6r+SGaFjmC3NyCY46W1U9+SSI
u4p874UEEmVk/gqPGHyX7ugVwLvBYxN6bsem8ZCrGiDh0+yEfO4AAAAAAAA=


--=-zoREpeGRbNqEarK/1XXl--



--===============6491993105850171727==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

--===============6491993105850171727==--


