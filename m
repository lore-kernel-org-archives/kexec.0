Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail4.hitachi.co.jp ([133.145.228.5])
 by bombadil.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1ZhSGW-00047R-1i
 for kexec@lists.infradead.org; Thu, 01 Oct 2015 01:02:33 +0000
From: =?utf-8?B?5rKz5ZCI6Iux5a6PIC8gS0FXQUnvvIxISURFSElSTw==?=
 <hidehiro.kawai.ez@hitachi.com>
Subject: RE: [V4 PATCH 1/4] panic/x86: Fix re-entrance problem due to panic
 on NMI
Date: Thu, 1 Oct 2015 01:02:08 +0000
Message-ID: <04EAB7311EE43145B2D3536183D1A8445499CC33@GSjpTKYDCembx31.service.hitachi.net>
References: <20150925112803.4258.94241.stgit@softrs>
 <20150925112805.4258.97380.stgit@softrs>
 <04EAB7311EE43145B2D3536183D1A8445499083F@GSjpTKYDCembx31.service.hitachi.net>
 <20150930112653.GF2881@worktop.programming.kicks-ass.net>
In-Reply-To: <20150930112653.GF2881@worktop.programming.kicks-ass.net>
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
To: 'Peter Zijlstra' <peterz@infradead.org>
Cc: "x86@kernel.org" <x86@kernel.org>, Jonathan Corbet <corbet@lwn.net>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Michal Hocko <mhocko@kernel.org>, Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, "Eric
 W. Biederman" <ebiederm@xmission.com>, "H. Peter Anvin" <hpa@zytor.com>, =?utf-8?B?5bmz5p2+6ZuF5bezIC8gSElSQU1BVFXvvIxNQVNBTUk=?= <masami.hiramatsu.pt@hitachi.com>, Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>, Vivek Goyal <vgoyal@redhat.com>

PiBPbiBGcmksIFNlcCAyNSwgMjAxNSBhdCAxMjoxMzo1NVBNICswMDAwLCDmsrPlkIjoi7Hlro8g
LyBLQVdBSe+8jEhJREVISVJPIHdyb3RlOg0KPiA+IFBldGVyIHNhaWRzIC10aXAgdHJlZSBkb2Vz
bid0IGhhdmUgcGFuaWNfb25fdW5yZWNvdmVyZWRfbm1pIGluIHRoZQ0KPiA+IHByZXZpb2l1cyBk
aXNjdXNzaW9uLCBidXQgaXQgc3RpbGwgZXhpc3RzLiAgU28sIEkgZGlkbid0IGNoYW5nZQ0KPiA+
IGFueXRoaW5nIGFib3V0IHBhbmljX29uX3VucmVjb3ZlcmVkX25taS4NCj4gPg0KPiANCj4gPiA+
IC0tLSBhL2FyY2gveDg2L2tlcm5lbC9ubWkuYw0KPiA+ID4gKysrIGIvYXJjaC94ODYva2VybmVs
L25taS5jDQo+ID4gPiBAQCAtMjMxLDcgKzIzMSw3IEBAIHZvaWQgdW5yZWdpc3Rlcl9ubWlfaGFu
ZGxlcih1bnNpZ25lZCBpbnQgdHlwZSwgY29uc3QgY2hhciAqbmFtZSkNCj4gPiA+ICAjZW5kaWYN
Cj4gPiA+DQo+ID4gPiAgCWlmIChwYW5pY19vbl91bnJlY292ZXJlZF9ubWkpDQo+ID4gPiAtCQlw
YW5pYygiTk1JOiBOb3QgY29udGludWluZyIpOw0KPiA+ID4gKwkJbm1pX3BhbmljKCJOTUk6IE5v
dCBjb250aW51aW5nIik7DQo+ID4gPg0KPiA+ID4gIAlwcl9lbWVyZygiRGF6ZWQgYW5kIGNvbmZ1
c2VkLCBidXQgdHJ5aW5nIHRvIGNvbnRpbnVlXG4iKTsNCj4gPiA+DQo+IA0KPiBJIHdhcyBsb29r
aW5nIGF0IHVucmVnaXN0ZXJfbm1pX2hhbmRsZXIoKSBiZWNhdXNlIHRoYXQncyB0aGUgZnVuY3Rp
b24NCj4gdGhlIGRpZmYgcG9pbnRzIHRvLiBUaGF0IHN0aWxsIGRvZXNuJ3QgaGF2ZSBwYW5pY19v
bl91bnJlY292ZXJlZF9ubWkuDQo+IA0KPiBJdCBsb29rcyBsaWtlIHlvdXIgZGlmZiB0b29sIGlz
ICdicm9rZW4nIGFuZCBnZW5lcmF0ZXMgbm9uc2Vuc2UgZnVuY3Rpb24NCj4gZGF0YS4NCg0KSSBo
YWQgbm90aWNlZCB0aGUgZnVuY3Rpb24gbmFtZSBpcyB3cm9uZywgYnV0IEkgZGlkbid0IGtub3cg
aG93DQpkbyBJIGZpeCB0aGF0LCBzb3JyeS4gIE5vdywgSSB1cGRhdGVkIGdpdCB0byB0aGUgbGF0
ZXN0IHZlcnNpb24NCmFuZCB0aGUgaXNzdWUgZGlzYXBwZWFyZWQuDQoNClJlZ2FyZHMsDQoNCkhp
ZGVoaXJvIEthd2FpDQpIaXRhY2hpLCBMdGQuIFJlc2VhcmNoICYgRGV2ZWxvcG1lbnQgR3JvdXAN
Cg0KDQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwprZXhl
YyBtYWlsaW5nIGxpc3QKa2V4ZWNAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5m
cmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2tleGVjCg==
