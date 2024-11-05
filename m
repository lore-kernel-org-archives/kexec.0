Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED353D35E40
	for <kexec@archiver.kernel.org>; Tue,  5 Nov 2024 20:43:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:
	References:Message-ID:Date:Subject:CC:To:From:Content-Type:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=E8FSmXArAMJAiFXKMhoUoERSB3EDxEc2xs2rqIwidqE=; b=2CPmJbhTq7sXyGaRannWFSDbgv
	DXFAP5DcdaNW5XlhO04FS8YFa6I2kbUxfdatFrFwEVCGOH0EendhqmiOONpZqsDN15quHa7csq/Hn
	t08P/nK/5/HO51HuB6DusMw+mZmsZV423nHaYdHiQCfnXmtO2f8OdF34TW9pGwfwZMSCTEcLvPbxY
	5Md1L1X9eHeP/6oRMucXb6jK1sIuWPnx/7rmUMelzI6Iqs1edp0IawjEgticL9fEuXZQvaU6yU3JN
	LWOYmDFegK/o7ldkp6e/jBJVzGJWWfWgTJ0Z7qNYvTMoNgfaImKjxTKjvMgwsupancYkS/MUiJPmN
	TB9SNFuw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t8QOg-00000000lMk-3kFU;
	Tue, 05 Nov 2024 20:43:30 +0000
Received: from smtp-fw-52004.amazon.com ([52.119.213.154])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t8QOd-00000000lIr-0eHk
	for kexec@lists.infradead.org;
	Tue, 05 Nov 2024 20:43:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.co.uk; i=@amazon.co.uk; q=dns/txt;
  s=amazon201209; t=1730839407; x=1762375407;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to;
  bh=lsCuYYsGQoOWmWgF469cAILy5vBEwyj4mVlrNudrcIc=;
  b=VvLxjJAsy5tBmRSxpl9YFMazuFwHDGaN4898auYJoRhXLtu9BaIQP+AH
   deEFW2GkvGl6OSZXjcz73Op3Y9yBoBLOHFAPeM4h8+tMFWhJUB9ZYpxhC
   vS6yBPBC9ZAOGOT4P5yGnmecsP9436unJMUMJqE8WRMlb1kCx/6aXpL9g
   s=;
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO 169.254.153.38) ([10.43.8.2])
  by smtp-border-fw-52004.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2024 20:43:14 +0000
Received: from smtp-fw-52005.amazon.com (smtp-fw-52005.amazon.com [52.119.213.156])
 by inbound-smtp.us-east-1.amazonaws.com with SMTP id 5rilcg8vmefof9qfcfibo665npfv3027uudgido1
 for ingestion@secure-attach.perimeter.email.amazon.dev;
 Tue, 05 Nov 2024 20:38:13 +0000 (UTC)
X-Amazon-filename: smime.p7s
X-IronPort-AV: E=Sophos;i="6.11,261,1725321600";
   d="p7s'346?scan'346,208,346";a="693306994"
Content-Type: multipart/mixed; boundary="===============3544687167705924450=="
MIME-Version: 1.0
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52005.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2024 20:38:11 +0000
Received: from EX19MTAUEB002.ant.amazon.com [10.0.29.78:26617]
 by smtpin.naws.us-east-1.prod.farcaster.email.amazon.dev [10.0.26.144:2525] with esmtp (Farcaster)
 id 19bfc9db-90b9-4b6e-9ed5-cc15e46cc431; Tue, 5 Nov 2024 20:38:11 +0000 (UTC)
