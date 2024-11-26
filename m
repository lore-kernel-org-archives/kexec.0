Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAEE3D3B985
	for <kexec@archiver.kernel.org>; Tue, 26 Nov 2024 11:42:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-Type:
	References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=yjeFVKERWJQzwdppjkeqNBjddql6+Bu2astJ26YJ0IM=; b=StjBeedbZi7LKWtRdNtC2KYr4a
	wAdrmc2T4hJA6e8GwlrB3Gp03kPYqm8JlwjX0TX5/jtHJmHTM+p2xvsIRTnsTaTnr4kr4T3LyOqaI
	3nDQUY2QrU4E6s6YJJdeg9+JDWNsXz6CZLwhDGdOZGNJr3UOrtlwPC0vUZCp0A6R/cp+v+wrAn/4Q
	9rsAxSAhtYzmYChsj/w0kx8dcgBjTAoYWJFsM+aquDtG8jUwh4wzsI4QWYSNboRqETNRjUxCmiJWL
	PZXPEbN/Fd05ouAQ0waiTI1AytyfHJo2YmMsOLxOdczT/9Dvmg1kk5lmZ0qCC0QXQwJlwxirjZ1uz
	u7KvMlnw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tFtxN-0000000ARIC-1TTH;
	Tue, 26 Nov 2024 11:42:13 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tFtxL-0000000ARHw-1dsY
	for kexec@bombadil.infradead.org;
	Tue, 26 Nov 2024 11:42:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=MIME-Version:Content-Type:References:
	In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=yjeFVKERWJQzwdppjkeqNBjddql6+Bu2astJ26YJ0IM=; b=CodgF47nWvRXPDhUK+qLeXzib2
	xRlL+3zN75x4x3CUtwVNFWGwN9QHsrggAEe5nZvK2nsWomhooiu9vZP8eN+yR6zjDQajQE1oZRKBN
	btzggfWj6MlH3np2/N4037xn0Z3kQvRPlRy9P8+popOiWBTybLeMLnYsF9yUEeLsRAP8CVeO4wnGl
	Z0RjsTn6rcGRdzBWggioocWa6ndGxKeSBurj2smmiNR6mTf7GRqgeVhc1FFaGpmJ8lsnD68/CZ4ay
	lRcOzpueyn+0bZrLdcb8Q/iGQ7T5UkAHX1VUcnVf4tc+APtGNtTxqCH8HhQVZMXlx5RiPFvEbhOhP
	7J7nP3qA==;
Received: from [54.240.197.232] (helo=edge-m3-r2-119.e-iad51.amazon.com)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tFtxF-0000000DU7E-29QY;
	Tue, 26 Nov 2024 11:42:08 +0000
Message-ID: <0c8fe87b34252966ecf558271b09c4b855700691.camel@infradead.org>
Subject: Re: [RFC PATCH] x86/mm: Disable PTI for kernel_ident_mapping_init()
From: David Woodhouse <dwmw2@infradead.org>
To: Dave Hansen <dave.hansen@intel.com>, kexec@lists.infradead.org, 
 =?ISO-8859-1?Q?Sch=F6nherr=2C?= "Jan H."
	 <jschoenh@amazon.de>, Rik van Riel <riel@surriel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, "Kirill A. Shutemov"
 <kirill.shutemov@linux.intel.com>, Kai Huang <kai.huang@intel.com>, Nikolay
 Borisov <nik.borisov@suse.com>,  linux-kernel@vger.kernel.org, Simon Horman
 <horms@kernel.org>, Dave Young <dyoung@redhat.com>, Peter Zijlstra
 <peterz@infradead.org>, jpoimboe@kernel.org,  bsz@amazon.de
Date: Tue, 26 Nov 2024 11:42:04 +0000
In-Reply-To: <5633d50d-0d61-4d18-b43f-11311b5ec920@intel.com>
References: <20241125100815.2512-1-dwmw2@infradead.org>
	 <20241125100815.2512-2-dwmw2@infradead.org>
	 <8b7cd35ab5fec39b80eda8d5907b641af14c3272.camel@infradead.org>
	 <7f75150e9d5d358c8fdc38b591f99a252071fba0.camel@infradead.org>
	 <7e7cb9b21f17b345d8539962093d0c030cca3e34.camel@infradead.org>
	 <88a87314-45ad-47f7-a93a-a9a53d7e8745@intel.com>
	 <5d385e4c06ebd218cfdc20ef4f208ee4abcfa252.camel@infradead.org>
	 <5633d50d-0d61-4d18-b43f-11311b5ec920@intel.com>
