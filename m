Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-io1-xd2f.google.com ([2607:f8b0:4864:20::d2f])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1h2M1D-0004Z9-GU
 for kexec@lists.infradead.org; Fri, 08 Mar 2019 20:23:00 +0000
Received: by mail-io1-xd2f.google.com with SMTP id y6so17769884ioq.10
 for <kexec@lists.infradead.org>; Fri, 08 Mar 2019 12:22:59 -0800 (PST)
MIME-Version: 1.0
References: <1542657371-7019-1-git-send-email-zohar@linux.ibm.com>
 <1542657371-7019-4-git-send-email-zohar@linux.ibm.com>
 <CACdnJusqHZ1OLJD1baN=fXK9KE+bSqzB4OUbmLXH5-qZNrQXJg@mail.gmail.com>
 <CAFbkSA39RwB+E4SaG_ueu-_B=y7JytEYKw1+eXNQ_eCuMfnv=g@mail.gmail.com>
 <CACdnJuuHmK0qKjMxxonRYDUCatxqs930QGNQmREhRjimpNKzYw@mail.gmail.com>
 <1551998897.31706.461.camel@linux.ibm.com>
 <CACdnJusiLSCyqx7NX5bkpFr2N5YjBt_h3miOgkbey-Zndc3+Kg@mail.gmail.com>
 <1552052377.4134.23.camel@linux.ibm.com>
 <CACdnJut3Y7CogvgtNsEcrEtA1WOxSb9OWP_wZ=3xNgCft2oeDw@mail.gmail.com>
 <1552070598.4134.51.camel@linux.ibm.com>
In-Reply-To: <1552070598.4134.51.camel@linux.ibm.com>
From: Matthew Garrett <mjg59@google.com>
Date: Fri, 8 Mar 2019 12:22:46 -0800
Message-ID: <CACdnJuso1o=fib+fUuY_f2ibJKD5N=kr_BrAtgu_srHCcRLKig@mail.gmail.com>
Subject: Re: [PATCH 3/3] x86/ima: retry detecting secure boot mode
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
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: linux-efi <linux-efi@vger.kernel.org>, Nayna Jain <nayna@linux.ibm.com>, kexec@lists.infradead.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, David Howells <dhowells@redhat.com>, Seth Forshee <seth.forshee@canonical.com>, LSM List <linux-security-module@vger.kernel.org>, Justin Forbes <jforbes@redhat.com>, linux-integrity <linux-integrity@vger.kernel.org>

T24gRnJpLCBNYXIgOCwgMjAxOSBhdCAxMDo0MyBBTSBNaW1pIFpvaGFyIDx6b2hhckBsaW51eC5p
Ym0uY29tPiB3cm90ZToKPiBGWUksIGVmaV9wcmludGsoKSB3b3JrcyBiZWZvcmUgZXhpdF9ib290
KCksIGJ1dCBub3QgYWZ0ZXJ3YXJkcy4gIFRoZQo+IHN5c3RlbSBoYW5ncy4KCmVmaV9wcmludGso
KSB1c2VzIGJvb3Qgc2VydmljZXMgdG8gcHJpbnQsIHNvIHRoYXQncyBub3QgdW5leHBlY3RlZCA6
KQpJdCB3b3VsZCBwcm9iYWJseSBiZSBzZW5zaWJsZSB0byByZXR1cm4gYW4gZXJyb3IgcmF0aGVy
IHRoYW4gY3Jhc2gsCnRob3VnaOKApgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18Ka2V4ZWMgbWFpbGluZyBsaXN0CmtleGVjQGxpc3RzLmluZnJhZGVhZC5v
cmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9rZXhlYwo=
