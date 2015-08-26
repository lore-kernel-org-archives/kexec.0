Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail4.hitachi.co.jp ([133.145.228.5])
 by bombadil.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1ZUR7y-00020u-UU
 for kexec@lists.infradead.org; Wed, 26 Aug 2015 03:11:56 +0000
From: =?utf-8?B?5rKz5ZCI6Iux5a6PIC8gS0FXQUnvvIxISURFSElSTw==?=
 <hidehiro.kawai.ez@hitachi.com>
Subject: RE: [V3 PATCH 3/4] kexec: Fix race between panic() and
 crash_kexec() called directly
Date: Wed, 26 Aug 2015 03:11:28 +0000
Message-ID: <04EAB7311EE43145B2D3536183D1A84454951595@GSjpTKYDCembx31.service.hitachi.net>
References: <20150806054543.25766.29590.stgit@softrs>
 <20150806054543.25766.5914.stgit@softrs>
 <20150820230845.GF3161@worktop.event.rightround.com>
 <04EAB7311EE43145B2D3536183D1A8445493C868@GSjpTKYDCembx31.service.hitachi.net>
 <20150825145258.GS16853@twins.programming.kicks-ass.net>
In-Reply-To: <20150825145258.GS16853@twins.programming.kicks-ass.net>
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
Cc: "x86@kernel.org" <x86@kernel.org>, Jonathan Corbet <corbet@lwn.net>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Michal Hocko <mhocko@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, "Eric
 W. Biederman" <ebiederm@xmission.com>, "H. Peter Anvin" <hpa@zytor.com>, =?utf-8?B?5bmz5p2+6ZuF5bezIC8gSElSQU1BVFXvvIxNQVNBTUk=?= <masami.hiramatsu.pt@hitachi.com>, Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>, Vivek Goyal <vgoyal@redhat.com>

