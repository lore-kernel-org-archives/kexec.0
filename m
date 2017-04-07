Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1cwPG9-0003YQ-Pt
 for kexec@lists.infradead.org; Fri, 07 Apr 2017 08:28:47 +0000
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v378Ik14134029
 for <kexec@lists.infradead.org>; Fri, 7 Apr 2017 04:28:24 -0400
Received: from e28smtp09.in.ibm.com (e28smtp09.in.ibm.com [125.16.236.9])
 by mx0a-001b2d01.pphosted.com with ESMTP id 29nwqe100t-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <kexec@lists.infradead.org>; Fri, 07 Apr 2017 04:28:23 -0400
Received: from localhost
 by e28smtp09.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <zohar@linux.vnet.ibm.com>;
 Fri, 7 Apr 2017 13:58:17 +0530
Received: from d28av07.in.ibm.com (d28av07.in.ibm.com [9.184.220.146])
 by d28relay02.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v378SFD116646304
 for <kexec@lists.infradead.org>; Fri, 7 Apr 2017 13:58:15 +0530
Received: from d28av07.in.ibm.com (localhost [127.0.0.1])
 by d28av07.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v378SEbH030520
 for <kexec@lists.infradead.org>; Fri, 7 Apr 2017 13:58:15 +0530
Subject: Re: [PATCH 09/24] kexec_file: Disable at runtime if securelevel has
 been set
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
Date: Fri, 07 Apr 2017 04:28:08 -0400
In-Reply-To: <20170407074159.GB10737@dhcp-128-65.nay.redhat.com>
References: <20170407061935.GB10100@dhcp-128-65.nay.redhat.com>
 <149142326734.5101.4596394505987813763.stgit@warthog.procyon.org.uk>
 <149142335441.5101.2294976563846442575.stgit@warthog.procyon.org.uk>
 <20170407030545.GA4296@dhcp-128-65.nay.redhat.com>
 <1491536950.4184.10.camel@linux.vnet.ibm.com>
 <21418.1491548875@warthog.procyon.org.uk>
 <20170407074159.GB10737@dhcp-128-65.nay.redhat.com>
Mime-Version: 1.0
Message-Id: <1491553688.4184.73.camel@linux.vnet.ibm.com>
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
To: Dave Young <dyoung@redhat.com>, David Howells <dhowells@redhat.com>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, linux-efi@vger.kernel.org, gnomes@lxorguk.ukuu.org.uk, gregkh@linuxfoundation.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Chun-Yi Lee <jlee@suse.com>, linux-security-module@vger.kernel.org, keyrings@vger.kernel.org, matthew.garrett@nebula.com

