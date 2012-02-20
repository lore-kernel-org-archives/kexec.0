Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1RzHUh-0005s9-Db
 for kexec@lists.infradead.org; Mon, 20 Feb 2012 00:52:45 +0000
Received: from m2.gw.fujitsu.co.jp (unknown [10.0.50.72])
 by fgwmail5.fujitsu.co.jp (Postfix) with ESMTP id BD8943EE0C8
 for <kexec@lists.infradead.org>; Mon, 20 Feb 2012 09:52:37 +0900 (JST)
Received: from smail (m2 [127.0.0.1])
 by outgoing.m2.gw.fujitsu.co.jp (Postfix) with ESMTP id A418745DE4E
 for <kexec@lists.infradead.org>; Mon, 20 Feb 2012 09:52:37 +0900 (JST)
Received: from s2.gw.fujitsu.co.jp (s2.gw.fujitsu.co.jp [10.0.50.92])
 by m2.gw.fujitsu.co.jp (Postfix) with ESMTP id 8C08C45DE4D
 for <kexec@lists.infradead.org>; Mon, 20 Feb 2012 09:52:37 +0900 (JST)
Received: from s2.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s2.gw.fujitsu.co.jp (Postfix) with ESMTP id 7B2D71DB803A
 for <kexec@lists.infradead.org>; Mon, 20 Feb 2012 09:52:37 +0900 (JST)
Received: from m107.s.css.fujitsu.com (m107.s.css.fujitsu.com [10.240.81.147])
 by s2.gw.fujitsu.co.jp (Postfix) with ESMTP id 345BE1DB802C
 for <kexec@lists.infradead.org>; Mon, 20 Feb 2012 09:52:37 +0900 (JST)
Date: Mon, 20 Feb 2012 09:52:22 +0900 (   )
Message-Id: <20120220.095222.59660243.d.hatayama@jp.fujitsu.com>
Subject: Re: [PATCH][makedumpfile] Fix compilation error in sadump_info.h
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
In-Reply-To: <20120113065726.13214.80477.stgit@suzukikp.in.ibm.com>
References: <20120113065726.13214.80477.stgit@suzukikp.in.ibm.com>
Mime-Version: 1.0
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="iso8859-7"
Content-Transfer-Encoding: base64
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: suzuki@in.ibm.com
Cc: kexec@lists.infradead.org, tachibana@mxm.nes.nec.co.jp, nishimura@mxp.nes.nec.co.jp

RnJvbTogIlN1enVraSBLLiBQb3Vsb3NlIiA8c3V6dWtpQGluLmlibS5jb20+DQpTdWJqZWN0OiBb
UEFUQ0hdW21ha2VkdW1wZmlsZV0gRml4IGNvbXBpbGF0aW9uIGVycm9yIGluIHNhZHVtcF9pbmZv
LmgNCkRhdGU6IEZyaSwgMTMgSmFuIDIwMTIgMTI6Mjc6NTAgKzA1MzANCg0KPiBXaGlsZSBjb21w
aWxpbmcgdGhlIG1ha2VkdW1wZmlsZS0xLjQuMSBJIGdvdCB0aGUgZm9sbG93aW5nIGVycm9yIDoN
Cj4gDQo+IEluIGZpbGUgaW5jbHVkZWQgZnJvbSBtYWtlZHVtcGZpbGUuYzoyMToNCj4gc2FkdW1w
X2luZm8uaDo4NjogZXJyb3I6IGV4cGVjdGVkIGlkZW50aWZpZXIgb3IgoSiiIGJlZm9yZSChe6Ig
dG9rZW4NCj4gDQo+IA0KPiBUaGlzIHBhdGNoIGZpeGVzIHRoZSBjb21waWxhdGlvbiBlcnJvciBp
biBzYWR1bXBfaW5mby5oDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBTdXp1a2kgSy4gUG91bG9zZSA8
c3V6dWtpQGluLmlibS5jb20+DQoNCk9oLCBJIGRpZG4ndCBub3RpY2UgdGhpcyBjb21taXQuLi4g
VGhhbmtzIGZvciBmaXhpbmcuDQoNClRoYW5rcy4NCkhBVEFZQU1BLCBEYWlzdWtlDQoNCj4gLS0t
DQo+IA0KPiAgc2FkdW1wX2luZm8uaCB8ICAgIDIgKy0NCj4gIDEgZmlsZXMgY2hhbmdlZCwgMSBp
bnNlcnRpb25zKCspLCAxIGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL3NhZHVtcF9p
bmZvLmggYi9zYWR1bXBfaW5mby5oDQo+IGluZGV4IDFmNzRlZTUuLmM0ODI0YmUgMTAwNjQ0DQo+
IC0tLSBhL3NhZHVtcF9pbmZvLmgNCj4gKysrIGIvc2FkdW1wX2luZm8uaA0KPiBAQCAtODIsNyAr
ODIsNyBAQCBzdGF0aWMgaW5saW5lIGludCBzYWR1bXBfaW5pdGlhbGl6ZV9iaXRtYXBfbWVtb3J5
KHZvaWQpDQo+ICAJcmV0dXJuIEZBTFNFOw0KPiAgfQ0KPiAgDQo+IC1zdGF0aWMgaW5saW5lIGlu
dCBzYWR1bXBfbnVtX29ubGluZV9jcHVzKHZvaWQpOw0KPiArc3RhdGljIGlubGluZSBpbnQgc2Fk
dW1wX251bV9vbmxpbmVfY3B1cyh2b2lkKQ0KPiAgew0KPiAgCXJldHVybiAwOw0KPiAgfQ0KPiAN
Cj4gDQo+IF9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fDQo+
IGtleGVjIG1haWxpbmcgbGlzdA0KPiBrZXhlY0BsaXN0cy5pbmZyYWRlYWQub3JnDQo+IGh0dHA6
Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8va2V4ZWMNCl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmtleGVjIG1haWxpbmcgbGlzdApr
ZXhlY0BsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxt
YW4vbGlzdGluZm8va2V4ZWMK
