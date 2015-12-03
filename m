Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail7.hitachi.co.jp ([133.145.228.42])
 by bombadil.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1a4JDg-0000Xx-Of
 for kexec@lists.infradead.org; Thu, 03 Dec 2015 02:02:05 +0000
From: =?utf-8?B?5rKz5ZCI6Iux5a6PIC8gS0FXQUnvvIxISURFSElSTw==?=
 <hidehiro.kawai.ez@hitachi.com>
Subject: RE: [V5 PATCH 3/4] kexec: Fix race between panic() and
 crash_kexec() called directly
Date: Thu, 3 Dec 2015 02:01:38 +0000
Message-ID: <04EAB7311EE43145B2D3536183D1A84454A3CD95@GSjpTKYDCembx31.service.hitachi.net>
References: <20151120093641.4285.97253.stgit@softrs>
 <20151120093648.4285.17715.stgit@softrs> <20151125095457.GB29499@pd.tnic>
 <04EAB7311EE43145B2D3536183D1A84454A3B032@GSjpTKYDCembx31.service.hitachi.net>
 <20151202154023.GH3783@pd.tnic>
In-Reply-To: <20151202154023.GH3783@pd.tnic>
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
To: 'Borislav Petkov' <bp@alien8.de>
Cc: "x86@kernel.org" <x86@kernel.org>, Baoquan He <bhe@redhat.com>, Jonathan Corbet <corbet@lwn.net>, Peter Zijlstra <peterz@infradead.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Michal Hocko <mhocko@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, "Eric W. Biederman" <ebiederm@xmission.com>, "H. Peter Anvin" <hpa@zytor.com>, =?utf-8?B?5bmz5p2+6ZuF5bezIC8gSElSQU1BVFXvvIxNQVNBTUk=?= <masami.hiramatsu.pt@hitachi.com>, Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>, Vivek Goyal <vgoyal@redhat.com>

PiBPbiBXZWQsIERlYyAwMiwgMjAxNSBhdCAxMTo1NzozOEFNICswMDAwLCDmsrPlkIjoi7Hlro8g
LyBLQVdBSe+8jEhJREVISVJPIHdyb3RlOg0KPiA+IFdlIGNhbiBkbyBzbywgYnV0IEkgdGhpbmsg
cmVzZXR0aW5nIHBhbmljX2NwdSBhbHdheXMgd291bGQgYmUNCj4gPiBzaW1wbGVyIGFuZCBzYWZl
ci4NCg0KSSdsbCBzdGF0ZSBpbiBkZXRhaWwuDQoNCldoZW4gd2UgY2FsbCBjcmFzaF9rZXhlYygp
IHdpdGhvdXQgZW50ZXJpbmcgcGFuaWMoKSBhbmQgcmV0dXJuIGZyb20NCml0LCBwYW5pYygpIHNo
b3VsZCBiZSBjYWxsZWQgZXZlbnR1YWxseS4gIEJ1dCB0aGUgY29kZSBwYXRocyBhcmUNCmEgYml0
IGNvbXBsaWNhdGVkIGFuZCB0aGVyZSBhcmUgbWFueSBpbXBsZW1lbnRhdGlvbnMgZm9yIGVhY2gN
CmFyY2hpdGVjdHVyZS4gIFNvIG9uZSBkYXksIHRoaXMgYXNzdW1wdGlvbiBtYXkgYmUgYnJva2Vu
OyB0aGUgQ1BVDQpkb2Vzbid0IGNhbGwgcGFuaWMoKS4gIE9yIHRoZSBDUFUgbWF5IGZhaWwgdG8g
Y2FsbCBwYW5pYygpIGJlY2F1c2UNCndlIGFyZSBhbHJlYWR5IGluIGluc2FuZSBzdGF0ZS4gIEl0
IHdvdWxkIGJlIG5lcnZvdXMsIGJ1dCBhbGxvd2luZw0KYW5vdGhlciBDUFUgdG8gcHJvY2VzcyBw
YW5pYyByb3V0aW5lcyBieSByZXNldHRpbmcgcGFuaWNfY3B1DQppcyBzYWZlciBhcHByb2FjaC4N
Cg0KPiBXZWxsLCBJIHRoaW5rIGV4ZWN1dGluZyBjb2RlIG5lZWRsZXNzbHkgKmVzcGVjaWFsbHkq
IGF0IHBhbmljIHRpbWUgaXMNCj4gbm90IGFsbCB0aGF0IHJvc3kgZWl0aGVyLg0KPiANCj4gQmVz
aWRlcyBzb21ldGhpbmcgbGlrZSB0aGlzOg0KPiANCj4gCXN0YXRpYyBib29sIGtleGVjX2ZhaWxl
ZDsNCj4gDQo+IAkuLi4NCj4gDQo+ICAgICAgICAgaWYgKGNyYXNoX2tleGVjX3Bvc3Rfbm90aWZp
ZXJzICYmICFrZXhlY19mYWlsZWQpDQo+IAkJa2V4ZWNfZmFpbGVkID0gX19jcmFzaF9rZXhlYyhO
VUxMKTsNCj4gDQo+IGlzIGFzIHNpbXBsZSBhcyBpdCBnZXRzLg0KDQpTaW5jZSB0aGlzIGNvZGUg
aXMgZXhlY3V0ZWQgb25seSBvbmNlIGR1ZSB0byBwYW5pY19jcHUsDQpJIHRoaW5rIGludHJvZHVj
aW5nIHRoaXMgbG9naWMgaXMgbm90IG11Y2ggdmFsdWFibGUuDQpBbHNvLCBjdXJyZW50IGltcGxl
bWVudGF0aW9uIGlzIGFscmVhZHkgcXVpdGUgc2ltcGxlOg0KDQpwYW5pYygpDQp7DQouLi4NCglf
X2NyYXNoX2tleGVjKE5VTEwpIHsNCgkJaWYgKG11dGV4X3RyeWxvY2soJmtleGVjX211dGV4KSkg
ew0KCQkJaWYgKGtleGVjX2NyYXNoX2ltYWdlKSB7DQoJCQkJLyogZG9uJ3QgcmV0dXJuICovDQoJ
CQl9DQoJCX0NCgkJbXV0ZXhfdW5sb2NrKCZrZXhlY19tdXRleCkNCgl9DQoNCkhvdyBkbyB5b3Ug
dGhpbms/DQoNClJlZ2FyZHMsDQotLQ0KSGlkZWhpcm8gS2F3YWkNCkhpdGFjaGksIEx0ZC4gUmVz
ZWFyY2ggJiBEZXZlbG9wbWVudCBHcm91cA0KDQoNCl9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fCmtleGVjIG1haWxpbmcgbGlzdAprZXhlY0BsaXN0cy5pbmZy
YWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8va2V4
ZWMK