T24gRnJpLCAyMDE3LTA0LTA3IGF0IDE1OjQxICswODAwLCBEYXZlIFlvdW5nIHdyb3RlOgo+IE9u
IDA0LzA3LzE3IGF0IDA4OjA3YW0sIERhdmlkIEhvd2VsbHMgd3JvdGU6Cj4gPiBEYXZlIFlvdW5n
IDxkeW91bmdAcmVkaGF0LmNvbT4gd3JvdGU6Cj4gPiAKPiA+ID4gPiA+ID4gKwkvKiBEb24ndCBw
ZXJtaXQgaW1hZ2VzIHRvIGJlIGxvYWRlZCBpbnRvIHRydXN0ZWQga2VybmVscyBpZiB3ZSdyZSBu
b3QKPiA+ID4gPiA+ID4gKwkgKiBnb2luZyB0byB2ZXJpZnkgdGhlIHNpZ25hdHVyZSBvbiB0aGVt
Cj4gPiA+ID4gPiA+ICsJICovCj4gPiA+ID4gPiA+ICsJaWYgKCFJU19FTkFCTEVEKENPTkZJR19L
RVhFQ19WRVJJRllfU0lHKSAmJiBrZXJuZWxfaXNfbG9ja2VkX2Rvd24oKSkKPiA+ID4gPiA+ID4g
KwkJcmV0dXJuIC1FUEVSTTsKPiA+ID4gPiA+ID4gKwo+ID4gPiA+ID4gPiAgCj4gPiA+ID4gCj4g
PiA+ID4gSU1BIGNhbiBiZSB1c2VkIHRvIHZlcmlmeSBmaWxlIHNpZ25hdHVyZXMgdG9vLCBiYXNl
ZCBvbiB0aGUgTFNNIGhvb2tzCj4gPiA+ID4gaW4gwqBrZXJuZWxfcmVhZF9maWxlX2Zyb21fZmQo
KS4gwqBDT05GSUdfS0VYRUNfVkVSSUZZX1NJRyBzaG91bGQgbm90IGJlCj4gPiA+ID4gcmVxdWly
ZWQuCj4gPiA+IAo+ID4gPiBNaW1pLCBJIHJlbWVtYmVyIHdlIHRhbGtlZCBzb210aGluZyBiZWZv
cmUgYWJvdXQgdGhlIHR3byBzaWduYXR1cmUgCj4gPiA+IHZlcmlmaWNhdGlvbi4gT25lIGNhbiBj
aGFuZ2UgSU1BIHBvbGljeSBpbiBpbml0cmFtZnMgdXNlcnNwYWNlLAo+ID4gPiBhbHNvIHRoZXJl
IGFyZSBrZXJuZWwgY21kbGluZSBwYXJhbSB0byBkaXNhYmxlIElNQSwgc28gaXQgY2FuIGJyZWFr
IHRoZQo+ID4gPiBsb2NrZG93bj8gU3VwcG9zZSBrZXhlYyBib290IHdpdGggaW1hIGRpc2FibGVk
IGNtZGxpbmUgcGFyYW0gYW5kIHRoZW4KPiA+ID4ga2V4ZWMgcmVib290IGFnYWluLi4KPiA+IAo+
ID4gSSBndWVzcyBJIHNob3VsZCBsb2NrIGRvd24gdGhlIHBhcmFtZXRlciB0byBkaXNhYmxlIElN
QSB0b28uCj4gCj4gVGhhdCBpcyBvbmUgdGhpbmcsIHVzZXIgY2FuIGNoYW5nZSBJTUEgcG9saWN5
IGluIGluaXRyYW1mcyB1c2Vyc3BhY2UsCj4gSSdtIG5vdCBzdXJlIGlmIElNQSBlbmZvcmNlIHRo
ZSBzaWduZWQgcG9saWN5IG5vdywgaWYgbm8gaXQgd2lsbCBiZSBhbHNvCj4gYSBwcm9ibGVtLgoK
SSdtIG5vdCBzdXJlIGhvdyB0aGlzIHJlbGF0ZXMgdG8gdGhlIHF1ZXN0aW9uIG9mIHdoZXRoZXIg
SU1BIHZlcmlmaWVzCnRoZSBrZXhlYyBrZXJuZWwgaW1hZ2Ugc2lnbmF0dXJlLCBhcyB0aGUgdGVz
dCB3b3VsZCBub3QgYmUgYmFzZWQgb24gYQpLY29uZmlnIG9wdGlvbiwgYnV0IG9uIGEgcnVudGlt
ZSB2YXJpYWJsZS4KClRvIGFuc3dlciB5b3VyIHF1ZXN0aW9uLCB0aGUgcnVsZSBmb3IgcmVxdWly
aW5nIHRoZSBwb2xpY3kgdG8gYmUKc2lnbmVkIGlzOiDCoGFwcHJhaXNlIGZ1bmM9UE9MSUNZX0NI
RUNLIGFwcHJhaXNlX3R5cGU9aW1hc2lnCgpXaGVuIHRoZSBhYmlsaXR5IHRvIGFwcGVuZCBydWxl
cyBpcyBLY29uZmlnIGVuYWJsZWQsIHRoZSBidWlsdGluCnBvbGljeSByZXF1aXJlcyB0aGUgbmV3
IHBvbGljeSBvciBhZGRpdGlvbmFsIHJ1bGVzIHRvIGJlIHNpZ25lZC4KwqBVbmZvcnR1bmF0ZWx5
LCBhbHdheXMgcmVxdWlyaW5nIHRoZSBwb2xpY3kgdG8gYmUgc2lnbmVkLCB3b3VsZCBoYXZlCmJy
b2tlbiB1c2Vyc3BhY2UuCgpNaW1pCgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18Ka2V4ZWMgbWFpbGluZyBsaXN0CmtleGVjQGxpc3RzLmluZnJhZGVhZC5v
cmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9rZXhlYwo=
