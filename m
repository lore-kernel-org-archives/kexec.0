Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx2.suse.de ([195.135.220.15])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bXTg0-0000An-0Q
 for kexec@lists.infradead.org; Wed, 10 Aug 2016 13:36:08 +0000
Message-ID: <1470836145.3194.31.camel@suse.de>
Subject: Re: [PATCH 3/3] close_dump_bitmap: simplify logic
From: Martin Wilck <mwilck@suse.de>
Date: Wed, 10 Aug 2016 15:35:45 +0200
In-Reply-To: <20160810150846.6a257447@hananiah.suse.cz>
References: <20160810125658.23366-1-mwilck@suse.de>
 <20160810125658.23366-4-mwilck@suse.de>
 <20160810150846.6a257447@hananiah.suse.cz>
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
To: Petr Tesarik <ptesarik@suse.cz>
Cc: ats-kumagai@wm.jp.nec.com, kexec@lists.infradead.org

T24gV2VkLCAyMDE2LTA4LTEwIGF0IDE1OjA4ICswMjAwLCBQZXRyIFRlc2FyaWsgd3JvdGU6Cj4g
T24gV2VkLCAxMCBBdWcgMjAxNiAxNDo1Njo1OCArMDIwMAo+IE1hcnRpbiBXaWxjayA8bXdpbGNr
QHN1c2UuZGU+IHdyb3RlOgo+IAo+ID4gVGhlIGJvb2xlYW4gZXhwcmVzc2lvbiByZXBsaWNhdGVz
IHRoZSBsb2dpYyBvZiBvcGVuX2R1bXBfYml0bWFwKCkuCj4gPiBJdCdzIHNpbXBsZXIgYW5kIGxl
c3MgZXJyb3ItcHJvbmUgdG8gc2ltcGx5IGNoZWNrIGlmIGZkX2JpdG1hcCBpcwo+ID4gdmFsaWQu
Cj4gPiAKPiA+IFNpZ25lZC1vZmYtYnk6IE1hcnRpbiBXaWxjayA8bXdpbGNrQHN1c2UuZGU+Cj4g
PiAtLS0KPiA+IMKgbWFrZWR1bXBmaWxlLmMgfCAzICstLQo+ID4gwqAxIGZpbGUgY2hhbmdlZCwg
MSBpbnNlcnRpb24oKyksIDIgZGVsZXRpb25zKC0pCj4gPiAKPiA+IGRpZmYgLS1naXQgYS9tYWtl
ZHVtcGZpbGUuYyBiL21ha2VkdW1wZmlsZS5jCj4gPiBpbmRleCA0MzI3OGYxLi43NzFhYjdjIDEw
MDY0NAo+ID4gLS0tIGEvbWFrZWR1bXBmaWxlLmMKPiA+ICsrKyBiL21ha2VkdW1wZmlsZS5jCj4g
PiBAQCAtODU3OSw4ICs4NTc5LDcgQEAgY2xvc2VfZHVtcF9maWxlKHZvaWQpCj4gPiDCoHZvaWQK
PiA+IMKgY2xvc2VfZHVtcF9iaXRtYXAodm9pZCkKPiA+IMKgewo+ID4gLQlpZiAoIWluZm8tPndv
cmtpbmdfZGlyICYmICFpbmZvLT5mbGFnX3JlYXNzZW1ibGUgJiYgIWluZm8tCj4gPiA+ZmxhZ19y
ZWZpbHRlcmluZwo+ID4gLQnCoMKgwqDCoCYmICFpbmZvLT5mbGFnX3NhZHVtcCAmJiAhaW5mby0+
ZmxhZ19tZW1fdXNhZ2UpCj4gPiArCWlmICghaW5mby0+ZmRfYml0bWFwKQo+IAo+IFN0cmljdGx5
IHNwZWFraW5nLCB6ZXJvIGlzIGEgdmFsaWQgRkQuIEkgY2FuIHNlZSB0aGF0IGl0IGlzIGhpZ2hs
eQo+IHVubGlrZWx5IHRvIGJlIHRoZSBiaXRtYXAgRkQsIGJ1dCBpdCB3b3VsZCBiZSBhIG5pY2Ug
Y2xlYW51cCB0bwo+IGluaXRpYWxpemUgZmRfYml0bWFwIHRvIGEgbmVnYXRpdmUgbnVtYmVyIGFu
ZCBjaGVjayBpbmZvLT5mZF9iaXRtYXAgPAo+IDAuCj4gSSdtIGp1c3Qgbm90IHN1cmUgd2hlcmUg
dG8gcHV0IHRoZSBpbml0aWFsaXppdGlvbi4uLgoKCj4gPiBPVE9IIEkga25vdyBJJ20gYXNraW5n
IHlvdSB0byBmaXggc29tZXRoaW5nIHRoYXQgeW91IGRpZG4ndCBicmVhay4KCkkgaGFkIHRoZSBz
YW1lIHRob3VnaHQsIGFuZCB0aGUgc2FtZSBleGN1c2Ugbm90IHRvIGFkZHJlc3MgaXQgaW4gdGhp
cwpwYXRjaCBzZXQuIElmIHlvdSBncmVwIG1ha2VkdW1wZmlsZS5jIGZvciAiZmRfYml0bWFwIiwg
eW91J2xsIHNlZSBtYW55CmNoZWNrcyBsaWtlICJpZiAoaW5mby0+ZmRfYml0bWFwKSIuIEkganVz
dCBmb2xsb3dlZCB0aGF0IHBhdHRlcm4gZm9yCm5vdy4KCk1hcnRpbgoKX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18Ka2V4ZWMgbWFpbGluZyBsaXN0CmtleGVj
QGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9s
aXN0aW5mby9rZXhlYwo=
