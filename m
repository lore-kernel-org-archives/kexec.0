Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]
 helo=mx0a-001b2d01.pphosted.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1faL2Q-0006ZE-Mz
 for kexec@lists.infradead.org; Tue, 03 Jul 2018 13:08:13 +0000
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w63D5tuJ101649
 for <kexec@lists.infradead.org>; Tue, 3 Jul 2018 09:07:59 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2k09dh0yg8-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <kexec@lists.infradead.org>; Tue, 03 Jul 2018 09:07:59 -0400
Received: from localhost
 by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <zohar@linux.vnet.ibm.com>;
 Tue, 3 Jul 2018 14:07:57 +0100
Subject: Re: [PATCH v5 3/8] ima: based on policy require signed kexec kernel
 images
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
Date: Tue, 03 Jul 2018 09:07:39 -0400
In-Reply-To: <840dae63-5a90-1327-437e-1ed92e165754@gmail.com>
References: <1530542283-26145-1-git-send-email-zohar@linux.vnet.ibm.com>
 <1530542283-26145-4-git-send-email-zohar@linux.vnet.ibm.com>
 <840dae63-5a90-1327-437e-1ed92e165754@gmail.com>
Mime-Version: 1.0
Message-Id: <1530623259.3452.28.camel@linux.vnet.ibm.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: J Freyensee <why2jjj.linux@gmail.com>, linux-integrity@vger.kernel.org
Cc: Andres Rodriguez <andresx7@gmail.com>, Kees Cook <keescook@chromium.org>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, David Howells <dhowells@redhat.com>, linux-security-module@vger.kernel.org, Eric Biederman <ebiederm@xmission.com>, "Luis R . Rodriguez" <mcgrof@kernel.org>

T24gTW9uLCAyMDE4LTA3LTAyIGF0IDExOjMxIC0wNzAwLCBKIEZyZXllbnNlZSB3cm90ZToKPiAK
PiBPbiA3LzIvMTggNzozNyBBTSwgTWltaSBab2hhciB3cm90ZToKPiA+IFRoZSBvcmlnaW5hbCBr
ZXhlY19sb2FkIHN5c2NhbGwgY2FuIG5vdCB2ZXJpZnkgZmlsZSBzaWduYXR1cmVzLCBub3IgY2Fu
Cj4gPiB0aGUga2V4ZWMgaW1hZ2UgYmUgbWVhc3VyZWQuICBCYXNlZCBvbiBwb2xpY3ksIGRlbnkg
dGhlIGtleGVjX2xvYWQKPiA+IHN5c2NhbGwuCj4gCj4gCj4gQ3VyaW9zaXR5IHF1ZXN0aW9uOiBJ
IHRob3VnaHQga2V4ZWNfbG9hZCgpIHN5c2NhbGwgd2FzIHVzZWQgdG8gbG9hZCBhIAo+IGNyYXNo
ZHVtcD8KCmtleGVjIGlzIHVzZWQgdG8gY29sbGVjdCB0aGUgbWVtb3J5IHVzZWQgdG8gYW5hbHl6
ZSB0aGUgY3Jhc2ggZHVtcC4KCj4gSWYgdGhpcyBpcyB0cnVlLCBob3cgd291bGQgdGhpcyB3b3Jr
IGlmIGtleGVjX2xvYWQoKSBpcyAKPiBiZWluZyBkZW5pZWQ/wqAgSSBkb24ndCB0aGluayBJJ2Qg
d2FudCB0byBiZSBoaW5kZXJlZCBpbiBjYXNlcyB3aGVyZSBJJ20gCj4gdHJ5aW5nIHRvIGRpYWdu
b3NlIGEgY3Jhc2guCgpGb3IgdHJ1c3RlZCAmIHNlY3VyZSBib290LCB3ZSBuZWVkIGEgZnVsbCBt
ZWFzdXJlbWVudCBsaXN0IGFuZApzaWduYXR1cmUgY2hhaW4gb2YgdHJ1c3Qgcm9vdGVkIGluIEhX
LiDCoFBlcm1pdHRpbmcga2V4ZWNfbG9hZCB3b3VsZApicmVhayB0aGVzZSBjaGFpbnMgb2YgdHJ1
c3QuCgpQZXJtaXR0aW5nL2Rlbnlpbmcga2V4ZWNfbG9hZCBpcyBiYXNlZCBvbiBhIHJ1bnRpbWUg
SU1BIHBvbGljeS4gwqBQYXRjaAo2LzggImltYTogYWRkIGJ1aWxkIHRpbWUgcG9saWN5IiwgaW4g
dGhpcyBwYXRjaCBzZXQsIGludHJvZHVjZXMgdGhlCmNvbmNlcHQgb2YgYSBidWlsZCB0aW1lIHBv
bGljeS4gwqBXaXRoIHRoZXNlIHBhdGNoZXMsIHlvdSBjb3VsZApjb25maWd1cmUgeW91ciBrZXJu
ZWwgYW5kL29yIGxvYWQgYW4gSU1BIHBvbGljeSBwZXJtaXR0aW5nIGtleGVjX2xvYWQuCgpNaW1p
CgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18Ka2V4ZWMg
bWFpbGluZyBsaXN0CmtleGVjQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJh
ZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9rZXhlYwo=
