Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from s3.sipsolutions.net ([5.9.151.49] helo=sipsolutions.net)
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1dAFfJ-0004g9-7t
 for kexec@lists.infradead.org; Mon, 15 May 2017 13:04:00 +0000
Received: by sipsolutions.net with esmtpsa
 (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.89)
 (envelope-from <benjamin@sipsolutions.net>) id 1dAFev-0000f8-FV
 for kexec@lists.infradead.org; Mon, 15 May 2017 15:03:33 +0200
Message-ID: <1494853413.3608.7.camel@sipsolutions.net>
Subject: Re: [PATCH] dracut-module-setup: Fix test for inclusion of DRM modules
From: Benjamin Berg <benjamin@sipsolutions.net>
Date: Mon, 15 May 2017 15:03:33 +0200
In-Reply-To: <20170515113140.12620-1-benjamin@sipsolutions.net>
References: <20170515113140.12620-1-benjamin@sipsolutions.net>
Mime-Version: 1.0
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
To: kexec@lists.infradead.org

U29ycnksIG9idmlvdXNseSB0aGlzIHdhcyBtZWFudCBmb3IgdGhlIGtleGVjLXRvb2xzIGxpc3Qg
aW5zdGVhZCBvZgp0aGlzIG9uZS4KCkJlbmphbWluCgpPbiBNb24sIDIwMTctMDUtMTUgYXQgMTM6
MzEgKzAyMDAsIEJlbmphbWluIEJlcmcgd3JvdGU6Cj4gRnJvbTogQmVuamFtaW4gQmVyZyA8YmJl
cmdAcmVkaGF0LmNvbT4KPiAKPiBUaGUgL3N5cy9tb2R1bGVzLyovZHJpdmVycyBzeXNmcyBlbnRy
aWVzIGRvIG5vdCBleGlzdCBhbnltb3JlIG9uCj4gbmV3ZXIKPiBrZXJuZWxzIHdoaWNoIG1lYW5z
IHRoYXQgdGhlIERSTSBtb2R1ZWxzIHdvdWxkIG5ldmVyIGJlIGluY2x1ZGVkLgo+IEluc3RlYWQg
Y2hlY2sgaWYgdGhlcmUgaXMgYW55IGRldmljZSB3aXRoIGEgImRybSIgc3lzZnMgZGlyZWN0b3J5
IHRvCj4gZGVjaWRlIG9uIHdoZXRoZXIgRFJNIG1vZHVsZXMgbmVlZCB0byBiZSBpbmNsdWRlZC4K
PiAtLS0KPiDCoGRyYWN1dC1tb2R1bGUtc2V0dXAuc2ggfCAyICstCj4gwqAxIGZpbGUgY2hhbmdl
ZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkKPiAKPiBkaWZmIC0tZ2l0IGEvZHJhY3V0
LW1vZHVsZS1zZXR1cC5zaCBiL2RyYWN1dC1tb2R1bGUtc2V0dXAuc2gKPiBpbmRleCA5Zjg4YjRl
Li44NDk1ZmQ5IDEwMDc1NQo+IC0tLSBhL2RyYWN1dC1tb2R1bGUtc2V0dXAuc2gKPiArKysgYi9k
cmFjdXQtbW9kdWxlLXNldHVwLnNoCj4gQEAgLTIwLDcgKzIwLDcgQEAgY2hlY2soKSB7Cj4gwqBk
ZXBlbmRzKCkgewo+IMKgwqDCoMKgwqBsb2NhbCBfZGVwPSJiYXNlIHNodXRkb3duIgo+IMKgCj4g
LcKgwqDCoMKgaWYgWyAtZCAvc3lzL21vZHVsZS9kcm0vZHJpdmVycyBdOyB0aGVuCj4gK8KgwqDC
oMKgaWYgWyAtbiAiJCggZmluZCAvc3lzL2RldmljZXMgLW5hbWUgZHJtICkiIF07IHRoZW4KPiDC
oMKgwqDCoMKgwqDCoMKgwqBfZGVwPSIkX2RlcCBkcm0iCj4gwqDCoMKgwqDCoGZpCj4gwqAKCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmtleGVjIG1haWxp
bmcgbGlzdAprZXhlY0BsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQu
b3JnL21haWxtYW4vbGlzdGluZm8va2V4ZWMK
