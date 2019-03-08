Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1h2FjC-0002bY-Tb
 for kexec@lists.infradead.org; Fri, 08 Mar 2019 13:40:00 +0000
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x28DVFgt083793
 for <kexec@lists.infradead.org>; Fri, 8 Mar 2019 08:39:56 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2r3s3gs4x7-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <kexec@lists.infradead.org>; Fri, 08 Mar 2019 08:39:56 -0500
Received: from localhost
 by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <zohar@linux.ibm.com>;
 Fri, 8 Mar 2019 13:39:53 -0000
Subject: Re: [PATCH 3/3] x86/ima: retry detecting secure boot mode
From: Mimi Zohar <zohar@linux.ibm.com>
Date: Fri, 08 Mar 2019 08:39:37 -0500
In-Reply-To: <CACdnJusiLSCyqx7NX5bkpFr2N5YjBt_h3miOgkbey-Zndc3+Kg@mail.gmail.com>
References: <1542657371-7019-1-git-send-email-zohar@linux.ibm.com>
 <1542657371-7019-4-git-send-email-zohar@linux.ibm.com>
 <CACdnJusqHZ1OLJD1baN=fXK9KE+bSqzB4OUbmLXH5-qZNrQXJg@mail.gmail.com>
 <CAFbkSA39RwB+E4SaG_ueu-_B=y7JytEYKw1+eXNQ_eCuMfnv=g@mail.gmail.com>
 <CACdnJuuHmK0qKjMxxonRYDUCatxqs930QGNQmREhRjimpNKzYw@mail.gmail.com>
 <1551998897.31706.461.camel@linux.ibm.com>
 <CACdnJusiLSCyqx7NX5bkpFr2N5YjBt_h3miOgkbey-Zndc3+Kg@mail.gmail.com>
Mime-Version: 1.0
Message-Id: <1552052377.4134.23.camel@linux.ibm.com>
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
To: Matthew Garrett <mjg59@google.com>
Cc: linux-efi <linux-efi@vger.kernel.org>, Nayna Jain <nayna@linux.ibm.com>, kexec@lists.infradead.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, David Howells <dhowells@redhat.com>, Seth Forshee <seth.forshee@canonical.com>, LSM List <linux-security-module@vger.kernel.org>, Justin Forbes <jforbes@redhat.com>, linux-integrity <linux-integrity@vger.kernel.org>

T24gVGh1LCAyMDE5LTAzLTA3IGF0IDE0OjUwIC0wODAwLCBNYXR0aGV3IEdhcnJldHQgd3JvdGU6
Cj4gT24gVGh1LCBNYXIgNywgMjAxOSBhdCAyOjQ4IFBNIE1pbWkgWm9oYXIgPHpvaGFyQGxpbnV4
LmlibS5jb20+IHdyb3RlOgo+ID4gSSBhZGRlZCB0aGlzIGxhc3QgYXR0ZW1wdCBiZWNhdXNlIEkn
bSBzZWVpbmcgdGhpcyBvbiBteSBsYXB0b3AsIHdpdGgKPiA+IHNvbWUgb2xkZXIsIGJ1Z2d5IGZp
cm13YXJlLgo+IAo+IElzIHRoZSBpc3N1ZSB0aGF0IGl0IGdpdmVzIGluY29ycmVjdCByZXN1bHRz
IG9uIHRoZSBmaXJzdCByZWFkLCBvciBpcwo+IHRoZSBpc3N1ZSB0aGF0IGl0IGdpdmVzIGluY29y
cmVjdCByZXN1bHRzIGJlZm9yZSBFeGl0Qm9vdFNlcnZpY2VzKCkgaXMKPiBjYWxsZWQ/IElmIHRo
ZSBmb3JtZXIgdGhlbiB3ZSBzaG91bGQgcmVhZCB0d2ljZSBpbiB0aGUgYm9vdCBzdHViLCBpZgo+
IHRoZSBsYXR0ZXIgdGhlbiB3ZSBzaG91bGQgZmlndXJlIG91dCBhIHdheSB0byBkbyB0aGlzIGlt
bWVkaWF0ZWx5Cj4gYWZ0ZXIgRXhpdEJvb3RTZXJ2aWNlcygpIGluc3RlYWQuCgpEZXRlY3Rpbmcg
dGhlIHNlY3VyZSBib290IG1vZGUgaXNuJ3QgdGhlIHByb2JsZW0uIMKgT24gYm9vdCwgSSBhbQpz
ZWVpbmcgIkVGSSBzdHViOiBVRUZJIFNlY3VyZSBCb290IGlzIGVuYWJsZWQiLCBidXQgc2V0dXBf
YXJjaCgpIGVtaXRzCiJTZWN1cmUgYm9vdCBjb3VsZCBub3QgYmUgZGV0ZXJtaW5lZCIuCgpJbiBl
ZmlfbWFpbigpIHRoZSBzZWN1cmVfYm9vdCBtb2RlIGlzIGluaXRpYWxseSB1bnNldCwgc28KZWZp
X2dldF9zZWN1cmVib290KCkgaXMgY2FsbGVkLiDCoGVmaV9nZXRfc2VjdXJlYm9vdCgpIHJldHVy
bnMgdGhlCnNlY3VyZV9ib290IG1vZGUgY29ycmVjdGx5IGFzIGVuYWJsZWQuIMKgVGhlIHByb2Js
ZW0gc2VlbXMgdG8gYmUgaW4Kc2F2aW5nIHRoZSBzZWN1cmVfYm9vdCBtb2RlIGZvciBsYXRlciB1
c2UuCgpNaW1pCgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18Ka2V4ZWMgbWFpbGluZyBsaXN0CmtleGVjQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xp
c3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9rZXhlYwo=
