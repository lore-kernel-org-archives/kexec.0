Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gj4pY-0006a7-CN
 for kexec@lists.infradead.org; Mon, 14 Jan 2019 16:11:18 +0000
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 x0EFRo72054330
 for <kexec@lists.infradead.org>; Mon, 14 Jan 2019 11:11:13 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2q0u2n0ts2-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <kexec@lists.infradead.org>; Mon, 14 Jan 2019 11:11:12 -0500
Received: from localhost
 by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <zohar@linux.ibm.com>;
 Mon, 14 Jan 2019 16:11:10 -0000
Subject: Re: [RFC PATCH 2/2] kexec, KEYS: Make use of platform keyring for
 signature verify
From: Mimi Zohar <zohar@linux.ibm.com>
Date: Mon, 14 Jan 2019 11:10:51 -0500
In-Reply-To: <20190113013958.GA14019@dhcp-128-65.nay.redhat.com>
References: <20190109164824.19708-1-kasong@redhat.com>
 <20190109164824.19708-3-kasong@redhat.com>
 <20190111134303.GA12760@dhcp-128-65.nay.redhat.com>
 <1547223220.19931.471.camel@linux.ibm.com>
 <20190113013958.GA14019@dhcp-128-65.nay.redhat.com>
Mime-Version: 1.0
Message-Id: <1547482251.4156.127.camel@linux.ibm.com>
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
Cc: jwboyer@fedoraproject.org, Kairui Song <kasong@redhat.com>, ebiggers@google.com, nayna@linux.ibm.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, jmorris@namei.org, dhowells@redhat.com, keyrings@vger.kernel.org, linux-integrity@vger.kernel.org, dwmw2@infradead.org, bauerman@linux.ibm.com, serge@hallyn.com

T24gU3VuLCAyMDE5LTAxLTEzIGF0IDA5OjM5ICswODAwLCBEYXZlIFlvdW5nIHdyb3RlOgo+IEhp
LAo+IAo+IE9uIDAxLzExLzE5IGF0IDExOjEzYW0sIE1pbWkgWm9oYXIgd3JvdGU6Cj4gPiBPbiBG
cmksIDIwMTktMDEtMTEgYXQgMjE6NDMgKzA4MDAsIERhdmUgWW91bmcgd3JvdGU6Cj4gPiBbc25p
cF0KPiA+IAo+ID4gPiBQZXJzb25hbGx5IEkgd291bGQgbGlrZSB0byBzZWUgcGxhdGZvcm0ga2V5
IHNlcGFyYXRlZCBmcm9tIGludGVncml0eS4KPiA+ID4gQnV0IGZvciB0aGUga2V4ZWNfZmlsZSBw
YXJ0IEkgdGhpbmsgaXQgaXMgZ29vZCBhdCBsZWFzdCBpdCB3b3JrcyB3aXRoCj4gPiA+IHRoaXMg
Zml4Lgo+ID4gPiAKPiA+ID4gQWNrZWQtYnk6IERhdmUgWW91bmcgPGR5b3VuZ0ByZWRoYXQuY29t
Pgo+ID4gCj4gPiBUaGUgb3JpZ2luYWwgInBsYXRmb3JtIiBrZXlyaW5nIHBhdGNoZXMgdGhhdCBO
YXluYSBwb3N0ZWQgbXVsdGlwbGUKPiA+IHRpbWVzIHdlcmUgaW4gdGhlIGNlcnRzIGRpcmVjdG9y
eSwgYnV0IG5vYm9keSBjb21tZW50ZWQvcmVzcG9uZGVkLiDCoFNvCj4gPiBzaGUgcmV3b3JrZWQg
dGhlIHBhdGNoZXMsIG1vdmluZyB0aGVtIHRvIHRoZSBpbnRlZ3JpdHkgZGlyZWN0b3J5IGFuZAo+
ID4gcG9zdGVkIHRoZW0gKGNjJ2luZyB0aGUga2V4ZWMgbWFpbGluZyBsaXN0KS4gwqBJdCdzIGEg
Yml0IGxhdGUgdG8gYmUKPiA+IGFza2luZyB0byBtb3ZlIGl0LCBpc24ndCBpdD8KPiAKPiBIbW0s
IGFwb2xvZ2l6ZSBmb3IgYmVpbmcgbGF0ZSwgIEkgZGlkIG5vdCBnZXQgY2hhbmNlIHRvIGhhdmUg
YSBsb29rIHRoZQo+IG9sZCBzZXJpZXMuICBTaW5jZSB3ZSBoYXZlIHRoZSBuZWVkcyBub3csIGl0
IHNob3VsZCBiZSBzdGlsbCBmaW5lCj4gCj4gTWF5YmUgS2FpcnVpIGNhbiBjaGVjayBOYXluYSdz
IG9sZCBzZXJpZXMsIHNlZSBpZiBoZSBjYW4gZG8gc29tZXRoaW5nCj4gYWdhaW4/CgpXaGV0aGVy
IHRoZSBwbGF0Zm9ybSBrZXlyaW5nIGlzIGRlZmluZWQgaW4gY2VydHMvIG9yIGluIGludGVncml0
eS8gdGhlCmtleXJpbmcgaWQgbmVlZHMgdG8gYmUgYWNjZXNzaWJsZSB0byB0aGUgb3RoZXIsIHdp
dGhvdXQgbWFraW5nIHRoZQprZXlyaW5nIGlkIGdsb2JhbC4gwqBNb3Zpbmcgd2hlcmUgdGhlIHBs
YXRmb3JtIGtleXJpbmcgaXMgZGVmaW5lZCBpcwpub3QgdGhlIHByb2JsZW0uCgpDb21taXQgYTIx
MGZkMzJhNDZiICgia2V4ZWM6IGFkZCBjYWxsIHRvIExTTSBob29rIGluIG9yaWdpbmFsCmtleGVj
X2xvYWQgc3lzY2FsbCIpIGludHJvZHVjZWQgYSBuZXcgTFNNIGhvb2suIMKgQXNzdW1pbmcKQ09O
RklHX0tFWEVDX1ZFUklGWV9TSUcgaXMgZW5hYmxlZCwgd2l0aCBjb21taXQgYjVjYTExNzM2NWQ5
ICgiaW1hOgpwcmV2ZW50IGtleGVjX2xvYWQgc3lzY2FsbCBiYXNlZCBvbiBydW50aW1lIHNlY3Vy
ZWJvb3QgZmxhZyIpIHdlIGNhbgpub3cgYmxvY2sgdGhlIGtleGVjX2xvYWQgc3lzY2FsbC4gwqBX
aXRob3V0IGJlaW5nIGFibGUgdG8gYmxvY2sgdGhlCmtleGVjX2xvYWQgc3lzY2FsbCwgdmVyaWZ5
aW5nIHRoZSBrZXhlYyBpbWFnZSBzaWduYXR1cmUgdmlhIHRoZQprZXhlY19maWxlX2xvYWQgc3lz
Y2FsbCBpcyBraW5kIG9mIHBvaW50bGVzcy4KClVubGVzcyB5b3UncmUgcGxhbm5pbmcgb24gd3Jp
dGluZyBhbiBMU00gdG8gcHJldmVudCB0aGUga2V4ZWNfbG9hZApzeXNjYWxsLCBJIGFzc3VtZSB5
b3UnbGwgd2FudCB0byBlbmFibGUgaW50ZWdyaXR5IGFueXdheS4KCk1pbWkKCgpfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwprZXhlYyBtYWlsaW5nIGxpc3QK
a2V4ZWNAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWls
bWFuL2xpc3RpbmZvL2tleGVjCg==