Content-Type: multipart/signed; micalg="sha-256"; protocol="application/pkcs7-signature";
	boundary="=-+xIOdCyKVRl+in78pFHA"
User-Agent: Evolution 3.52.3-0ubuntu1 
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org


--=-+xIOdCyKVRl+in78pFHA
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2024-11-25 at 11:13 -0800, Dave Hansen wrote:
> On 11/25/24 10:53, David Woodhouse wrote:
> > > I think we have a lot of software-available space in the page table
> > > pointer entries. What would folks think if we set a special bit in th=
ose
> > > p4d entries that said:
> > >=20
> > > 	"I don't need to be propagated to
> > > 	the user portion of the page tables."
> > >=20
> > > It would obviously get set in this code that you're trying to fix. It
> > > might _also_ be able to be set in in "_USR", like here:
> > >=20
> > > #define _KERNPG_TABLE_NOENC=C2=A0 (__PP|__RW|=C2=A0=C2=A0 0|___A|=C2=
=A0=C2=A0 0|___D|=C2=A0=C2=A0 0|=C2=A0=C2=A0 0)
> > > #define _PAGE_TABLE_NOENC=C2=A0=C2=A0=C2=A0 (__PP|__RW|_USR|___A|=C2=
=A0=C2=A0 0|___D|=C2=A0=C2=A0 0|=C2=A0=C2=A0 0)
> > >=20
> > > like:
> > >=20
> > > #define _USR _PAGE_USER|_PAGE_SW_WHATEVER
> > In fact, do we even need a separate bit? Any PTE without the _PAGE_USER
> > bit set clearly doesn't need to be mirrored into the user page
> > tables...?
>=20
> I can't think of any exceptions where this would break off the top of my
> head. It seems too simple to work. ;)

On IRC we discussed the fact that it's slightly non-trivial to use that
as the trigger for pgd_clear().

I threw this version together and it didn't immediately explode...

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>

diff --git a/arch/x86/include/asm/pgtable_types.h b/arch/x86/include/asm/pg=
table_types.h
index 6f82e75b6149..4b804531b03c 100644
--- a/arch/x86/include/asm/pgtable_types.h
+++ b/arch/x86/include/asm/pgtable_types.h
@@ -36,10 +36,12 @@
 #define _PAGE_BIT_DEVMAP	_PAGE_BIT_SOFTW4
=20
 #ifdef CONFIG_X86_64
-#define _PAGE_BIT_SAVED_DIRTY	_PAGE_BIT_SOFTW5 /* Saved Dirty bit */
+#define _PAGE_BIT_SAVED_DIRTY	_PAGE_BIT_SOFTW5 /* Saved Dirty bit (leaf) *=
/
+#define _PAGE_BIT_NOPTISHADOW	_PAGE_BIT_SOFTW5 /* No PTI shadow (root PGD)=
 */
 #else
 /* Shared with _PAGE_BIT_UFFD_WP which is not supported on 32 bit */
-#define _PAGE_BIT_SAVED_DIRTY	_PAGE_BIT_SOFTW2 /* Saved Dirty bit */
+#define _PAGE_BIT_SAVED_DIRTY	_PAGE_BIT_SOFTW2 /* Saved Dirty bit (leaf) *=
/
+#define _PAGE_BIT_NOPTISHADOW	_PAGE_BIT_SOFTW2 /* No PTI shadow (root PGD)=
 */
 #endif
=20
 /* If _PAGE_BIT_PRESENT is clear, we use these: */
@@ -139,6 +141,8 @@
=20
 #define _PAGE_PROTNONE	(_AT(pteval_t, 1) << _PAGE_BIT_PROTNONE)
