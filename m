Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]
 helo=mx0a-001b2d01.pphosted.com)
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1hfWVD-0008RS-Cd
 for kexec@lists.infradead.org; Mon, 24 Jun 2019 21:27:52 +0000
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x5OLNjjZ117287
 for <kexec@lists.infradead.org>; Mon, 24 Jun 2019 17:27:46 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2tb6arg9jk-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <kexec@lists.infradead.org>; Mon, 24 Jun 2019 17:27:46 -0400
Received: from localhost
 by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <zohar@linux.ibm.com>;
 Mon, 24 Jun 2019 22:27:44 +0100
Subject: Re: [PATCH V31 07/25] kexec_file: Restrict at runtime if the kernel
 is locked down
From: Mimi Zohar <zohar@linux.ibm.com>
Date: Mon, 24 Jun 2019 17:27:37 -0400
In-Reply-To: <CACdnJusPtYLdg7ZPhBo=Y5EsBz6B+5M2zYscBrLcc89oNnPkdQ@mail.gmail.com>
References: <20190326182742.16950-1-matthewgarrett@google.com>
 <20190326182742.16950-8-matthewgarrett@google.com>
 <20190621064340.GB4528@localhost.localdomain>
 <CACdnJut=J1YTpM4s6g5XWCEs+=X0Jvf8otfMg+w=_oqSZmf01Q@mail.gmail.com>
 <20190624015206.GB2976@dhcp-128-65.nay.redhat.com>
 <CACdnJusPtYLdg7ZPhBo=Y5EsBz6B+5M2zYscBrLcc89oNnPkdQ@mail.gmail.com>
Mime-Version: 1.0
Message-Id: <1561411657.4340.70.camel@linux.ibm.com>
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
To: Matthew Garrett <mjg59@google.com>, Dave Young <dyoung@redhat.com>
Cc: Jiri Bohac <jbohac@suse.cz>, Linux API <linux-api@vger.kernel.org>, kexec@lists.infradead.org, James Morris <jmorris@namei.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, David Howells <dhowells@redhat.com>, LSM List <linux-security-module@vger.kernel.org>, Andy Lutomirski <luto@kernel.org>

SGkgTWF0dGhldywKCk9uIE1vbiwgMjAxOS0wNi0yNCBhdCAxNDowNiAtMDcwMCwgTWF0dGhldyBH
YXJyZXR0IHdyb3RlOgo+IE9uIFN1biwgSnVuIDIzLCAyMDE5IGF0IDY6NTIgUE0gRGF2ZSBZb3Vu
ZyA8ZHlvdW5nQHJlZGhhdC5jb20+IHdyb3RlOgo+ID4KPiA+IE9uIDA2LzIxLzE5IGF0IDAxOjE4
cG0sIE1hdHRoZXcgR2FycmV0dCB3cm90ZToKPiA+ID4gSSBkb24ndCB0aGluayBzbyAtIHdlIHdh
bnQgaXQgdG8gYmUgcG9zc2libGUgdG8gbG9hZCBpbWFnZXMgaWYgdGhleQo+ID4gPiBoYXZlIGEg
dmFsaWQgc2lnbmF0dXJlLgo+ID4KPiA+IEkga25vdyBpdCB3b3JrcyBsaWtlIHRoaXMgd2F5IGJl
Y2F1c2Ugb2YgdGhlIHByZXZpb3VzIHBhdGNoLiAgQnV0IGZyb20KPiA+IHRoZSBwYXRjaCBsb2cg
IldoZW4gS0VYRUNfU0lHIGlzIG5vdCBlbmFibGVkLCBrZXJuZWwgc2hvdWxkIG5vdCBsb2FkCj4g
PiBpbWFnZXMiLCBpdCBpcyBzaW1wbGUgdG8gY2hlY2sgaXQgZWFybHkgZm9yICFJU19FTkFCTEVE
KENPTkZJR19LRVhFQ19TSUcpICYmCj4gPiBrZXJuZWxfaXNfbG9ja2VkX2Rvd24ocmVhc29uLCBM
T0NLRE9XTl9JTlRFR1JJVFkpICBpbnN0ZWFkIG9mIGRlcGVuZGluZwo+ID4gb24gdGhlIGxhdGUg
Y29kZSB0byB2ZXJpZnkgc2lnbmF0dXJlLiAgSW4gdGhhdCB3YXksIGVhc2llciB0bwo+ID4gdW5k
ZXJzdGFuZCB0aGUgbG9naWMsIG5vPwo+IAo+IEJ1dCB0aGF0IGNvbWJpbmF0aW9uIGRvZXNuJ3Qg
ZW5mb3JjZSBzaWduYXR1cmUgdmFsaWRhdGlvbj8gV2UgY2FuJ3QKPiBkZXBlbmQgb24gIUlTX0VO
QUJMRUQoQ09ORklHX0tFWEVDX1NJR19GT1JDRSkgYmVjYXVzZSB0aGVuIGl0J2xsCj4gZW5mb3Jj
ZSBzaWduYXR1cmUgdmFsaWRhdGlvbiBldmVuIGlmIGxvY2tkb3duIGlzIGRpc2FibGVkLgoKSSBh
Z3JlZSB3aXRoIERhdmUuIMKgVGhlcmUgc2hvdWxkIGJlIGEgc3R1YiBsb2NrZG93biBmdW5jdGlv
biB0bwpwcmV2ZW50IGVuZm9yY2luZyBsb2NrZG93biB3aGVuIGl0IGlzbid0IGVuYWJsZWQuCgpN
aW1pCgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18Ka2V4
ZWMgbWFpbGluZyBsaXN0CmtleGVjQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmlu
ZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9rZXhlYwo=
