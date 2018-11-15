Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by merlin.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gNIMC-0003Km-EA
 for kexec@lists.infradead.org; Thu, 15 Nov 2018 14:10:57 +0000
Date: Thu, 15 Nov 2018 06:10:36 -0800
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] kexec/dt-ops.c: Fix check against 'fdt_add_subnode'
 return value
Message-ID: <20181115141036.gsva2tt2izcki72c@verge.net.au>
References: <1541968216-31282-1-git-send-email-bhsharma@redhat.com>
 <20181112022406.GZ11663@linaro.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181112022406.GZ11663@linaro.org>
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
To: AKASHI Takahiro <takahiro.akashi@linaro.org>, Bhupesh Sharma <bhsharma@redhat.com>, kexec@lists.infradead.org, bhupesh.linux@gmail.com

T24gTW9uLCBOb3YgMTIsIDIwMTggYXQgMTE6MjQ6MDdBTSArMDkwMCwgQUtBU0hJIFRha2FoaXJv
IHdyb3RlOgo+IE9uIE1vbiwgTm92IDEyLCAyMDE4IGF0IDAyOjAwOjE2QU0gKzA1MzAsIEJodXBl
c2ggU2hhcm1hIHdyb3RlOgo+ID4gVmljZW7DpyByZXBvcnRlZCAodmlhIFsxXSkgdGhhdCBjdXJy
ZW50bHkgZXhlY3V0aW5nIGtleGVjIHdpdGgKPiA+ICctLWR0Yicgb3B0aW9uIGFuZCBwYXNzaW5n
IGEgLmR0YiB3aGljaCBkb2Vzbid0IGhhdmUgYSAnL2Nob3Nlbicgbm9kZQo+ID4gbGVhZHMgdG8g
dGhlIGZvbGxvd2luZyBlcnJvcjoKPiA+IAo+ID4gICAjIGtleGVjIC1kIC0tZHRiIGR0Yl93aXRo
b3V0X2Nob3Nlbl9ub2RlLmR0YiAtLWFwcGVuZCAnY21kbGluZScgLS1sb2FkIEltYWdlCj4gPiAK
PiA+ICAgICBkdGJfc2V0X3Byb3BlcnR5OiBmZHRfYWRkX3N1Ym5vZGUgZmFpbGVkOiA8dmFsaWQg
b2Zmc2V0L2xlbmd0aD4KPiA+ICAgICBrZXhlYzogU2V0IGRldmljZSB0cmVlIGJvb3RhcmdzIGZh
aWxlZC4KPiA+IAo+ID4gVGhpcyBoYXBwZW5zIGJlY2F1c2UgY3VycmVudGx5IHdlIGNoZWNrIHRo
ZSByZXR1cm4gdmFsdWUgb2YKPiA+ICdmZHRfYWRkX3N1Ym5vZGUoKScgZnVuY3Rpb24gY2FsbCBp
biAnZHQtb3BzLmMnIGluY29ycmVjdGx5Ogo+ID4gCj4gPiAgICByZXN1bHQgPSBmZHRfYWRkX3N1
Ym5vZGUobmV3X2R0Yiwgbm9kZW9mZnNldCwgbm9kZSk7Cj4gPiAgICBpZiAocmVzdWx0KSB7Cj4g
PiAgICAJZGJncHJpbnRmKCIlczogZmR0X2FkZF9zdWJub2RlIGZhaWxlZDogJXNcbiIsIF9mdW5j
X18sCj4gPiAgICAJCWZkdF9zdHJlcnJvcihyZXN1bHQpKTsKPiA+ICAgIAlnb3RvIG9uX2Vycm9y
Owo+ID4gICAgfQo+ID4gCj4gPiBBcyB3ZSBjYW4gc2VlIGluICdmZHRfcncuYycsIGEgcG9zaXRp
dmUgcmV0dXJuIHZhbHVlIGZyb20KPiA+ICdmZHRfYWRkX3N1Ym5vZGUoKScgZnVuY3Rpb24gZG9l
c24ndCBpbmRpY2F0ZSBhbiBlcnJvci4KPiA+IAo+ID4gV2UgY2FuIHNlZSB0aGF0IHRoZSBMaW51
eCBrZXJuZWwgKHNlZSAnZHJpdmVycy9maXJtd2FyZS9lZmkvbGlic3R1Yi9mZHQuYycKPiA+IGZv
ciBleGFtcGxlKSBhbHNvIGNoZWNrcyB0aGUgJ2ZkdF9hZGRfc3Vibm9kZSgpJyBmdW5jdGlvbiBh
Z2FpbnN0IG5lZ2F0aXZlCj4gPiByZXR1cm4gdmFsdWVzIGZvciBlcnJvcnMuIFNlZSBhbiBleGFt
cGxlIGJlbG93IGZyb20gJ3VwZGF0ZV9mZHQoKScgZnVuY3Rpb24gaW4KPiA+ICdkcml2ZXJzL2Zp
cm13YXJlL2VmaS9saWJzdHViL2ZkdC5jJzoKPiA+IAo+ID4gICAgbm9kZSA9IGZkdF9hZGRfc3Vi
bm9kZShmZHQsIDAsICJjaG9zZW4iKTsKPiA+ICAgIGlmIChub2RlIDwgMCkgewo+ID4gICAgCXN0
YXR1cyA9IG5vZGU7Cj4gPiAgICAJPC4uc25pcC4uPgo+ID4gICAgCWdvdG8gZmR0X3NldF9mYWls
Owo+ID4gICAgfQo+ID4gCj4gPiBUaGlzIHBhdGNoIGZpeGVzIHRoZSBzYW1lIGluICdrZXhlYy10
b29scycuCj4gCj4gTG9va3MgZ29vZC4KPiBUaGFuayB5b3UuCj4gLVRha2FoaXJvIEFrYXNoaQoK
VGhhbmtzLCBhcHBsaWVkLgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18Ka2V4ZWMgbWFpbGluZyBsaXN0CmtleGVjQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0
cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9rZXhlYwo=
