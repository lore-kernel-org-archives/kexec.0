Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo202.gate.nec.co.jp ([210.143.35.52])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bZSb8-0005YV-Ud
 for kexec@lists.infradead.org; Tue, 16 Aug 2016 00:51:20 +0000
From: Atsushi Kumagai <ats-kumagai@wm.jp.nec.com>
Subject: RE: [PATCH 3/3] close_dump_bitmap: simplify logic
Date: Tue, 16 Aug 2016 00:37:09 +0000
Message-ID: <0910DD04CBD6DE4193FCF86B9C00BE9701E5CE94@BPXM01GP.gisp.nec.co.jp>
References: <20160810125658.23366-1-mwilck@suse.de>
 <20160810125658.23366-4-mwilck@suse.de>
 <20160810150846.6a257447@hananiah.suse.cz> <1470836145.3194.31.camel@suse.de>
In-Reply-To: <1470836145.3194.31.camel@suse.de>
Content-Language: ja-JP
MIME-Version: 1.0
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
To: Martin Wilck <mwilck@suse.de>, Petr Tesarik <ptesarik@suse.cz>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>

Pj4gPiBUaGUgYm9vbGVhbiBleHByZXNzaW9uIHJlcGxpY2F0ZXMgdGhlIGxvZ2ljIG9mIG9wZW5f
ZHVtcF9iaXRtYXAoKS4NCj4+ID4gSXQncyBzaW1wbGVyIGFuZCBsZXNzIGVycm9yLXByb25lIHRv
IHNpbXBseSBjaGVjayBpZiBmZF9iaXRtYXAgaXMNCj4+ID4gdmFsaWQuDQo+PiA+DQo+PiA+IFNp
Z25lZC1vZmYtYnk6IE1hcnRpbiBXaWxjayA8bXdpbGNrQHN1c2UuZGU+DQo+PiA+IC0tLQ0KPj4g
PiDCoG1ha2VkdW1wZmlsZS5jIHwgMyArLS0NCj4+ID4gwqAxIGZpbGUgY2hhbmdlZCwgMSBpbnNl
cnRpb24oKyksIDIgZGVsZXRpb25zKC0pDQo+PiA+DQo+PiA+IGRpZmYgLS1naXQgYS9tYWtlZHVt
cGZpbGUuYyBiL21ha2VkdW1wZmlsZS5jDQo+PiA+IGluZGV4IDQzMjc4ZjEuLjc3MWFiN2MgMTAw
NjQ0DQo+PiA+IC0tLSBhL21ha2VkdW1wZmlsZS5jDQo+PiA+ICsrKyBiL21ha2VkdW1wZmlsZS5j
DQo+PiA+IEBAIC04NTc5LDggKzg1NzksNyBAQCBjbG9zZV9kdW1wX2ZpbGUodm9pZCkNCj4+ID4g
wqB2b2lkDQo+PiA+IMKgY2xvc2VfZHVtcF9iaXRtYXAodm9pZCkNCj4+ID4gwqB7DQo+PiA+IC0J
aWYgKCFpbmZvLT53b3JraW5nX2RpciAmJiAhaW5mby0+ZmxhZ19yZWFzc2VtYmxlICYmICFpbmZv
LQ0KPj4gPiA+ZmxhZ19yZWZpbHRlcmluZw0KPj4gPiAtCcKgwqDCoMKgJiYgIWluZm8tPmZsYWdf
c2FkdW1wICYmICFpbmZvLT5mbGFnX21lbV91c2FnZSkNCj4+ID4gKwlpZiAoIWluZm8tPmZkX2Jp
dG1hcCkNCj4+DQo+PiBTdHJpY3RseSBzcGVha2luZywgemVybyBpcyBhIHZhbGlkIEZELiBJIGNh
biBzZWUgdGhhdCBpdCBpcyBoaWdobHkNCj4+IHVubGlrZWx5IHRvIGJlIHRoZSBiaXRtYXAgRkQs
IGJ1dCBpdCB3b3VsZCBiZSBhIG5pY2UgY2xlYW51cCB0bw0KPj4gaW5pdGlhbGl6ZSBmZF9iaXRt
YXAgdG8gYSBuZWdhdGl2ZSBudW1iZXIgYW5kIGNoZWNrIGluZm8tPmZkX2JpdG1hcCA8DQo+PiAw
Lg0KPj4gSSdtIGp1c3Qgbm90IHN1cmUgd2hlcmUgdG8gcHV0IHRoZSBpbml0aWFsaXppdGlvbi4u
Lg0KPg0KPg0KPj4gPiBPVE9IIEkga25vdyBJJ20gYXNraW5nIHlvdSB0byBmaXggc29tZXRoaW5n
IHRoYXQgeW91IGRpZG4ndCBicmVhay4NCj4NCj5JIGhhZCB0aGUgc2FtZSB0aG91Z2h0LCBhbmQg
dGhlIHNhbWUgZXhjdXNlIG5vdCB0byBhZGRyZXNzIGl0IGluIHRoaXMNCj5wYXRjaCBzZXQuIElm
IHlvdSBncmVwIG1ha2VkdW1wZmlsZS5jIGZvciAiZmRfYml0bWFwIiwgeW91J2xsIHNlZSBtYW55
DQo+Y2hlY2tzIGxpa2UgImlmIChpbmZvLT5mZF9iaXRtYXApIi4gSSBqdXN0IGZvbGxvd2VkIHRo
YXQgcGF0dGVybiBmb3INCj5ub3cuDQoNCkkgc2VlLCBpdCB3b3VsZCBiZSBiZXR0ZXIgdG8gbWFr
ZSB0aGUgY2hlY2tzIHN0cmljdCBvbiB0aGlzIG9jY2FzaW9uLg0KU28sIGNvdWxkIHlvdSB3b3Jr
IGZvciB0aGF0IGNsZWFudXAgYmVmb3JlIHlvdXIgdGhyZWUgcGF0Y2hlcyBhcyBhbg0KYWRkaXRp
b25hbCBjbGVhbnVwIHBhdGNoID8NCg0KDQpUaGFua3MsDQpBdHN1c2hpIEt1bWFnYWkNCl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmtleGVjIG1haWxpbmcg
bGlzdAprZXhlY0BsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3Jn
L21haWxtYW4vbGlzdGluZm8va2V4ZWMK
