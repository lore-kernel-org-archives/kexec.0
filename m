Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC0DDD3E773
	for <kexec@archiver.kernel.org>; Tue,  5 Nov 2024 21:30:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	MIME-Version:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:
	Reply-To:Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date
	:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=VgWTdu59GE2rFrl8ZZfWbA+267oJzWpzpLUkYTGpYDA=; b=MtyexeA3h/iY3ovc8abB55qv4r
	GTja7hL1ZFiigz6j3GYaneBQTdx1E24saDBo0XCDlzcjNLZUOFa0cVJYnGtXiGQn5l2cA3QTeSUJ1
	xRK/RoV75rv9qLCRzVAhNGdk3SRWNua/Eouov3udYyDUV8/+M/QEbLLrIwfkKDKH9iY4WfRDpITiE
	u0jBAJKSBXv2YenXuaAu/nDGgNNx8NGT+MYLZCwIjiUhQZOkIeV7gAwF2r8UHE16TdZnM3RSvGrh3
	sTv/2TuslbftLqLSFYNt8uRyUR07XrRXtrjg5MHMwyC8iWG9dRYMvDWEdjnUjTYskwv5FFj1+wzwC
	bGY4kZJg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t8R8P-00000000rrG-1ATr;
	Tue, 05 Nov 2024 21:30:45 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t8R7h-00000000rj3-3C1T
	for kexec@bombadil.infradead.org;
	Tue, 05 Nov 2024 21:30:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=MIME-Version:Content-Type:References:
	In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=IXfAZklQgf+n4ouo/wCEuL/sqk+Bc4lWLScP7Pawbpw=; b=Y5zYjPv5Cy+9FEvP7+wZw805zr
	oHfyV+EnhNJulwEKm+dmHiT8H3tqBkCN712FiF/FX9y66t8batg3/t1zmWornaegBGUwnZK1ir4uK
	aBppwVQIwdhuIVjd0DAfazMIT42K+jXnQ15SmrC7utVVa4t3jwfXt54Q/yQ0s3XJx4eocznwYEWia
	nOSF6TEzNhIndCBvfJP89gITLnziATzoXXLtShrLRamPNz2ZcuYezR7lcw3rDCtN5JlD9LgDg2L4u
	CbEsrFt0cN0EACkf7ZStSP4dcqrq4Clr9p9+KS/PoSARWx983eIq3NhXMWdQEX35YWktvMJHtXazu
	6kNwVgAQ==;
Received: from [205.251.233.52] (helo=u3832b3a9db3152.ant.amazon.com)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1t8R7d-00000003fVc-3gpE;
	Tue, 05 Nov 2024 21:29:59 +0000
Message-ID: <07117fe234cb1396a59bdb815ada26a90e02b394.camel@infradead.org>
Subject: Re:  [RFC PATCH 6/7] x86/kexec: Debugging support: Dump registers
 on exception
From: David Woodhouse <dwmw2@infradead.org>
To: "H. Peter Anvin" <hpa@zytor.com>, "peterz@infradead.org"
 <peterz@infradead.org>, "kexec@lists.infradead.org"
 <kexec@lists.infradead.org>,  "jpoimboe@kernel.org" <jpoimboe@kernel.org>
Cc: "horms@kernel.org" <horms@kernel.org>, "x86@kernel.org"
 <x86@kernel.org>,  "bp@alien8.de" <bp@alien8.de>, "mingo@redhat.com"
 <mingo@redhat.com>, "tglx@linutronix.de" <tglx@linutronix.de>,
 "kai.huang@intel.com" <kai.huang@intel.com>, 
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
 "nik.borisov@suse.com" <nik.borisov@suse.com>, 
 "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>
Date: Tue, 05 Nov 2024 13:29:54 -0800
In-Reply-To: <66DC35BB-A9E5-45E4-AAAD-051C22943F51@zytor.com>
References: <20241103054019.3795299-1-dwmw2@infradead.org>
	 <20241103054019.3795299-7-dwmw2@infradead.org>
	 <230aacb0ca0d57581f9350f96390933646f203e4.camel@amazon.co.uk>
	 <66DC35BB-A9E5-45E4-AAAD-051C22943F51@zytor.com>
User-Agent: Evolution 3.44.4-0ubuntu2 
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
Content-Type: multipart/mixed; boundary="===============4479034145832609456=="
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org


--===============4479034145832609456==
Content-Type: multipart/signed; micalg="sha-256"; protocol="application/pkcs7-signature";
	boundary="=-olQpAiz5VaKuXeudmmkp"


