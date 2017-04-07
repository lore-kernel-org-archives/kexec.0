Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1cwO0L-0000za-CM
 for kexec@lists.infradead.org; Fri, 07 Apr 2017 07:08:22 +0000
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20170407061935.GB10100@dhcp-128-65.nay.redhat.com>
References: <20170407061935.GB10100@dhcp-128-65.nay.redhat.com>
 <149142326734.5101.4596394505987813763.stgit@warthog.procyon.org.uk>
 <149142335441.5101.2294976563846442575.stgit@warthog.procyon.org.uk>
 <20170407030545.GA4296@dhcp-128-65.nay.redhat.com>
 <1491536950.4184.10.camel@linux.vnet.ibm.com>
Subject: Re: [PATCH 09/24] kexec_file: Disable at runtime if securelevel has
 been set
MIME-Version: 1.0
Date: Fri, 07 Apr 2017 08:07:55 +0100
Message-ID: <21418.1491548875@warthog.procyon.org.uk>
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
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, linux-efi@vger.kernel.org, gnomes@lxorguk.ukuu.org.uk, Chun-Yi Lee <jlee@suse.com>, gregkh@linuxfoundation.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, dhowells@redhat.com, linux-security-module@vger.kernel.org, keyrings@vger.kernel.org, matthew.garrett@nebula.com, Mimi Zohar <zohar@linux.vnet.ibm.com>

RGF2ZSBZb3VuZyA8ZHlvdW5nQHJlZGhhdC5jb20+IHdyb3RlOgoKPiA+ID4gPiArCS8qIERvbid0
IHBlcm1pdCBpbWFnZXMgdG8gYmUgbG9hZGVkIGludG8gdHJ1c3RlZCBrZXJuZWxzIGlmIHdlJ3Jl
IG5vdAo+ID4gPiA+ICsJICogZ29pbmcgdG8gdmVyaWZ5IHRoZSBzaWduYXR1cmUgb24gdGhlbQo+
ID4gPiA+ICsJICovCj4gPiA+ID4gKwlpZiAoIUlTX0VOQUJMRUQoQ09ORklHX0tFWEVDX1ZFUklG
WV9TSUcpICYmIGtlcm5lbF9pc19sb2NrZWRfZG93bigpKQo+ID4gPiA+ICsJCXJldHVybiAtRVBF
Uk07Cj4gPiA+ID4gKwo+ID4gPiA+ICAKPiA+IAo+ID4gSU1BIGNhbiBiZSB1c2VkIHRvIHZlcmlm
eSBmaWxlIHNpZ25hdHVyZXMgdG9vLCBiYXNlZCBvbiB0aGUgTFNNIGhvb2tzCj4gPiBpbiDCoGtl
cm5lbF9yZWFkX2ZpbGVfZnJvbV9mZCgpLiDCoENPTkZJR19LRVhFQ19WRVJJRllfU0lHIHNob3Vs
ZCBub3QgYmUKPiA+IHJlcXVpcmVkLgo+IAo+IE1pbWksIEkgcmVtZW1iZXIgd2UgdGFsa2VkIHNv
bXRoaW5nIGJlZm9yZSBhYm91dCB0aGUgdHdvIHNpZ25hdHVyZSAKPiB2ZXJpZmljYXRpb24uIE9u
ZSBjYW4gY2hhbmdlIElNQSBwb2xpY3kgaW4gaW5pdHJhbWZzIHVzZXJzcGFjZSwKPiBhbHNvIHRo
ZXJlIGFyZSBrZXJuZWwgY21kbGluZSBwYXJhbSB0byBkaXNhYmxlIElNQSwgc28gaXQgY2FuIGJy
ZWFrIHRoZQo+IGxvY2tkb3duPyBTdXBwb3NlIGtleGVjIGJvb3Qgd2l0aCBpbWEgZGlzYWJsZWQg
Y21kbGluZSBwYXJhbSBhbmQgdGhlbgo+IGtleGVjIHJlYm9vdCBhZ2Fpbi4uCgpJIGd1ZXNzIEkg
c2hvdWxkIGxvY2sgZG93biB0aGUgcGFyYW1ldGVyIHRvIGRpc2FibGUgSU1BIHRvby4KCkRhdmlk
CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwprZXhlYyBt
YWlsaW5nIGxpc3QKa2V4ZWNAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFk
ZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2tleGVjCg==
