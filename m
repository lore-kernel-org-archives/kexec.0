Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from smtp-fw-4101.amazon.com ([72.21.198.25])
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1hfUEX-0006vg-VN
 for kexec@lists.infradead.org; Mon, 24 Jun 2019 19:02:31 +0000
Subject: Re: [PATCH 1/3] xen: Avoid overlapping segments in low memory
References: <1558423948-24583-1-git-send-email-vrd@amazon.de>
 <20190531090746.ozf6kyezmj77gqyo@verge.net.au>
From: <vrd@amazon.com>
Message-ID: <38c53c73-30ad-0985-c08b-6b29b4ab8698@amazon.com>
Date: Mon, 24 Jun 2019 21:02:21 +0200
MIME-Version: 1.0
In-Reply-To: <20190531090746.ozf6kyezmj77gqyo@verge.net.au>
Content-Language: en-US
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Simon Horman <horms@verge.net.au>, Varad Gautam <vrd@amazon.de>
Cc: kexec@lists.infradead.org, David Woodhouse <dwmw@amazon.co.uk>

T24gNS8zMS8xOSAxMTowNyBBTSwgU2ltb24gSG9ybWFuIHdyb3RlOgo+IE9uIFR1ZSwgTWF5IDIx
LCAyMDE5IGF0IDA5OjMyOjI2QU0gKzAyMDAsIFZhcmFkIEdhdXRhbSB3cm90ZToKPj4gRnJvbTog
RGF2aWQgV29vZGhvdXNlIDxkd213QGFtYXpvbi5jby51az4KPj4KPj4gVW5saWtlIExpbnV4IHdo
aWNoIGNyZWF0ZXMgYSBmdWxsIGlkZW50aXR5IG1hcHBpbmcsIFhlbiBvbmx5IG1hcHMgdGhvc2UK
Pj4gc2VnbWVudHMgd2hpY2ggYXJlIGV4cGxpY2l0bHkgcmVxdWVzdGVkLiBUaGVyZWZvcmUsIHhl
bl9rZXhlY19sb2FkKCkKPj4gc2lsZW50bHkgYWRkcyBpbiBhIHNlZ21lbnQgZnJvbSB6ZXJvIHRv
IDFNaUIgdG8gZW5zdXJlIHRoYXQgVkdBIG1lbW9yeQo+PiBhbmQgb3RoZXIgdGhpbmdzIGFyZSBh
Y2Nlc3NpYmxlLgo+Pgo+PiBIb3dldmVyLCB0aGlzIGRvZXNuJ3Qgd29yayB3aGVuIHRoZXJlIGFy
ZSBhbHJlYWR5IHNlZ21lbnRzIHRvIGJlIGxvYWRlZAo+PiB1bmRlciAxTWlCLCBiZWNhdXNlIHRo
ZSBvdmVybGFwIGNhdXNlcyBYZW4gdG8gcmVqZWN0IHRoZSBrZXhlY19sb2FkLgo+Pgo+PiBCZSBt
b3JlIGNhcmVmdWwgYW5kIGp1c3QgaW5maWxsIHRoZSByYW5nZXMgd2hpY2ggYXJlIHJlcXVpcmVk
IGluc3RlYWQKPj4gb2YgbmHDr3ZlbHkgYWRkaW5nIGEgZnVsbCAwLTFNaUIgc2VnbWVudCBhdCB0
aGUgZW5kLgo+Pgo+PiBTaWduZWQtb2ZmLWJ5OiBEYXZpZCBXb29kaG91c2UgPGR3bXdAYW1hem9u
LmNvLnVrPgo+IFRoaXMgcGF0Y2ggYXBwZWFycyB0byBiZSBwcmVzZW50IGluIHRoZSBrZXhlYy10
b29scyB0cmVlIGFzOgo+Cj4gZWZmNTMwODk1MjNjIHhlbjogQXZvaWQgb3ZlcmxhcHBpbmcgc2Vn
bWVudHMgaW4gbG93IG1lbW9yeQoKQWgsIHBsZWFzZSBpZ25vcmUgdGhpcyBvbmUuIEkgaGFkIGFu
IGVhcmxpZXIgY2hlY2tvdXQuCgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18Ka2V4ZWMgbWFpbGluZyBsaXN0CmtleGVjQGxpc3RzLmluZnJhZGVhZC5vcmcK
aHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9rZXhlYwo=