X-Farcaster-Flow-ID: 19bfc9db-90b9-4b6e-9ed5-cc15e46cc431
Received: from EX19D008UEC003.ant.amazon.com (10.252.135.194) by
 EX19MTAUEB002.ant.amazon.com (10.252.135.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Tue, 5 Nov 2024 20:38:10 +0000
Received: from EX19D008UEC001.ant.amazon.com (10.252.135.232) by
 EX19D008UEC003.ant.amazon.com (10.252.135.194) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Tue, 5 Nov 2024 20:38:10 +0000
Received: from EX19D008UEC001.ant.amazon.com ([fe80::4702:5d1a:c556:797]) by
 EX19D008UEC001.ant.amazon.com ([fe80::4702:5d1a:c556:797%3]) with mapi id
 15.02.1258.034; Tue, 5 Nov 2024 20:38:10 +0000
From: "Woodhouse, David" <dwmw@amazon.co.uk>
To: "peterz@infradead.org" <peterz@infradead.org>, "kexec@lists.infradead.org"
	<kexec@lists.infradead.org>, "jpoimboe@kernel.org" <jpoimboe@kernel.org>
CC: "horms@kernel.org" <horms@kernel.org>, "x86@kernel.org" <x86@kernel.org>,
	"bp@alien8.de" <bp@alien8.de>, "hpa@zytor.com" <hpa@zytor.com>,
	"mingo@redhat.com" <mingo@redhat.com>, "tglx@linutronix.de"
	<tglx@linutronix.de>, "kai.huang@intel.com" <kai.huang@intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
	"nik.borisov@suse.com" <nik.borisov@suse.com>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>
Subject: Re: [RFC PATCH 6/7] x86/kexec: Debugging support: Dump registers on
 exception
Thread-Topic: [RFC PATCH 6/7] x86/kexec: Debugging support: Dump registers on
 exception
Thread-Index: AQHbL8KgoLFjd1CsP0ONoEM+QRcWzQ==
Date: Tue, 5 Nov 2024 20:38:10 +0000
Message-ID: <230aacb0ca0d57581f9350f96390933646f203e4.camel@amazon.co.uk>
References: <20241103054019.3795299-1-dwmw2@infradead.org>
	 <20241103054019.3795299-7-dwmw2@infradead.org>
In-Reply-To: <20241103054019.3795299-7-dwmw2@infradead.org>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-originating-ip: [10.187.170.41]
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241105_124327_538039_301D2770 
X-CRM114-Status: GOOD (  36.30  )
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

--===============3544687167705924450==
Content-Language: en-US
Content-Type: multipart/signed; micalg=sha-256;
	protocol="application/pkcs7-signature"; boundary="=-X+hJcMdLuHPE7bbY3gus"

--=-X+hJcMdLuHPE7bbY3gus
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, 2024-11-03 at 05:35 +0000, David Woodhouse wrote:
>=20
> +
> +/* Print the byte in %bl, clobber %rax */
> +SYM_CODE_START_LOCAL_NOALIGN(pr_byte)
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0movb=C2=A0=C2=A0=C2=A0=C2=A0%b=
l, %al
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0nop
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0andb=C2=A0=C2=A0=C2=A0=C2=A0$0=
x0f, %al
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0addb=C2=A0=C2=A0=C2=A0=C2=A0$0=
x30, %al
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0cmpb=C2=A0=C2=A0=C2=A0=C2=A0$0=
x3a, %al
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0jb=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A01f
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0addb=C2=A0=C2=A0=C2=A0=C2=A0$(=
'a' - '0' - 10), %al
> +1:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0pr_char
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ANNOTATE_UNRET_SAFE
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ret
> +SYM_CODE_END(pr_byte)
> +

Obviously that function name (and comment) are wrong; fixed in my tree.
at
https://git.infradead.org/users/dwmw2/linux.git/shortlog/refs/heads/kexec-d=
ebug

This function (and also pr_qword) are also what objtool is complaining
about:

vmlinux.o: warning: objtool: relocate_range+0x2f6: unreachable instruction
vmlinux.o: warning: objtool: relocate_range+0x305: unreachable instruction

I don't quite see why, because pr_qword() quite blatantly calls
pr_nyblle(), as it's now named. And exc_handler() repeatedly calls
pr_qword().

But most of the objtool annotations I've added here were just to make
it shut up and build, without much though. Peter, Josh, any chance you
can help me fix it up please?

It would also be really useful if objtool would let me have data inside
a "code" segment, without complaining that it can't decode it as
instructions =E2=80=94 and without also failing to decode the first instruc=
tion
of the *subsequent* function. I've put the GDT at the end to work
around that, but it's a bit nasty.

--=-X+hJcMdLuHPE7bbY3gus
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Disposition: attachment; filename="smime.p7s"
Content-Transfer-Encoding: base64

MIAGCSqGSIb3DQEHAqCAMIACAQExDzANBglghkgBZQMEAgEFADCABgkqhkiG9w0BBwEAAKCCEjww
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
5ZgtwCLXgAIe5W8mybM2JzCCBhAwggT4oAMCAQICEQC/QgfpbUT3q2fHshU/ReqfMA0GCSqGSIb3
DQEBCwUAMIGWMQswCQYDVQQGEwJHQjEbMBkGA1UECBMSR3JlYXRlciBNYW5jaGVzdGVyMRAwDgYD
VQQHEwdTYWxmb3JkMRgwFgYDVQQKEw9TZWN0aWdvIExpbWl0ZWQxPjA8BgNVBAMTNVNlY3RpZ28g
UlNBIENsaWVudCBBdXRoZW50aWNhdGlvbiBhbmQgU2VjdXJlIEVtYWlsIENBMB4XDTIyMDEwNzAw
MDAwMFoXDTI1MDEwNjIzNTk1OVowIjEgMB4GCSqGSIb3DQEJARYRZHdtd0BhbWF6b24uY28udWsw
ggIiMA0GCSqGSIb3DQEBAQUAA4ICDwAwggIKAoICAQCZgnzd4h6STv/MQcUPixvDN/dNtp4yVSdc
xz9mB1OcA7HXd4WdPyYagmkcH0WguDYaQnOszkSdElI+2XRFSlGXhY7U9tktvdWuY1zAY1UWES8e
3BUHqSKbIKx4SX6GuctCcPnyagVZ9Hk21YUElx9cdmrqt0bGoydgxAspEx56J9Q5a48WfvFYjLBF
NL1dw+P1eUeAljco30+Xggf5faawKfPArUX0cmU4VIh5DMUyv4d0xxfNN6cK1GMj/HGUg2T9OTHW
nbTdq+OHJwHGi/37mCWx1O3uV0hbZzA1fNklaqlsr1Acg0elPeCFXLb8dSkMgQZHNJVjn+mBvG4d
MG4FS3ntipApytA+a5IaMP3LNAo0EoBd5/xVy0M6TXbiYesYLq9rhnrLgO1qcw7+if0jH9YoEJ6a
Je1m7omfEXh2XpospSLaohmAqaBKlyhXDXbTnUVnIf79zU5ohHZof0cP2amnnvYUVD72iuf9qe7X
4L1Rj589qEWYROKiMil5X7l/smE1dAmxhKxx6YWvWkXH9u7JOcmLGdKST0voaY7j3Wk0lxK3NKsk
q0G3BpqbPz3P8BYtn38BvbkFnwVW7F7Qzus3KZJgP62eN25QHxoFj44x3sppx4I5WlYG4lxdFZsY
smQdj64c7MaJ7cp8RJN+eO32RKrkndEkihzxevl11wIDAQABo4IByjCCAcYwHwYDVR0jBBgwFoAU
CcDy/AvalNtf/ivfqJlCz8ngrQAwHQYDVR0OBBYEFJ418HpIgZaPnwpWdCNSvm4XgH/lMA4GA1Ud
DwEB/wQEAwIFoDAMBgNVHRMBAf8EAjAAMB0GA1UdJQQWMBQGCCsGAQUFBwMEBggrBgEFBQcDAjBA
BgNVHSAEOTA3MDUGDCsGAQQBsjEBAgEBATAlMCMGCCsGAQUFBwIBFhdodHRwczovL3NlY3RpZ28u
Y29tL0NQUzBaBgNVHR8EUzBRME+gTaBLhklodHRwOi8vY3JsLnNlY3RpZ28uY29tL1NlY3RpZ29S
U0FDbGllbnRBdXRoZW50aWNhdGlvbmFuZFNlY3VyZUVtYWlsQ0EuY3JsMIGKBggrBgEFBQcBAQR+
MHwwVQYIKwYBBQUHMAKGSWh0dHA6Ly9jcnQuc2VjdGlnby5jb20vU2VjdGlnb1JTQUNsaWVudEF1
dGhlbnRpY2F0aW9uYW5kU2VjdXJlRW1haWxDQS5jcnQwIwYIKwYBBQUHMAGGF2h0dHA6Ly9vY3Nw
LnNlY3RpZ28uY29tMBwGA1UdEQQVMBOBEWR3bXdAYW1hem9uLmNvLnVrMA0GCSqGSIb3DQEBCwUA
A4IBAQCSez7gtf1wlWJr568crX21nm6QFWRdJ/YxMOReeqYtGs8QZf2zm2vIEFab61MrgJFJcFJL
sRhVHwnH/hvax3ZldDpUhM0ODpA9soUjYsvKJ0boFAHPtI1BL0yrZNCBdsUGxMv0t64Acj2ovxQ+
OxPd5ngHu0MzYIKLDvTSehxkh/qW23X7Ey/fPR0sgnAK4IV7clidmuWBbrqX+WKEyEP2kaEvLsRg
8plzYbVVFJl37rX2waKnGaWYnJ3BrvcMMgDSQCuoxMThWAOr7wxOh0ni0K3rW7CwDIAjUSk+fFmS
2EacUvIv/0xUW1nXzGJ12/Qyi+Mw65m0qE776qfcftg3MIIGEDCCBPigAwIBAgIRAL9CB+ltRPer
Z8eyFT9F6p8wDQYJKoZIhvcNAQELBQAwgZYxCzAJBgNVBAYTAkdCMRswGQYDVQQIExJHcmVhdGVy
IE1hbmNoZXN0ZXIxEDAOBgNVBAcTB1NhbGZvcmQxGDAWBgNVBAoTD1NlY3RpZ28gTGltaXRlZDE+
MDwGA1UEAxM1U2VjdGlnbyBSU0EgQ2xpZW50IEF1dGhlbnRpY2F0aW9uIGFuZCBTZWN1cmUgRW1h
aWwgQ0EwHhcNMjIwMTA3MDAwMDAwWhcNMjUwMTA2MjM1OTU5WjAiMSAwHgYJKoZIhvcNAQkBFhFk
d213QGFtYXpvbi5jby51azCCAiIwDQYJKoZIhvcNAQEBBQADggIPADCCAgoCggIBAJmCfN3iHpJO
/8xBxQ+LG8M39022njJVJ1zHP2YHU5wDsdd3hZ0/JhqCaRwfRaC4NhpCc6zORJ0SUj7ZdEVKUZeF
jtT22S291a5jXMBjVRYRLx7cFQepIpsgrHhJfoa5y0Jw+fJqBVn0eTbVhQSXH1x2auq3RsajJ2DE
CykTHnon1DlrjxZ+8ViMsEU0vV3D4/V5R4CWNyjfT5eCB/l9prAp88CtRfRyZThUiHkMxTK/h3TH
F803pwrUYyP8cZSDZP05MdadtN2r44cnAcaL/fuYJbHU7e5XSFtnMDV82SVqqWyvUByDR6U94IVc
tvx1KQyBBkc0lWOf6YG8bh0wbgVLee2KkCnK0D5rkhow/cs0CjQSgF3n/FXLQzpNduJh6xgur2uG
esuA7WpzDv6J/SMf1igQnpol7WbuiZ8ReHZemiylItqiGYCpoEqXKFcNdtOdRWch/v3NTmiEdmh/
Rw/Zqaee9hRUPvaK5/2p7tfgvVGPnz2oRZhE4qIyKXlfuX+yYTV0CbGErHHpha9aRcf27sk5yYsZ
0pJPS+hpjuPdaTSXErc0qySrQbcGmps/Pc/wFi2ffwG9uQWfBVbsXtDO6zcpkmA/rZ43blAfGgWP
jjHeymnHgjlaVgbiXF0VmxiyZB2PrhzsxontynxEk3547fZEquSd0SSKHPF6+XXXAgMBAAGjggHK
MIIBxjAfBgNVHSMEGDAWgBQJwPL8C9qU21/+K9+omULPyeCtADAdBgNVHQ4EFgQUnjXwekiBlo+f
ClZ0I1K+bheAf+UwDgYDVR0PAQH/BAQDAgWgMAwGA1UdEwEB/wQCMAAwHQYDVR0lBBYwFAYIKwYB
BQUHAwQGCCsGAQUFBwMCMEAGA1UdIAQ5MDcwNQYMKwYBBAGyMQECAQEBMCUwIwYIKwYBBQUHAgEW
F2h0dHBzOi8vc2VjdGlnby5jb20vQ1BTMFoGA1UdHwRTMFEwT6BNoEuGSWh0dHA6Ly9jcmwuc2Vj
dGlnby5jb20vU2VjdGlnb1JTQUNsaWVudEF1dGhlbnRpY2F0aW9uYW5kU2VjdXJlRW1haWxDQS5j
cmwwgYoGCCsGAQUFBwEBBH4wfDBVBggrBgEFBQcwAoZJaHR0cDovL2NydC5zZWN0aWdvLmNvbS9T
ZWN0aWdvUlNBQ2xpZW50QXV0aGVudGljYXRpb25hbmRTZWN1cmVFbWFpbENBLmNydDAjBggrBgEF
BQcwAYYXaHR0cDovL29jc3Auc2VjdGlnby5jb20wHAYDVR0RBBUwE4ERZHdtd0BhbWF6b24uY28u
dWswDQYJKoZIhvcNAQELBQADggEBAJJ7PuC1/XCVYmvnrxytfbWebpAVZF0n9jEw5F56pi0azxBl
/bOba8gQVpvrUyuAkUlwUkuxGFUfCcf+G9rHdmV0OlSEzQ4OkD2yhSNiy8onRugUAc+0jUEvTKtk
0IF2xQbEy/S3rgByPai/FD47E93meAe7QzNggosO9NJ6HGSH+pbbdfsTL989HSyCcArghXtyWJ2a
5YFuupf5YoTIQ/aRoS8uxGDymXNhtVUUmXfutfbBoqcZpZicncGu9wwyANJAK6jExOFYA6vvDE6H
SeLQretbsLAMgCNRKT58WZLYRpxS8i//TFRbWdfMYnXb9DKL4zDrmbSoTvvqp9x+2DcxggTHMIIE
wwIBATCBrDCBljELMAkGA1UEBhMCR0IxGzAZBgNVBAgTEkdyZWF0ZXIgTWFuY2hlc3RlcjEQMA4G
A1UEBxMHU2FsZm9yZDEYMBYGA1UEChMPU2VjdGlnbyBMaW1pdGVkMT4wPAYDVQQDEzVTZWN0aWdv
IFJTQSBDbGllbnQgQXV0aGVudGljYXRpb24gYW5kIFNlY3VyZSBFbWFpbCBDQQIRAL9CB+ltRPer
Z8eyFT9F6p8wDQYJYIZIAWUDBAIBBQCgggHrMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJ
KoZIhvcNAQkFMQ8XDTI0MTEwNTIwMzgwMlowLwYJKoZIhvcNAQkEMSIEIEwGCvAn3GDEg0UvXuRw
aoNpIUtLn+frgyFw269fiz84MIG9BgkrBgEEAYI3EAQxga8wgawwgZYxCzAJBgNVBAYTAkdCMRsw
GQYDVQQIExJHcmVhdGVyIE1hbmNoZXN0ZXIxEDAOBgNVBAcTB1NhbGZvcmQxGDAWBgNVBAoTD1Nl
Y3RpZ28gTGltaXRlZDE+MDwGA1UEAxM1U2VjdGlnbyBSU0EgQ2xpZW50IEF1dGhlbnRpY2F0aW9u
IGFuZCBTZWN1cmUgRW1haWwgQ0ECEQC/QgfpbUT3q2fHshU/ReqfMIG/BgsqhkiG9w0BCRACCzGB
r6CBrDCBljELMAkGA1UEBhMCR0IxGzAZBgNVBAgTEkdyZWF0ZXIgTWFuY2hlc3RlcjEQMA4GA1UE
BxMHU2FsZm9yZDEYMBYGA1UEChMPU2VjdGlnbyBMaW1pdGVkMT4wPAYDVQQDEzVTZWN0aWdvIFJT
QSBDbGllbnQgQXV0aGVudGljYXRpb24gYW5kIFNlY3VyZSBFbWFpbCBDQQIRAL9CB+ltRPerZ8ey
FT9F6p8wDQYJKoZIhvcNAQEBBQAEggIAFqZI5/vpvb/R59k5w/XKebDMwxEaka7+qtw0S3J2hnDR
Ge61z9vOMixAIm1ajUUKSIm4ji/5jEqVBfz2xdKOdgDSLqoUB6M2AHLDtfqhZAo/4oYyqqpXR3+P
2BJFNCPa5LM4Wr/1Z+bX8V7XQyV4oDs8ZvAxZcRd0UsK245VlxM04oTfavpY5gXqHhZ3C0c/LUIN
Se4lP524n4Pq4sCLOiS9sAjtiR0fv1ncY5zCgFAFfjck34fineXprCDr2lhozrDJe/3fMQ45Jxxa
nIX75FcStMdh1sQqjCjsRDL/PUku4m3MBvmj2N65b/QvK5FNfulQpvimROOd0Wm15GvUnLtwHIh0
PmE/IOFQqLrRWfSJwHQw4UQSmc2MGJWByHvq5edKAixl00zDG74QpxdCmI3AhAQia3cei99IxoX1
5v3wxeetsDCAkiXdBA4PDq8pv8TDwxhBHczB3sFh1wj8yhqKQ9O9MRLDzPCZsCz0YuCQ1M0M1Hq/
nnPLx3P23IKqyyZUJLxq5YASt2P6gTeiiLBfTxdSNJYBiSJ0yLnnntPy/OrGNOPHyXVSyLPAvb7a
7d58kuHaak6h5MnBWTkRqdWbjtJkDaIyorEoNsYQlijmYBSW0wAc1J1HqVSIMBDSXnqITeIMsLiv
OdmSksnMkRTyXU0V8jN5C8yze51H+kEAAAAAAAA=


--=-X+hJcMdLuHPE7bbY3gus--

--===============3544687167705924450==
Content-Type: multipart/alternative; boundary="===============6065512167135581218=="
MIME-Version: 1.0
Content-Disposition: inline

--===============6065512167135581218==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable




Amazon Development Centre (London) Ltd. Registered in England and Wales wit=
h registration number 04543232 with its registered office at 1 Principal Pl=
ace, Worship Street, London EC2A 2FA, United Kingdom.



--===============6065512167135581218==
Content-Type: text/html; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

<br><br><br>Amazon Development Centre (London) Ltd.Registered in England an=
d Wales with registration number 04543232 with its registered office at 1 P=
rincipal Place, Worship Street, London EC2A 2FA, United Kingdom.<br><br><br>

--===============6065512167135581218==--

--===============3544687167705924450==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

--===============3544687167705924450==--

