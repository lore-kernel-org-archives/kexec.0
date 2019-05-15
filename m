Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1hQoWf-00022q-VW
 for kexec@lists.infradead.org; Wed, 15 May 2019 07:40:35 +0000
Date: Wed, 15 May 2019 09:40:28 +0200
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] xen: Avoid overlapping segments in low memory
Message-ID: <20190515074027.fzvcrpn3vtwmwrx5@verge.net.au>
References: <3d9c5c7c501b4d97feffae2bdb6fc84fb40e144a.camel@infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <3d9c5c7c501b4d97feffae2bdb6fc84fb40e144a.camel@infradead.org>
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
To: David Woodhouse <dwmw2@infradead.org>
Cc: kexec <kexec@lists.infradead.org>

T24gU3VuLCBBcHIgMjgsIDIwMTkgYXQgMDE6NTI6MTJQTSArMDMwMCwgRGF2aWQgV29vZGhvdXNl
IHdyb3RlOgo+IEZyb206IERhdmlkIFdvb2Rob3VzZSA8ZHdtd0BhbWF6b24uY28udWs+Cj4gCj4g
VW5saWtlIExpbnV4IHdoaWNoIGNyZWF0ZXMgYSBmdWxsIGlkZW50aXR5IG1hcHBpbmcsIFhlbiBv
bmx5IG1hcHMgdGhvc2UKPiBzZWdtZW50cyB3aGljaCBhcmUgZXhwbGljaXRseSByZXF1ZXN0ZWQu
IFRoZXJlZm9yZSwgeGVuX2tleGVjX2xvYWQoKQo+IHNpbGVudGx5IGFkZHMgaW4gYSBzZWdtZW50
IGZyb20gemVybyB0byAxTWlCIHRvIGVuc3VyZSB0aGF0IFZHQSBtZW1vcnkKPiBhbmQgb3RoZXIg
dGhpbmdzIGFyZSBhY2Nlc3NpYmxlLgo+IAo+IEhvd2V2ZXIsIHRoaXMgZG9lc24ndCB3b3JrIHdo
ZW4gdGhlcmUgYXJlIGFscmVhZHkgc2VnbWVudHMgdG8gYmUgbG9hZGVkCj4gdW5kZXIgMU1pQiwg
YmVjYXVzZSB0aGUgb3ZlcmxhcCBjYXVzZXMgWGVuIHRvIHJlamVjdCB0aGUga2V4ZWNfbG9hZC4K
PiAKPiBCZSBtb3JlIGNhcmVmdWwgYW5kIGp1c3QgaW5maWxsIHRoZSByYW5nZXMgd2hpY2ggYXJl
IHJlcXVpcmVkIGluc3RlYWQKPiBvZiBuYcOvdmVseSBhZGRpbmcgYSBmdWxsIDAtMU1pQiBzZWdt
ZW50IGF0IHRoZSBlbmQgb2YgdGhlIGxpc3QuCj4gCj4gU2lnbmVkLW9mZi1ieTogRGF2aWQgV29v
ZGhvdXNlIDxkd213QGFtYXpvbi5jby51az4KClRoYW5rcyBEYXZpZCwKCmFwcGxpZWQuCgpfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwprZXhlYyBtYWlsaW5n
IGxpc3QKa2V4ZWNAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9y
Zy9tYWlsbWFuL2xpc3RpbmZvL2tleGVjCg==