=20
+#define _PAGE_NOPTISHADOW (_AT(pteval_t, 1) << _PAGE_BIT_NOPTISHADOW)
+
 /*
  * Set of bits not changed in pte_modify.  The pte's
  * protection key is treated like _PAGE_RW, for
diff --git a/arch/x86/mm/ident_map.c b/arch/x86/mm/ident_map.c
index 437e96fb4977..5ab7bd2f1983 100644
--- a/arch/x86/mm/ident_map.c
+++ b/arch/x86/mm/ident_map.c
@@ -174,7 +174,7 @@ static int ident_p4d_init(struct x86_mapping_info *info=
, p4d_t *p4d_page,
 		if (result)
 			return result;
=20
-		set_p4d(p4d, __p4d(__pa(pud) | info->kernpg_flag));
+		set_p4d(p4d, __p4d(__pa(pud) | info->kernpg_flag | _PAGE_NOPTISHADOW));
 	}
=20
 	return 0;
@@ -218,14 +218,14 @@ int kernel_ident_mapping_init(struct x86_mapping_info=
 *info, pgd_t *pgd_page,
 		if (result)
 			return result;
 		if (pgtable_l5_enabled()) {
-			set_pgd(pgd, __pgd(__pa(p4d) | info->kernpg_flag));
+			set_pgd(pgd, __pgd(__pa(p4d) | info->kernpg_flag | _PAGE_NOPTISHADOW));
 		} else {
 			/*
 			 * With p4d folded, pgd is equal to p4d.
 			 * The pgd entry has to point to the pud page table in this case.
 			 */
 			pud_t *pud =3D pud_offset(p4d, 0);
-			set_pgd(pgd, __pgd(__pa(pud) | info->kernpg_flag));
+			set_pgd(pgd, __pgd(__pa(pud) | info->kernpg_flag | _PAGE_NOPTISHADOW));
 		}
 	}
=20
diff --git a/arch/x86/mm/pti.c b/arch/x86/mm/pti.c
index 851ec8f1363a..5f0d579932c6 100644
--- a/arch/x86/mm/pti.c
+++ b/arch/x86/mm/pti.c
@@ -132,7 +132,7 @@ pgd_t __pti_set_user_pgtbl(pgd_t *pgdp, pgd_t pgd)
 	 * Top-level entries added to init_mm's usermode pgd after boot
 	 * will not be automatically propagated to other mms.
 	 */
-	if (!pgdp_maps_userspace(pgdp))
+	if (!pgdp_maps_userspace(pgdp) || (pgd.pgd & _PAGE_NOPTISHADOW))
 		return pgd;
