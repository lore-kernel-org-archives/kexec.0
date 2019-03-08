Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]
 helo=mx0a-001b2d01.pphosted.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1h2KSu-0004k2-38
 for kexec@lists.infradead.org; Fri, 08 Mar 2019 18:43:30 +0000
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x28Icm8B091006
 for <kexec@lists.infradead.org>; Fri, 8 Mar 2019 13:43:26 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2r3w4hhynv-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <kexec@lists.infradead.org>; Fri, 08 Mar 2019 13:43:25 -0500
Received: from localhost
 by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <zohar@linux.ibm.com>;
 Fri, 8 Mar 2019 18:43:24 -0000
Subject: Re: [PATCH 3/3] x86/ima: retry detecting secure boot mode
From: Mimi Zohar <zohar@linux.ibm.com>
Date: Fri, 08 Mar 2019 13:43:18 -0500
In-Reply-To: <CACdnJut3Y7CogvgtNsEcrEtA1WOxSb9OWP_wZ=3xNgCft2oeDw@mail.gmail.com>
References: <1542657371-7019-1-git-send-email-zohar@linux.ibm.com>
 <1542657371-7019-4-git-send-email-zohar@linux.ibm.com>
 <CACdnJusqHZ1OLJD1baN=fXK9KE+bSqzB4OUbmLXH5-qZNrQXJg@mail.gmail.com>
 <CAFbkSA39RwB+E4SaG_ueu-_B=y7JytEYKw1+eXNQ_eCuMfnv=g@mail.gmail.com>
 <CACdnJuuHmK0qKjMxxonRYDUCatxqs930QGNQmREhRjimpNKzYw@mail.gmail.com>
 <1551998897.31706.461.camel@linux.ibm.com>
 <CACdnJusiLSCyqx7NX5bkpFr2N5YjBt_h3miOgkbey-Zndc3+Kg@mail.gmail.com>
 <1552052377.4134.23.camel@linux.ibm.com>
 <CACdnJut3Y7CogvgtNsEcrEtA1WOxSb9OWP_wZ=3xNgCft2oeDw@mail.gmail.com>
Mime-Version: 1.0
Message-Id: <1552070598.4134.51.camel@linux.ibm.com>
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

T24gRnJpLCAyMDE5LTAzLTA4IGF0IDA5OjUxIC0wODAwLCBNYXR0aGV3IEdhcnJldHQgd3JvdGU6
Cj4gT24gRnJpLCBNYXIgOCwgMjAxOSBhdCA1OjQwIEFNIE1pbWkgWm9oYXIgPHpvaGFyQGxpbnV4
LmlibS5jb20+IHdyb3RlOgo+ID4KPiA+IE9uIFRodSwgMjAxOS0wMy0wNyBhdCAxNDo1MCAtMDgw
MCwgTWF0dGhldyBHYXJyZXR0IHdyb3RlOgo+ID4gPiBJcyB0aGUgaXNzdWUgdGhhdCBpdCBnaXZl
cyBpbmNvcnJlY3QgcmVzdWx0cyBvbiB0aGUgZmlyc3QgcmVhZCwgb3IgaXMKPiA+ID4gdGhlIGlz
c3VlIHRoYXQgaXQgZ2l2ZXMgaW5jb3JyZWN0IHJlc3VsdHMgYmVmb3JlIEV4aXRCb290U2Vydmlj
ZXMoKSBpcwo+ID4gPiBjYWxsZWQ/IElmIHRoZSBmb3JtZXIgdGhlbiB3ZSBzaG91bGQgcmVhZCB0
d2ljZSBpbiB0aGUgYm9vdCBzdHViLCBpZgo+ID4gPiB0aGUgbGF0dGVyIHRoZW4gd2Ugc2hvdWxk
IGZpZ3VyZSBvdXQgYSB3YXkgdG8gZG8gdGhpcyBpbW1lZGlhdGVseQo+ID4gPiBhZnRlciBFeGl0
Qm9vdFNlcnZpY2VzKCkgaW5zdGVhZC4KPiA+Cj4gPiBEZXRlY3RpbmcgdGhlIHNlY3VyZSBib290
IG1vZGUgaXNuJ3QgdGhlIHByb2JsZW0uICBPbiBib290LCBJIGFtCj4gPiBzZWVpbmcgIkVGSSBz
dHViOiBVRUZJIFNlY3VyZSBCb290IGlzIGVuYWJsZWQiLCBidXQgc2V0dXBfYXJjaCgpIGVtaXRz
Cj4gPiAiU2VjdXJlIGJvb3QgY291bGQgbm90IGJlIGRldGVybWluZWQiLgo+ID4KPiA+IEluIGVm
aV9tYWluKCkgdGhlIHNlY3VyZV9ib290IG1vZGUgaXMgaW5pdGlhbGx5IHVuc2V0LCBzbwo+ID4g
ZWZpX2dldF9zZWN1cmVib290KCkgaXMgY2FsbGVkLiAgZWZpX2dldF9zZWN1cmVib290KCkgcmV0
dXJucyB0aGUKPiA+IHNlY3VyZV9ib290IG1vZGUgY29ycmVjdGx5IGFzIGVuYWJsZWQuICBUaGUg
cHJvYmxlbSBzZWVtcyB0byBiZSBpbgo+ID4gc2F2aW5nIHRoZSBzZWN1cmVfYm9vdCBtb2RlIGZv
ciBsYXRlciB1c2UuCj4gCj4gSG0uIEFuZCB0aGlzIG9ubHkgaGFwcGVucyBvbiBjZXJ0YWluIGZp
cm13YXJlIHZlcnNpb25zPyBJZiBzb21ldGhpbmcncwo+IHN0ZXBwaW5nIG9uIGJvb3RfcGFyYW1z
IHRoZW4gd2UgaGF2ZSBiaWdnZXIgcHJvYmxlbXMuCgpGWUksIGVmaV9wcmludGsoKSB3b3JrcyBi
ZWZvcmUgZXhpdF9ib290KCksIGJ1dCBub3QgYWZ0ZXJ3YXJkcy4gwqBUaGUKc3lzdGVtIGhhbmdz
LgoKTWltaQoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
CmtleGVjIG1haWxpbmcgbGlzdAprZXhlY0BsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0
cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8va2V4ZWMK