--=-olQpAiz5VaKuXeudmmkp
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2024-11-05 at 12:50 -0800, H. Peter Anvin wrote:
> On November 5, 2024 12:38:10 PM PST, "Woodhouse, David" <dwmw@amazon.co.u=
k> wrote:
> > On Sun, 2024-11-03 at 05:35 +0000, David Woodhouse wrote:
> > >=20
> > > +
> > > +/* Print the byte in %bl, clobber %rax */
> > > +SYM_CODE_START_LOCAL_NOALIGN(pr_byte)
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 movb=C2=A0=C2=A0=C2=A0 %bl, %al
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 nop
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 andb=C2=A0=C2=A0=C2=A0 $0x0f, %=
al
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 addb=C2=A0=C2=A0=C2=A0 $0x30, %=
al
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cmpb=C2=A0=C2=A0=C2=A0 $0x3a, %=
al
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 jb=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 1f
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 addb=C2=A0=C2=A0=C2=A0 $('a' - =
'0' - 10), %al
> > > +1:=C2=A0=C2=A0=C2=A0=C2=A0 pr_char
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ANNOTATE_UNRET_SAFE
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret
> > > +SYM_CODE_END(pr_byte)
> > > +
> >=20
> > Obviously that function name (and comment) are wrong; fixed in my tree.
> > at
> > https://git.infradead.org/users/dwmw2/linux.git/shortlog/refs/heads/kex=
ec-debug
> >=20
> > This function (and also pr_qword) are also what objtool is complaining
> > about:
> >=20
> > vmlinux.o: warning: objtool: relocate_range+0x2f6: unreachable instruct=
ion
> > vmlinux.o: warning: objtool: relocate_range+0x305: unreachable instruct=
ion
> >=20
> > I don't quite see why, because pr_qword() quite blatantly calls
> > pr_nyblle(), as it's now named. And exc_handler() repeatedly calls
> > pr_qword().
> >=20
> > But most of the objtool annotations I've added here were just to make
> > it shut up and build, without much though. Peter, Josh, any chance you
> > can help me fix it up please?
> >=20
> > It would also be really useful if objtool would let me have data inside
> > a "code" segment, without complaining that it can't decode it as
> > instructions =E2=80=94 and without also failing to decode the first ins=
truction
> > of the *subsequent* function. I've put the GDT at the end to work
> > around that, but it's a bit nasty.
>=20
> code in the data *section* or *segment*? Either is nasty, though. That's =
what .rodata is for.

This is the relocate_kernel() function in
arch/x86/kernel/relocate_kernel_64.S

It's copied into a separate page, called (in its original location) as
a simple function from the kernel, changes %cr3 to set of identity-
mapped page tables and jumps to its *identity-mapped* address, then
copies all the right pages for kexec and jumps into the new kernel.

So it's all in a single page, and currently it plays nasty tricks to
store data after the code. Perhaps it *should* have its own code and
data sections and a linker script to keep them together...

--=-olQpAiz5VaKuXeudmmkp
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
DQEHATAcBgkqhkiG9w0BCQUxDxcNMjQxMTA1MjEyOTU0WjAvBgkqhkiG9w0BCQQxIgQgNjVL2GcH
u2vjpMWQV1ZSV6W7lqSsUcNCyHT8RHqdL8owgb0GCSsGAQQBgjcQBDGBrzCBrDCBljELMAkGA1UE
BhMCR0IxGzAZBgNVBAgTEkdyZWF0ZXIgTWFuY2hlc3RlcjEQMA4GA1UEBxMHU2FsZm9yZDEYMBYG
A1UEChMPU2VjdGlnbyBMaW1pdGVkMT4wPAYDVQQDEzVTZWN0aWdvIFJTQSBDbGllbnQgQXV0aGVu
dGljYXRpb24gYW5kIFNlY3VyZSBFbWFpbCBDQQIRAMa+GZZnQMQDHShREvo7qX4wgb8GCyqGSIb3
DQEJEAILMYGvoIGsMIGWMQswCQYDVQQGEwJHQjEbMBkGA1UECBMSR3JlYXRlciBNYW5jaGVzdGVy
MRAwDgYDVQQHEwdTYWxmb3JkMRgwFgYDVQQKEw9TZWN0aWdvIExpbWl0ZWQxPjA8BgNVBAMTNVNl
Y3RpZ28gUlNBIENsaWVudCBBdXRoZW50aWNhdGlvbiBhbmQgU2VjdXJlIEVtYWlsIENBAhEAxr4Z
lmdAxAMdKFES+jupfjANBgkqhkiG9w0BAQEFAASCAgCJmJIb6IaPMVy1daGyWVNqQEskxm05y7L2
eBvCWo6A5uKH5utSVP4sLU70yFZrjtfENHY5vTPDQudezx4ztMhMWZMTbKjnK7KXNsZYYucyuAlO
d30uL/ArWAFD/4ZcAVle6kq2uIjZfM5GpFIFH76xlqG9MAViUc4YdBK8cqgH6AoLvEC/S7Hsg6cp
F5zz8vfO/zwHmlVdnTsnyDYR6ZMIQYoHe3o9i4kg6/RWbwCO1hje1adWjgY8dacIJ4oygTzYNAf/
c8m07dw+LA3O3JDLnmNmQNI2wOJ0Wrk/ZUwsqjMtCCZu9r4AqCMhNzm9N/lVT+h1FrdCxxawCk4q
HeOTbFRCxe6i35IinmG/QPuHpnZpKJ8+S0Elq33+/VPmmTXXBsqs8B09kCzI36q2eNTiBl6Rj4c/
sMLYij+u8HwR9VXGhS0ItjtNfhuqNhMLddyr5AQqCV3BqXhzyP3VK1eySrAy4TXOkIHTxHWsBz1q
T16eLqs3hZKaD5tkW3qTFjtRi28Xltu7bZ0KTLFMh4Zx4BUNi6AUR81tMgrDnvjVttMhmuCIzNwO
zwEEoGVVPE/HvdlqEAL7i/jLWH05S4774cj2TDmrc9k457f4TssUWegQ44fDI22IwHQWqnxrz5l1
fPQ6FtkPUYQD6LcjxEyX595ejG2pU5/wvhLgANm9FQAAAAAAAA==


--=-olQpAiz5VaKuXeudmmkp--


--===============4479034145832609456==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

--===============4479034145832609456==--

