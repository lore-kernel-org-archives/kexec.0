Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1hWdVy-0007Mt-KB
 for kexec@lists.infradead.org; Fri, 31 May 2019 09:07:56 +0000
Date: Fri, 31 May 2019 11:07:46 +0200
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH 1/3] xen: Avoid overlapping segments in low memory
Message-ID: <20190531090746.ozf6kyezmj77gqyo@verge.net.au>
References: <1558423948-24583-1-git-send-email-vrd@amazon.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1558423948-24583-1-git-send-email-vrd@amazon.de>
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
To: Varad Gautam <vrd@amazon.de>
Cc: kexec@lists.infradead.org, David Woodhouse <dwmw@amazon.co.uk>

T24gVHVlLCBNYXkgMjEsIDIwMTkgYXQgMDk6MzI6MjZBTSArMDIwMCwgVmFyYWQgR2F1dGFtIHdy
b3RlOgo+IEZyb206IERhdmlkIFdvb2Rob3VzZSA8ZHdtd0BhbWF6b24uY28udWs+Cj4gCj4gVW5s
aWtlIExpbnV4IHdoaWNoIGNyZWF0ZXMgYSBmdWxsIGlkZW50aXR5IG1hcHBpbmcsIFhlbiBvbmx5
IG1hcHMgdGhvc2UKPiBzZWdtZW50cyB3aGljaCBhcmUgZXhwbGljaXRseSByZXF1ZXN0ZWQuIFRo
ZXJlZm9yZSwgeGVuX2tleGVjX2xvYWQoKQo+IHNpbGVudGx5IGFkZHMgaW4gYSBzZWdtZW50IGZy
b20gemVybyB0byAxTWlCIHRvIGVuc3VyZSB0aGF0IFZHQSBtZW1vcnkKPiBhbmQgb3RoZXIgdGhp
bmdzIGFyZSBhY2Nlc3NpYmxlLgo+IAo+IEhvd2V2ZXIsIHRoaXMgZG9lc24ndCB3b3JrIHdoZW4g
dGhlcmUgYXJlIGFscmVhZHkgc2VnbWVudHMgdG8gYmUgbG9hZGVkCj4gdW5kZXIgMU1pQiwgYmVj
YXVzZSB0aGUgb3ZlcmxhcCBjYXVzZXMgWGVuIHRvIHJlamVjdCB0aGUga2V4ZWNfbG9hZC4KPiAK
PiBCZSBtb3JlIGNhcmVmdWwgYW5kIGp1c3QgaW5maWxsIHRoZSByYW5nZXMgd2hpY2ggYXJlIHJl
cXVpcmVkIGluc3RlYWQKPiBvZiBuYcOvdmVseSBhZGRpbmcgYSBmdWxsIDAtMU1pQiBzZWdtZW50
IGF0IHRoZSBlbmQuCj4gCj4gU2lnbmVkLW9mZi1ieTogRGF2aWQgV29vZGhvdXNlIDxkd213QGFt
YXpvbi5jby51az4KClRoaXMgcGF0Y2ggYXBwZWFycyB0byBiZSBwcmVzZW50IGluIHRoZSBrZXhl
Yy10b29scyB0cmVlIGFzOgoKZWZmNTMwODk1MjNjIHhlbjogQXZvaWQgb3ZlcmxhcHBpbmcgc2Vn
bWVudHMgaW4gbG93IG1lbW9yeQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18Ka2V4ZWMgbWFpbGluZyBsaXN0CmtleGVjQGxpc3RzLmluZnJhZGVhZC5vcmcK
aHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9rZXhlYwo=