=20
 	/*


--=-+xIOdCyKVRl+in78pFHA
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Disposition: attachment; filename="smime.p7s"
Content-Transfer-Encoding: base64

MIAGCSqGSIb3DQEHAqCAMIACAQExDzANBglghkgBZQMEAgEFADCABgkqhkiG9w0BBwEAAKCCEkQw
ggYQMIID+KADAgECAhBNlCwQ1DvglAnFgS06KwZPMA0GCSqGSIb3DQEBDAUAMIGIMQswCQYDVQQG
EwJVUzETMBEGA1UECBMKTmV3IEplcnNleTEUMBIGA1UEBxMLSmVyc2V5IENpdHkxHjAcBgNVBAoT
FVRoZSBVU0VSVFJVU1QgTmV0d29yazEuMCwGA1UEAxMlVVNFUlRydXN0IFJTQSBDZXJ0aWZpY2F0
aW9uIEF1dGhvcml0eTAeFw0xODExMDIwMDAwMDBaFw0zMDEyMzEyMzU5NTlaMIGWMQswCQYDVQQG
EwJHQjEbMBkGA1UECBMSR3JlYXRlciBNYW5jaGVzdGVyMRAwDgYDVQQHEwdTYWxmb3JkMRgwFgYD
VQQKEw9TZWN0aWdvIExpbWl0ZWQxPjA8BgNVBAMTNVNlY3RpZ28gUlNBIENsaWVudCBBdXRoZW50
aWNhdGlvbiBhbmQgU2VjdXJlIEVtYWlsIENBMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKC
AQEAyjztlApB/975Rrno1jvm2pK/KxBOqhq8gr2+JhwpKirSzZxQgT9tlC7zl6hn1fXjSo5MqXUf
ItMltrMaXqcESJuK8dtK56NCSrq4iDKaKq9NxOXFmqXX2zN8HHGjQ2b2Xv0v1L5Nk1MQPKA19xeW
QcpGEGFUUd0kN+oHox+L9aV1rjfNiCj3bJk6kJaOPabPi2503nn/ITX5e8WfPnGw4VuZ79Khj1YB
rf24k5Ee1sLTHsLtpiK9OjG4iQRBdq6Z/TlVx/hGAez5h36bBJMxqdHLpdwIUkTqT8se3ed0PewD
ch/8kHPo5fZl5u1B0ecpq/sDN/5sCG52Ds+QU5O5EwIDAQABo4IBZDCCAWAwHwYDVR0jBBgwFoAU
U3m/WqorSs9UgOHYm8Cd8rIDZsswHQYDVR0OBBYEFAnA8vwL2pTbX/4r36iZQs/J4K0AMA4GA1Ud
DwEB/wQEAwIBhjASBgNVHRMBAf8ECDAGAQH/AgEAMB0GA1UdJQQWMBQGCCsGAQUFBwMCBggrBgEF
BQcDBDARBgNVHSAECjAIMAYGBFUdIAAwUAYDVR0fBEkwRzBFoEOgQYY/aHR0cDovL2NybC51c2Vy
dHJ1c3QuY29tL1VTRVJUcnVzdFJTQUNlcnRpZmljYXRpb25BdXRob3JpdHkuY3JsMHYGCCsGAQUF
BwEBBGowaDA/BggrBgEFBQcwAoYzaHR0cDovL2NydC51c2VydHJ1c3QuY29tL1VTRVJUcnVzdFJT
QUFkZFRydXN0Q0EuY3J0MCUGCCsGAQUFBzABhhlodHRwOi8vb2NzcC51c2VydHJ1c3QuY29tMA0G
CSqGSIb3DQEBDAUAA4ICAQBBRHUAqznCFfXejpVtMnFojADdF9d6HBA4kMjjsb0XMZHztuOCtKF+
xswhh2GqkW5JQrM8zVlU+A2VP72Ky2nlRA1GwmIPgou74TZ/XTarHG8zdMSgaDrkVYzz1g3nIVO9
IHk96VwsacIvBF8JfqIs+8aWH2PfSUrNxP6Ys7U0sZYx4rXD6+cqFq/ZW5BUfClN/rhk2ddQXyn7
kkmka2RQb9d90nmNHdgKrwfQ49mQ2hWQNDkJJIXwKjYA6VUR/fZUFeCUisdDe/0ABLTI+jheXUV1
eoYV7lNwNBKpeHdNuO6Aacb533JlfeUHxvBz9OfYWUiXu09sMAviM11Q0DuMZ5760CdO2VnpsXP4
KxaYIhvqPqUMWqRdWyn7crItNkZeroXaecG03i3mM7dkiPaCkgocBg0EBYsbZDZ8bsG3a08LwEsL
1Ygz3SBsyECa0waq4hOf/Z85F2w2ZpXfP+w8q4ifwO90SGZZV+HR/Jh6rEaVPDRF/CEGVqR1hiuQ
OZ1YL5ezMTX0ZSLwrymUE0pwi/KDaiYB15uswgeIAcA6JzPFf9pLkAFFWs1QNyN++niFhsM47qod
x/PL+5jR87myx5uYdBEQkkDc+lKB1Wct6ucXqm2EmsaQ0M95QjTmy+rDWjkDYdw3Ms6mSWE3Bn7i
5ZgtwCLXgAIe5W8mybM2JzCCBhQwggT8oAMCAQICEQDGvhmWZ0DEAx0oURL6O6l+MA0GCSqGSIb3
DQEBCwUAMIGWMQswCQYDVQQGEwJHQjEbMBkGA1UECBMSR3JlYXRlciBNYW5jaGVzdGVyMRAwDgYD
VQQHEwdTYWxmb3JkMRgwFgYDVQQKEw9TZWN0aWdvIExpbWl0ZWQxPjA8BgNVBAMTNVNlY3RpZ28g
UlNBIENsaWVudCBBdXRoZW50aWNhdGlvbiBhbmQgU2VjdXJlIEVtYWlsIENBMB4XDTIyMDEwNzAw
MDAwMFoXDTI1MDEwNjIzNTk1OVowJDEiMCAGCSqGSIb3DQEJARYTZHdtdzJAaW5mcmFkZWFkLm9y
ZzCCAiIwDQYJKoZIhvcNAQEBBQADggIPADCCAgoCggIBALQ3GpC2bomUqk+91wLYBzDMcCj5C9m6
oZaHwvmIdXftOgTbCJXADo6G9T7BBAebw2JV38EINgKpy/ZHh7htyAkWYVoFsFPrwHounto8xTsy
SSePMiPlmIdQ10BcVSXMUJ3Juu16GlWOnAMJY2oYfEzmE7uT9YgcBqKCo65pTFmOnR/VVbjJk4K2
xE34GC2nAdUQkPFuyaFisicc6HRMOYXPuF0DuwITEKnjxgNjP+qDrh0db7PAjO1D4d5ftfrsf+kd
RR4gKVGSk8Tz2WwvtLAroJM4nXjNPIBJNT4w/FWWc/5qPHJy2U+eITZ5LLE5s45mX2oPFknWqxBo
bQZ8a9dsZ3dSPZBvE9ZrmtFLrVrN4eo1jsXgAp1+p7bkfqd3BgBEmfsYWlBXO8rVXfvPgLs32VdV
NZxb/CDWPqBsiYv0Hv3HPsz07j5b+/cVoWqyHDKzkaVbxfq/7auNVRmPB3v5SWEsH8xi4Bez2V9U
KxfYCnqsjp8RaC2/khxKt0A552Eaxnz/4ly/2C7wkwTQnBmdlFYhAflWKQ03Ufiu8t3iBE3VJbc2
5oMrglj7TRZrmKq3CkbFnX0fyulB+kHimrt6PIWn7kgyl9aelIl6vtbhMA+l0nfrsORMa4kobqQ5
C5rveVgmcIad67EDa+UqEKy/GltUwlSh6xy+TrK1tzDvAgMBAAGjggHMMIIByDAfBgNVHSMEGDAW
gBQJwPL8C9qU21/+K9+omULPyeCtADAdBgNVHQ4EFgQUzMeDMcimo0oz8o1R1Nver3ZVpSkwDgYD
VR0PAQH/BAQDAgWgMAwGA1UdEwEB/wQCMAAwHQYDVR0lBBYwFAYIKwYBBQUHAwQGCCsGAQUFBwMC
MEAGA1UdIAQ5MDcwNQYMKwYBBAGyMQECAQEBMCUwIwYIKwYBBQUHAgEWF2h0dHBzOi8vc2VjdGln
by5jb20vQ1BTMFoGA1UdHwRTMFEwT6BNoEuGSWh0dHA6Ly9jcmwuc2VjdGlnby5jb20vU2VjdGln
b1JTQUNsaWVudEF1dGhlbnRpY2F0aW9uYW5kU2VjdXJlRW1haWxDQS5jcmwwgYoGCCsGAQUFBwEB
BH4wfDBVBggrBgEFBQcwAoZJaHR0cDovL2NydC5zZWN0aWdvLmNvbS9TZWN0aWdvUlNBQ2xpZW50
QXV0aGVudGljYXRpb25hbmRTZWN1cmVFbWFpbENBLmNydDAjBggrBgEFBQcwAYYXaHR0cDovL29j
c3Auc2VjdGlnby5jb20wHgYDVR0RBBcwFYETZHdtdzJAaW5mcmFkZWFkLm9yZzANBgkqhkiG9w0B
AQsFAAOCAQEAyW6MUir5dm495teKqAQjDJwuFCi35h4xgnQvQ/fzPXmtR9t54rpmI2TfyvcKgOXp
qa7BGXNFfh1JsqexVkIqZP9uWB2J+uVMD+XZEs/KYNNX2PvIlSPrzIB4Z2wyIGQpaPLlYflrrVFK
v9CjT2zdqvy2maK7HKOQRt3BiJbVG5lRiwbbygldcALEV9ChWFfgSXvrWDZspnU3Gjw/rMHrGnql
Htlyebp3pf3fSS9kzQ1FVtVIDrL6eqhTwJxe+pXSMMqFiN0whpBtXdyDjzBtQTaZJ7zTT/vlehc/
tDuqZwGHm/YJy883Ll+GP3NvOkgaRGWEuYWJJ6hFCkXYjyR9IzCCBhQwggT8oAMCAQICEQDGvhmW
Z0DEAx0oURL6O6l+MA0GCSqGSIb3DQEBCwUAMIGWMQswCQYDVQQGEwJHQjEbMBkGA1UECBMSR3Jl
YXRlciBNYW5jaGVzdGVyMRAwDgYDVQQHEwdTYWxmb3JkMRgwFgYDVQQKEw9TZWN0aWdvIExpbWl0
ZWQxPjA8BgNVBAMTNVNlY3RpZ28gUlNBIENsaWVudCBBdXRoZW50aWNhdGlvbiBhbmQgU2VjdXJl
IEVtYWlsIENBMB4XDTIyMDEwNzAwMDAwMFoXDTI1MDEwNjIzNTk1OVowJDEiMCAGCSqGSIb3DQEJ
ARYTZHdtdzJAaW5mcmFkZWFkLm9yZzCCAiIwDQYJKoZIhvcNAQEBBQADggIPADCCAgoCggIBALQ3
GpC2bomUqk+91wLYBzDMcCj5C9m6oZaHwvmIdXftOgTbCJXADo6G9T7BBAebw2JV38EINgKpy/ZH
h7htyAkWYVoFsFPrwHounto8xTsySSePMiPlmIdQ10BcVSXMUJ3Juu16GlWOnAMJY2oYfEzmE7uT
9YgcBqKCo65pTFmOnR/VVbjJk4K2xE34GC2nAdUQkPFuyaFisicc6HRMOYXPuF0DuwITEKnjxgNj
P+qDrh0db7PAjO1D4d5ftfrsf+kdRR4gKVGSk8Tz2WwvtLAroJM4nXjNPIBJNT4w/FWWc/5qPHJy
2U+eITZ5LLE5s45mX2oPFknWqxBobQZ8a9dsZ3dSPZBvE9ZrmtFLrVrN4eo1jsXgAp1+p7bkfqd3
BgBEmfsYWlBXO8rVXfvPgLs32VdVNZxb/CDWPqBsiYv0Hv3HPsz07j5b+/cVoWqyHDKzkaVbxfq/
7auNVRmPB3v5SWEsH8xi4Bez2V9UKxfYCnqsjp8RaC2/khxKt0A552Eaxnz/4ly/2C7wkwTQnBmd
lFYhAflWKQ03Ufiu8t3iBE3VJbc25oMrglj7TRZrmKq3CkbFnX0fyulB+kHimrt6PIWn7kgyl9ae
lIl6vtbhMA+l0nfrsORMa4kobqQ5C5rveVgmcIad67EDa+UqEKy/GltUwlSh6xy+TrK1tzDvAgMB
AAGjggHMMIIByDAfBgNVHSMEGDAWgBQJwPL8C9qU21/+K9+omULPyeCtADAdBgNVHQ4EFgQUzMeD
Mcimo0oz8o1R1Nver3ZVpSkwDgYDVR0PAQH/BAQDAgWgMAwGA1UdEwEB/wQCMAAwHQYDVR0lBBYw
FAYIKwYBBQUHAwQGCCsGAQUFBwMCMEAGA1UdIAQ5MDcwNQYMKwYBBAGyMQECAQEBMCUwIwYIKwYB
BQUHAgEWF2h0dHBzOi8vc2VjdGlnby5jb20vQ1BTMFoGA1UdHwRTMFEwT6BNoEuGSWh0dHA6Ly9j
cmwuc2VjdGlnby5jb20vU2VjdGlnb1JTQUNsaWVudEF1dGhlbnRpY2F0aW9uYW5kU2VjdXJlRW1h
aWxDQS5jcmwwgYoGCCsGAQUFBwEBBH4wfDBVBggrBgEFBQcwAoZJaHR0cDovL2NydC5zZWN0aWdv
LmNvbS9TZWN0aWdvUlNBQ2xpZW50QXV0aGVudGljYXRpb25hbmRTZWN1cmVFbWFpbENBLmNydDAj
BggrBgEFBQcwAYYXaHR0cDovL29jc3Auc2VjdGlnby5jb20wHgYDVR0RBBcwFYETZHdtdzJAaW5m
cmFkZWFkLm9yZzANBgkqhkiG9w0BAQsFAAOCAQEAyW6MUir5dm495teKqAQjDJwuFCi35h4xgnQv
Q/fzPXmtR9t54rpmI2TfyvcKgOXpqa7BGXNFfh1JsqexVkIqZP9uWB2J+uVMD+XZEs/KYNNX2PvI
lSPrzIB4Z2wyIGQpaPLlYflrrVFKv9CjT2zdqvy2maK7HKOQRt3BiJbVG5lRiwbbygldcALEV9Ch
WFfgSXvrWDZspnU3Gjw/rMHrGnqlHtlyebp3pf3fSS9kzQ1FVtVIDrL6eqhTwJxe+pXSMMqFiN0w
hpBtXdyDjzBtQTaZJ7zTT/vlehc/tDuqZwGHm/YJy883Ll+GP3NvOkgaRGWEuYWJJ6hFCkXYjyR9
IzGCBMcwggTDAgEBMIGsMIGWMQswCQYDVQQGEwJHQjEbMBkGA1UECBMSR3JlYXRlciBNYW5jaGVz
dGVyMRAwDgYDVQQHEwdTYWxmb3JkMRgwFgYDVQQKEw9TZWN0aWdvIExpbWl0ZWQxPjA8BgNVBAMT
NVNlY3RpZ28gUlNBIENsaWVudCBBdXRoZW50aWNhdGlvbiBhbmQgU2VjdXJlIEVtYWlsIENBAhEA
xr4ZlmdAxAMdKFES+jupfjANBglghkgBZQMEAgEFAKCCAeswGAYJKoZIhvcNAQkDMQsGCSqGSIb3
DQEHATAcBgkqhkiG9w0BCQUxDxcNMjQxMTI2MTE0MjA0WjAvBgkqhkiG9w0BCQQxIgQgJQiERej9
F485Em0o+xNwcrH0CtBvYBg4qYf7dEx3MJIwgb0GCSsGAQQBgjcQBDGBrzCBrDCBljELMAkGA1UE
BhMCR0IxGzAZBgNVBAgTEkdyZWF0ZXIgTWFuY2hlc3RlcjEQMA4GA1UEBxMHU2FsZm9yZDEYMBYG
A1UEChMPU2VjdGlnbyBMaW1pdGVkMT4wPAYDVQQDEzVTZWN0aWdvIFJTQSBDbGllbnQgQXV0aGVu
dGljYXRpb24gYW5kIFNlY3VyZSBFbWFpbCBDQQIRAMa+GZZnQMQDHShREvo7qX4wgb8GCyqGSIb3
DQEJEAILMYGvoIGsMIGWMQswCQYDVQQGEwJHQjEbMBkGA1UECBMSR3JlYXRlciBNYW5jaGVzdGVy
MRAwDgYDVQQHEwdTYWxmb3JkMRgwFgYDVQQKEw9TZWN0aWdvIExpbWl0ZWQxPjA8BgNVBAMTNVNl
Y3RpZ28gUlNBIENsaWVudCBBdXRoZW50aWNhdGlvbiBhbmQgU2VjdXJlIEVtYWlsIENBAhEAxr4Z
lmdAxAMdKFES+jupfjANBgkqhkiG9w0BAQEFAASCAgAT4zIO2xmuFPQx0xnquDQDooqTdLtsS1r6
ePWF9Nn1DM0mACGBJjXBojJEAg6f2yPOa3/GX10I70mA5hbPPo01XkghFbOcFG34HOF2Ufwi2QYt
jWQ7XcR9SKxmNlg0Q9etwHBMlARlWjQd7+3ZRczqjWm8sqokW0s8zkElq+L5oeydmEamH5S7HWeo
8hE3yOxI+mfG6MUHhOpAI+Hmj57Y17lHMRxBvTPdW0JWqeGJ98hHn6u3HUO5zc8akYJ3j0szMEoS
rIoThqb2gAQzz8NwhJmdP94Qiys1UpBQ4pMd7ERIjdMPhtxq/cm/jJ6PApzH4S6z+xUZS2fqX5dU
DRSCLTIgQloXcfmRwvJONhOZZ0npEDMQx0I6f9t4Pd+Z7pRN1e3hHocghvVGoy49lZApRRqAivi7
22wkXWD4WEMHLQnb5eSrIlN7HJJUcVbKd3Tu8Zm8UqVHtvqBIWvJyMysg5119n5fqT9FYJRgDgb0
KHgg5fOy19gAOmAIv99QQMyElK+FAVS67k7TgpQv5Zur4Km2JZTPG5F3xa/nF8prmrq7qBGpc4OH
X+6bUxxBJr8HGUSD6hopcTHbF20HzLss3SNdCn5Zt8RqwXeWFra9Dbd8hankQpnlpFxyeIc434Ei
a6AqWsSVgRRuAsAtspHuGVgzccoUmJGLWUvmkIK9ZAAAAAAAAA==


--=-+xIOdCyKVRl+in78pFHA--