SGksDQoNCj4gRnJvbTogUGV0ZXIgWmlqbHN0cmEgW21haWx0bzpwZXRlcnpAaW5mcmFkZWFkLm9y
Z10NCj4gDQo+IE9uIFNhdCwgQXVnIDIyLCAyMDE1IGF0IDAyOjM1OjI0QU0gKzAwMDAsIOays+WQ
iOiLseWujyAvIEtBV0FJ77yMSElERUhJUk8gd3JvdGU6DQo+ID4gPiBGcm9tOiBQZXRlciBaaWps
c3RyYSBbbWFpbHRvOnBldGVyekBpbmZyYWRlYWQub3JnXQ0KPiA+ID4NCj4gPiA+IE9uIFRodSwg
QXVnIDA2LCAyMDE1IGF0IDAyOjQ1OjQzUE0gKzA5MDAsIEhpZGVoaXJvIEthd2FpIHdyb3RlOg0K
PiA+ID4gPiAgdm9pZCBjcmFzaF9rZXhlYyhzdHJ1Y3QgcHRfcmVncyAqcmVncykNCj4gPiA+ID4g
IHsNCj4gPiA+ID4gKwlpbnQgb2xkX2NwdSwgdGhpc19jcHU7DQo+ID4gPiA+ICsNCj4gPiA+ID4g
KwkvKg0KPiA+ID4gPiArCSAqIGBvbGRfY3B1ID09IC0xJyBtZWFucyB3ZSBhcmUgdGhlIGZpcnN0
IGNvbWVyIGFuZCBjcmFzaF9rZXhlYygpDQo+ID4gPiA+ICsJICogd2FzIGNhbGxlZCB3aXRob3V0
IGVudGVyaW5nIHBhbmljKCkuDQo+ID4gPiA+ICsJICogYG9sZF9jcHUgPT0gdGhpc19jcHUnIG1l
YW5zIGNyYXNoX2tleGVjKCkgd2FzIGNhbGxlZCBmcm9tIHBhbmljKCkuDQo+ID4gPiA+ICsJICov
DQo+ID4gPiA+ICsJdGhpc19jcHUgPSByYXdfc21wX3Byb2Nlc3Nvcl9pZCgpOw0KPiA+ID4gPiAr
CW9sZF9jcHUgPSBhdG9taWNfY21weGNoZygmcGFuaWNfY3B1LCAtMSwgdGhpc19jcHUpOw0KPiA+
ID4gPiArCWlmIChvbGRfY3B1ICE9IC0xICYmIG9sZF9jcHUgIT0gdGhpc19jcHUpDQo+ID4gPiA+
ICsJCXJldHVybjsNCj4gPiA+DQo+ID4gPiBUaGlzIGFsbG93cyByZWN1cnNpdmUgY2FsbGluZyBv
ZiBjcmFzaF9rZXhlYygpLCB0aGUgQ2hhbmdlbG9nIGRpZCBub3QNCj4gPiA+IG1lbnRpb24gdGhh
dC4gSXMgdGhpcyByZWFsbHkgcmVxdWlyZWQ/DQo+ID4NCj4gPiBXaGF0IHBhcnQgYXJlIHlvdSBh
cmd1aW5nPyAgUmVjdXJzaXZlIGNhbGwgb2YgY3Jhc2hfa2V4ZWMoKSBkb2Vzbid0DQo+ID4gaGFw
cGVuLiAgSW4gdGhlIGZpcnN0IHBsYWNlLCBvbmUgb2YgdGhlIHB1cnBvc2Ugb2YgdGhpcyBwYXRj
aCBpcw0KPiA+IHRvIHByZXZlbnQgYSByZWN1cnNpdmUgY2FsbCBvZiBjcmFzaF9rZXhlYygpIGlu
IHRoZSBmb2xsb3dpbmcgY2FzZQ0KPiA+IGFzIEkgc3RhdGVkIGluIHRoZSBkZXNjcmlwdGlvbjoN
Cj4gPg0KPiA+IENQVSAwOg0KPiA+ICAgb29wc19lbmQoKQ0KPiA+ICAgICBjcmFzaF9rZXhlYygp
DQo+ID4gICAgICAgbXV0ZXhfdHJ5bG9jaygpIC8vIGFjcXVpcmVkDQo+ID4gICAgICAgICA8Tk1J
Pg0KPiA+ICAgICAgICAgaW9fY2hlY2tfZXJyb3IoKQ0KPiA+ICAgICAgICAgICBwYW5pYygpDQo+
ID4gICAgICAgICAgICAgY3Jhc2hfa2V4ZWMoKQ0KPiA+ICAgICAgICAgICAgICAgbXV0ZXhfdHJ5
bG9jaygpIC8vIGZhaWxlZCB0byBhY3F1aXJlDQo+ID4gICAgICAgICAgICAgaW5maW5pdGUgbG9v
cA0KPiA+DQo+IA0KPiBZZXMsIGJ1dCB3aGF0IHRvIHdlIHdhbnQgdG8gZG8gdGhlcmU/IEl0IHNl
ZW1zIHRvIG1lIHRoYXQgaXMgd3JvbmcsIHdlDQo+IGRvIG5vdCB3YW50IHRvIGxldCBhIHJlY3Vy
c2l2ZSBjcmFzaF9rZXhlYygpIHByb2NlZWQuDQo+IA0KPiBXaGVyZWFzIHRoZSBjb25kaXRpb24g
eW91IGNyZWF0ZWQgZXhwbGljaXRseSBhbGxvd3MgdGhpcyByZWN1cnNpb24gYnkNCj4gdmlydHVl
IG9mIHRoZSAnb2xkX2NwdSAhPSB0aGlzX2NwdScgY2hlY2suDQoNCkkgdW5kZXJzdGFuZCB5b3Vy
IHF1ZXN0aW9uLiAgSSBkb24ndCBpbnRlbmQgdG8gcGVybWl0IHRoZSByZWN1cnNpdmUNCmNhbGwg
b2YgY3Jhc2hfa2V4ZWMoKSBhcyBmb3IgJ29sZF9jcHUgIT0gdGhpc19jcHUnIGNoZWNrLiAgVGhh
dCBpcw0KbmVlZGVkIGZvciB0aGUgY2FzZSBvZiBwYW5pYygpIC0tPiBjcmFzaF9rZXhlYygpLiAg
U2luY2UgcGFuaWNfY3B1IGhhcw0KYWxyZWFkeSBiZWVuIHNldCB0byB0aGlzX2NwdSBpbiBwYW5p
YygpIChwbGVhc2Ugc2VlIFBBVENIIDEvNCksIG5vIG9uZQ0KY2FuIHJ1biBjcmFzaF9rZXhlYygp
IHdpdGhvdXQgJ29sZF9jcHUgIT0gdGhpc19jcHUnIGNoZWNrLg0KDQpJZiB5b3UgZG9uJ3QgbGlr
ZSB0aGlzIGNoZWNrLCBJIHdvdWxkIGFsc28gYmUgYWJsZSB0byBoYW5kbGUgdGhpcyBjYXNlDQps
aWtlIGJlbG93Og0KDQpjcmFzaF9rZXhlYygpDQp7DQoJb2xkX2NwdSA9IGF0b21pY19jbXB4Y2hn
KCZwYW5pY19jcHUsIC0xLCB0aGlzX2NwdSk7DQoJaWYgKG9sZF9jcHUgIT0gLTEpDQoJCXJldHVy
bjsNCg0KCV9fY3Jhc2hfa2V4ZWMoKTsNCn0NCg0KcGFuaWMoKQ0Kew0KCWF0b21pY19jbXB4Y2hn
KCZwYW5pY19jcHUsIC0xLCB0aGlzX2NwdSk7DQoJX19jcmFzaF9rZXhlYygpOw0KLi4uDQoNCg0K
UmVnYXJkcywNCg0KSGlkZWhpcm8gS2F3YWkNCkhpdGFjaGksIEx0ZC4gUmVzZWFyY2ggJiBEZXZl
bG9wbWVudCBHcm91cA0KDQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwprZXhlYyBtYWlsaW5nIGxpc3QKa2V4ZWNAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRw
Oi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2tleGVjCg==
