Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail7.hitachi.co.jp ([133.145.228.42])
 by bombadil.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1ZhTFI-00035V-8b
 for kexec@lists.infradead.org; Thu, 01 Oct 2015 02:05:21 +0000
From: =?utf-8?B?5rKz5ZCI6Iux5a6PIC8gS0FXQUnvvIxISURFSElSTw==?=
 <hidehiro.kawai.ez@hitachi.com>
Subject: RE: Re: [V4 PATCH 3/4] kexec: Fix race between panic() and
 crash_kexec() called directly
Date: Thu, 1 Oct 2015 02:04:55 +0000
Message-ID: <04EAB7311EE43145B2D3536183D1A8445499CCB8@GSjpTKYDCembx31.service.hitachi.net>
References: <20150925112809.4258.39950.stgit@softrs>
 <201509281128.r1CboaDC%fengguang.wu@intel.com>
 <04EAB7311EE43145B2D3536183D1A84454994C26@GSjpTKYDCembx31.service.hitachi.net>
 <20150930115347.GH2881@worktop.programming.kicks-ass.net>
In-Reply-To: <20150930115347.GH2881@worktop.programming.kicks-ass.net>
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
Cc: "x86@kernel.org" <x86@kernel.org>, Jonathan Corbet <corbet@lwn.net>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Michal Hocko <mhocko@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, "Eric W. Biederman" <ebiederm@xmission.com>, "H. Peter Anvin" <hpa@zytor.com>, =?utf-8?B?5bmz5p2+6ZuF5bezIC8gSElSQU1BVFXvvIxNQVNBTUk=?= <masami.hiramatsu.pt@hitachi.com>, Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>, Vivek Goyal <vgoyal@redhat.com>, "kbuild-all@01.org" <kbuild-all@01.org>

PiBPbiBNb24sIFNlcCAyOCwgMjAxNSBhdCAwNzowODoxOUFNICswMDAwLCDmsrPlkIjoi7Hlro8g
LyBLQVdBSe+8jEhJREVISVJPIHdyb3RlOg0KPiA+ID4gPj4ga2VybmVsL2tleGVjX2NvcmUuYzo4
OTk6Mzogbm90ZTogaW4gZXhwYW5zaW9uIG9mIG1hY3JvICdhdG9taWNfeGNoZycNCj4gPiA+ICAg
ICAgIGF0b21pY194Y2hnKCZwYW5pY19jcHUsIC0xKTsNCj4gPiA+ICAgICAgIF4NCj4gPg0KPiA+
IEkgY2hhbmdlZCB0byB1c2UgYXRvbWljX3hjaGcoKSBpbnN0ZWFkIG9mIGF0b21pY19zZXQoKSBp
biBWMw0KPiA+IGJlY2F1c2UgYXRvbWljX3NldCgpIGRvZXNuJ3QgbWVhbiBtZW1vcnkgYmFycmll
ci4gIEhvd2V2ZXIsDQo+ID4gSSB0aG91Z2h0IGFnYWluIGFuZCB0aGVyZSBpcyBubyBuZWVkIG9m
IGJhcnJpZXI7IHRoZXJlIGlzIG5vDQo+ID4gcHJvYmxlbSBpZiBhIGNvbXBldGl0b3Igc2VlcyBv
bGQgdmFsdWUgb2YgcGFuaWNfY3B1IG9yIG5ldyBvbmUuDQo+ID4gU28sIGF0b21pY19zZXQoKSBp
cyBzdWZmaWNpZW50IGFuZCB1c2luZyBpdCB3aWxsIHJlbW92ZSB0aGlzIHdhcm5pbmcuDQo+ID4N
Cj4gPiBJIHdpbGwgcmVzZW5kIHRoZSBmaXhlZCB2ZXJzaW9uIGxhdGVyLg0KPiANCj4gU28gaWYg
eW91IHJlbHkgb24gdGhlIG1lbW9yeSBiYXJyaWVyOyB5b3Ugc2hvdWxkIGhhdmUgYWxzbyBwdXQg
YSBjb21tZW50DQo+IG9uIGV4cGxhaW5pbmcgdGhlIG9yZGVyaW5nIHJlcXVpcmVtZW50cy4NCg0K
SSBkb24ndCBpbnRlbmQgdG8gdXNlIGFuIGV4cGxpY2l0IG1lbW9yeSBiYXJyaWVyLiAgVGhlcmUg
aXMgbm8NCm1lbW9yeSBvcmRlcmluZyByZXF1aXJlbWVudCBoZXJlLiAgQWxzbywgYXRvbWljX3Nl
dCgpIHdoaWNoIHdpbGwgYmUNCnVzZWQgaW5zdGVhZCBvZiBhdG9taWNfeGNoZygpIGlzIHVzZWQg
YXMgYSBSRUxFQVNFIG9wZXJhdGlvbiwgc28NCkkgYmVsaWV2ZSB0aGVyZSBpcyBubyBwcm9ibGVt
Lg0KDQpEb2N1bWVudGF0aW9uL21lbW9yeS1iYXJyaWVycy50eHQ6DQo+IFRoZSBmb2xsb3dpbmcg
b3BlcmF0aW9ucyBhcmUgcG90ZW50aWFsIHByb2JsZW1zIGFzIHRoZXkgZG8gX25vdF8gaW1wbHkg
bWVtb3J5DQo+IGJhcnJpZXJzLCBidXQgbWlnaHQgYmUgdXNlZCBmb3IgaW1wbGVtZW50aW5nIHN1
Y2ggdGhpbmdzIGFzIFJFTEVBU0UtY2xhc3MNCj4gb3BlcmF0aW9uczoNCj4gDQo+ICAgICAgICAg
YXRvbWljX3NldCgpOw0KPiAuLi4NCg0KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18Ka2V4ZWMgbWFpbGluZyBsaXN0CmtleGVjQGxpc3RzLmluZnJhZGVhZC5v
cmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9rZXhlYwo=
