Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1cwOaP-0001Qh-5E
 for kexec@lists.infradead.org; Fri, 07 Apr 2017 07:45:39 +0000
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v377cjBt001649
 for <kexec@lists.infradead.org>; Fri, 7 Apr 2017 03:45:15 -0400
Received: from e28smtp06.in.ibm.com (e28smtp06.in.ibm.com [125.16.236.6])
 by mx0a-001b2d01.pphosted.com with ESMTP id 29p61qsrng-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <kexec@lists.infradead.org>; Fri, 07 Apr 2017 03:45:15 -0400
Received: from localhost
 by e28smtp06.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <zohar@linux.vnet.ibm.com>;
 Fri, 7 Apr 2017 13:15:12 +0530
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay08.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v377houl15073500
 for <kexec@lists.infradead.org>; Fri, 7 Apr 2017 13:13:50 +0530
Received: from d28av03.in.ibm.com (localhost [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v377j8J6001417
 for <kexec@lists.infradead.org>; Fri, 7 Apr 2017 13:15:09 +0530
Subject: Re: [PATCH 09/24] kexec_file: Disable at runtime if securelevel has
 been set
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
Date: Fri, 07 Apr 2017 03:45:01 -0400
In-Reply-To: <20170407061935.GB10100@dhcp-128-65.nay.redhat.com>
References: <149142326734.5101.4596394505987813763.stgit@warthog.procyon.org.uk>
 <149142335441.5101.2294976563846442575.stgit@warthog.procyon.org.uk>
 <20170407030545.GA4296@dhcp-128-65.nay.redhat.com>
 <1491536950.4184.10.camel@linux.vnet.ibm.com>
 <20170407061935.GB10100@dhcp-128-65.nay.redhat.com>
Mime-Version: 1.0
Message-Id: <1491551101.4184.48.camel@linux.vnet.ibm.com>
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
To: Dave Young <dyoung@redhat.com>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, linux-efi@vger.kernel.org, gnomes@lxorguk.ukuu.org.uk, Chun-Yi Lee <jlee@suse.com>, gregkh@linuxfoundation.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, David Howells <dhowells@redhat.com>, linux-security-module@vger.kernel.org, keyrings@vger.kernel.org, matthew.garrett@nebula.com

T24gRnJpLCAyMDE3LTA0LTA3IGF0IDE0OjE5ICswODAwLCBEYXZlIFlvdW5nIHdyb3RlOgo+IE9u
IDA0LzA2LzE3IGF0IDExOjQ5cG0sIE1pbWkgWm9oYXIgd3JvdGU6Cj4gPiBPbiBGcmksIDIwMTct
MDQtMDcgYXQgMTE6MDUgKzA4MDAsIERhdmUgWW91bmcgd3JvdGU6Cj4gPiA+IE9uIDA0LzA1LzE3
IGF0IDA5OjE1cG0sIERhdmlkIEhvd2VsbHMgd3JvdGU6Cj4gPiA+ID4gRnJvbTogQ2h1bi1ZaSBM
ZWUgPGpvZXlsaS5rZXJuZWxAZ21haWwuY29tPgo+ID4gPiA+IAo+ID4gPiA+IFdoZW4gS0VYRUNf
VkVSSUZZX1NJRyBpcyBub3QgZW5hYmxlZCwga2VybmVsIHNob3VsZCBub3QgbG9hZHMgaW1hZ2UK
PiA+ID4gPiB0aHJvdWdoIGtleGVjX2ZpbGUgc3lzdGVtY2FsbCBpZiBzZWN1cmVsZXZlbCBoYXMg
YmVlbiBzZXQuCj4gPiA+ID4gCj4gPiA+ID4gVGhpcyBjb2RlIHdhcyBzaG93ZWQgaW4gTWF0dGhl
dydzIHBhdGNoIGJ1dCBub3QgaW4gZ2l0Ogo+ID4gPiA+IGh0dHBzOi8vbGttbC5vcmcvbGttbC8y
MDE1LzMvMTMvNzc4CgpJIHNwZWNpZmljYWxseSBjaGVja2VkIHRvIG1ha2Ugc3VyZSB0aGF0IGVp
dGhlciBrZXhlY19maWxlKCkgc2lnbmF0dXJlCnZlcmlmaWNhdGlvbiB3YXMgYWNjZXB0YWJsZSBh
bmQgd291bGQgaGF2ZSBjb21tZW50ZWQgdGhlbiwgaWYgaXQgaGFkCm5vdCBiZWVuIGluY2x1ZGVk
LgoKPiA+ID4gPiBDYzogTWF0dGhldyBHYXJyZXR0IDxtamc1OUBzcmNmLnVjYW0ub3JnPgo+ID4g
PiA+IFNpZ25lZC1vZmYtYnk6IENodW4tWWkgTGVlIDxqbGVlQHN1c2UuY29tPgo+ID4gPiA+IFNp
Z25lZC1vZmYtYnk6IERhdmlkIEhvd2VsbHMgPGRob3dlbGxzQHJlZGhhdC5jb20+Cj4gPiA+ID4g
Y2M6IGtleGVjQGxpc3RzLmluZnJhZGVhZC5vcmcKPiA+ID4gPiAtLS0KPiA+ID4gPiAKPiA+ID4g
PiAga2VybmVsL2tleGVjX2ZpbGUuYyB8ICAgIDYgKysrKysrCj4gPiA+ID4gIDEgZmlsZSBjaGFu
Z2VkLCA2IGluc2VydGlvbnMoKykKPiA+ID4gPiAKPiA+ID4gPiBkaWZmIC0tZ2l0IGEva2VybmVs
L2tleGVjX2ZpbGUuYyBiL2tlcm5lbC9rZXhlY19maWxlLmMKPiA+ID4gPiBpbmRleCBiMTE4NzM1
ZmVhOWQuLmY2OTM3ZWVjZDFlYiAxMDA2NDQKPiA+ID4gPiAtLS0gYS9rZXJuZWwva2V4ZWNfZmls
ZS5jCj4gPiA+ID4gKysrIGIva2VybmVsL2tleGVjX2ZpbGUuYwo+ID4gPiA+IEBAIC0yNjgsNiAr
MjY4LDEyIEBAIFNZU0NBTExfREVGSU5FNShrZXhlY19maWxlX2xvYWQsIGludCwga2VybmVsX2Zk
LCBpbnQsIGluaXRyZF9mZCwKPiA+ID4gPiAgCWlmICghY2FwYWJsZShDQVBfU1lTX0JPT1QpIHx8
IGtleGVjX2xvYWRfZGlzYWJsZWQpCj4gPiA+ID4gIAkJcmV0dXJuIC1FUEVSTTsKPiA+ID4gPiAg
Cj4gPiA+ID4gKwkvKiBEb24ndCBwZXJtaXQgaW1hZ2VzIHRvIGJlIGxvYWRlZCBpbnRvIHRydXN0
ZWQga2VybmVscyBpZiB3ZSdyZSBub3QKPiA+ID4gPiArCSAqIGdvaW5nIHRvIHZlcmlmeSB0aGUg
c2lnbmF0dXJlIG9uIHRoZW0KPiA+ID4gPiArCSAqLwo+ID4gPiA+ICsJaWYgKCFJU19FTkFCTEVE
KENPTkZJR19LRVhFQ19WRVJJRllfU0lHKSAmJiBrZXJuZWxfaXNfbG9ja2VkX2Rvd24oKSkKPiA+
ID4gPiArCQlyZXR1cm4gLUVQRVJNOwo+ID4gPiA+ICsKPiA+ID4gPiAgCj4gPiAKPiA+IElNQSBj
YW4gYmUgdXNlZCB0byB2ZXJpZnkgZmlsZSBzaWduYXR1cmVzIHRvbywgYmFzZWQgb24gdGhlIExT
TSBob29rcwo+ID4gaW4gwqBrZXJuZWxfcmVhZF9maWxlX2Zyb21fZmQoKS4gwqBDT05GSUdfS0VY
RUNfVkVSSUZZX1NJRyBzaG91bGQgbm90IGJlCj4gPiByZXF1aXJlZC4KPiAKPiBNaW1pLCBJIHJl
bWVtYmVyIHdlIHRhbGtlZCBzb210aGluZyBiZWZvcmUgYWJvdXQgdGhlIHR3byBzaWduYXR1cmUg
Cj4gdmVyaWZpY2F0aW9uLiBPbmUgY2FuIGNoYW5nZSBJTUEgcG9saWN5IGluIGluaXRyYW1mcyB1
c2Vyc3BhY2UsCj4gYWxzbyB0aGVyZSBhcmUga2VybmVsIGNtZGxpbmUgcGFyYW0gdG8gZGlzYWJs
ZSBJTUEsIHNvIGl0IGNhbiBicmVhayB0aGUKPiBsb2NrZG93bj8gU3VwcG9zZSBrZXhlYyBib290
IHdpdGggaW1hIGRpc2FibGVkIGNtZGxpbmUgcGFyYW0gYW5kIHRoZW4KPiBrZXhlYyByZWJvb3Qg
YWdhaW4uLgoKUmlnaHQsIHdlIGRpc2N1c3NlZCB0aGF0IHRoZSBzYW1lIG1ldGhvZCBvZiBtZWFz
dXJpbmcgdGhlIGtleGVjIGltYWdlCmFuZCBpbml0cmFtZnMsIGZvciBleHRlbmRpbmcgdHJ1c3Rl
ZCBib290IHRvIHRoZSBPUywgY291bGQgYWxzbyBiZQp1c2VkIGZvciB2ZXJpZnlpbmcgdGhlIGtl
eGVjIGltYWdlIGFuZCBpbml0cmFtZnMgc2lnbmF0dXJlcywgZm9yCmV4dGVuZGluZyBzZWN1cmUg
Ym9vdCB0byB0aGUgT1MuIMKgVGhlIGZpbGUgaGFzaCB3b3VsZCBiZSBjYWxjdWxhdGVkCm9uY2Ug
Zm9yIGJvdGguCgpBbGwgb2YgeW91ciBjb25jZXJucyBjb3VsZCBiZSBhZGRyZXNzZWQgd2l0aCB2
ZXJ5IG1pbm9yIGNoYW5nZXMgdG8KSU1BLiDCoChDb250aW51ZWQgaW4gcmVzcG9uc2UgdG8gRGF2
aWQuKQoKPiA+IAo+ID4gPiAJLyogTWFrZSBzdXJlIHdlIGhhdmUgYSBsZWdhbCBzZXQgb2YgZmxh
Z3MgKi8KPiA+ID4gPiAgCWlmIChmbGFncyAhPSAoZmxhZ3MgJiBLRVhFQ19GSUxFX0ZMQUdTKSkK
PiA+ID4gPiAgCQlyZXR1cm4gLUVJTlZBTDsKPiA+ID4gPiAKPiA+ID4gPiAKPiA+ID4gPiBfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwo+ID4gPiA+IGtleGVj
IG1haWxpbmcgbGlzdAo+ID4gPiA+IGtleGVjQGxpc3RzLmluZnJhZGVhZC5vcmcKPiA+ID4gPiBo
dHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2tleGVjCj4gPiA+IAo+
ID4gPiBBY2tlZC1ieTogRGF2ZSBZb3VuZyA8ZHlvdW5nQHJlZGhhdC5jb20+Cj4gPiA+IAo+ID4g
PiBUaGFua3MKPiA+ID4gRGF2ZQo+ID4gPiAtLQo+ID4gPiBUbyB1bnN1YnNjcmliZSBmcm9tIHRo
aXMgbGlzdDogc2VuZCB0aGUgbGluZSAidW5zdWJzY3JpYmUgbGludXgtc2VjdXJpdHktbW9kdWxl
IiBpbgo+ID4gPiB0aGUgYm9keSBvZiBhIG1lc3NhZ2UgdG8gbWFqb3Jkb21vQHZnZXIua2VybmVs
Lm9yZwo+ID4gPiBNb3JlIG1ham9yZG9tbyBpbmZvIGF0ICBodHRwOi8vdmdlci5rZXJuZWwub3Jn
L21ham9yZG9tby1pbmZvLmh0bWwKPiA+ID4gCj4gPiAKPiAKCgpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwprZXhlYyBtYWlsaW5nIGxpc3QKa2V4ZWNAbGlz
dHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3Rp
bmZvL2tleGVjCg==
