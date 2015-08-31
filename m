Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail7.hitachi.co.jp ([133.145.228.42])
 by bombadil.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1ZWLqJ-0001kR-GD
 for kexec@lists.infradead.org; Mon, 31 Aug 2015 09:57:36 +0000
From: =?utf-8?B?5rKz5ZCI6Iux5a6PIC8gS0FXQUnvvIxISURFSElSTw==?=
 <hidehiro.kawai.ez@hitachi.com>
Subject: RE: [V3 PATCH 3/4] kexec: Fix race between panic() and
 crash_kexec() called directly
Date: Mon, 31 Aug 2015 09:57:11 +0000
Message-ID: <04EAB7311EE43145B2D3536183D1A84454958A58@GSjpTKYDCembx31.service.hitachi.net>
References: <20150806054543.25766.29590.stgit@softrs>
 <20150806054543.25766.5914.stgit@softrs>
 <20150820230845.GF3161@worktop.event.rightround.com>
 <04EAB7311EE43145B2D3536183D1A8445493C868@GSjpTKYDCembx31.service.hitachi.net>
 <20150825145258.GS16853@twins.programming.kicks-ass.net>
 <04EAB7311EE43145B2D3536183D1A84454951595@GSjpTKYDCembx31.service.hitachi.net>
 <04EAB7311EE43145B2D3536183D1A8445495793E@GSjpTKYDCembx31.service.hitachi.net>
 <20150831090733.GI19282@twins.programming.kicks-ass.net>
In-Reply-To: <20150831090733.GI19282@twins.programming.kicks-ass.net>
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

PiBGcm9tOiBQZXRlciBaaWpsc3RyYSBbbWFpbHRvOnBldGVyekBpbmZyYWRlYWQub3JnXQ0KPiBP
biBNb24sIEF1ZyAzMSwgMjAxNSBhdCAwODo1MzoxMUFNICswMDAwLCDmsrPlkIjoi7Hlro8gLyBL
QVdBSe+8jEhJREVISVJPIHdyb3RlOg0KPiA+ID4gSSB1bmRlcnN0YW5kIHlvdXIgcXVlc3Rpb24u
ICBJIGRvbid0IGludGVuZCB0byBwZXJtaXQgdGhlIHJlY3Vyc2l2ZQ0KPiA+ID4gY2FsbCBvZiBj
cmFzaF9rZXhlYygpIGFzIGZvciAnb2xkX2NwdSAhPSB0aGlzX2NwdScgY2hlY2suICBUaGF0IGlz
DQo+ID4gPiBuZWVkZWQgZm9yIHRoZSBjYXNlIG9mIHBhbmljKCkgLS0+IGNyYXNoX2tleGVjKCku
ICBTaW5jZSBwYW5pY19jcHUgaGFzDQo+ID4gPiBhbHJlYWR5IGJlZW4gc2V0IHRvIHRoaXNfY3B1
IGluIHBhbmljKCkgKHBsZWFzZSBzZWUgUEFUQ0ggMS80KSwgbm8gb25lDQo+ID4gPiBjYW4gcnVu
IGNyYXNoX2tleGVjKCkgd2l0aG91dCAnb2xkX2NwdSAhPSB0aGlzX2NwdScgY2hlY2suDQo+ID4g
Pg0KPiA+ID4gSWYgeW91IGRvbid0IGxpa2UgdGhpcyBjaGVjaywgSSB3b3VsZCBhbHNvIGJlIGFi
bGUgdG8gaGFuZGxlIHRoaXMgY2FzZQ0KPiA+ID4gbGlrZSBiZWxvdzoNCj4gPiA+DQo+ID4gPiBj
cmFzaF9rZXhlYygpDQo+ID4gPiB7DQo+ID4gPiAJb2xkX2NwdSA9IGF0b21pY19jbXB4Y2hnKCZw
YW5pY19jcHUsIC0xLCB0aGlzX2NwdSk7DQo+ID4gPiAJaWYgKG9sZF9jcHUgIT0gLTEpDQo+ID4g
PiAJCXJldHVybjsNCj4gPiA+DQo+ID4gPiAJX19jcmFzaF9rZXhlYygpOw0KPiA+ID4gfQ0KPiA+
ID4NCj4gPiA+IHBhbmljKCkNCj4gPiA+IHsNCj4gPiA+IAlhdG9taWNfY21weGNoZygmcGFuaWNf
Y3B1LCAtMSwgdGhpc19jcHUpOw0KPiA+ID4gCV9fY3Jhc2hfa2V4ZWMoKTsNCj4gPiA+IC4uLg0K
PiA+ID4NCj4gPg0KPiA+IElzIHRoYXQgT0s/DQo+IA0KPiBJIHN1cHBvc2Ugc28sIGJ1dCBJIHRo
aW5rIG1lIGdldHRpbmcgY29uZnVzZWQgbWVhbnMgY29tbWVudHMgY2FuIGJlDQo+IGFkZGVkL2lt
cHJvdmVkLg0KDQpPSywgSSdsbCBpbXByb3ZlIGNvbW1lbnRzIGFuZCBkZXNjcmlwdGlvbiBpbiB0
aGUgbmV4dCB2ZXJzaW9uLg0KDQpUaGFua3MhDQoNCkhpZGVoaXJvIEthd2FpDQpIaXRhY2hpLCBM
dGQuIFJlc2VhcmNoICYgRGV2ZWxvcG1lbnQgR3JvdXANCg0KX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18Ka2V4ZWMgbWFpbGluZyBsaXN0CmtleGVjQGxpc3Rz
LmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5m
by9rZXhlYwo=
