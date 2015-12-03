Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail.skyhub.de ([2a01:4f8:120:8448::d00d])
 by bombadil.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1a4QJB-0001Yt-TY
 for kexec@lists.infradead.org; Thu, 03 Dec 2015 09:36:15 +0000
Date: Thu, 3 Dec 2015 10:35:44 +0100
From: Borislav Petkov <bp@alien8.de>
Subject: Re: [V5 PATCH 3/4] kexec: Fix race between panic() and crash_kexec()
 called directly
Message-ID: <20151203093544.GC22271@pd.tnic>
References: <20151120093641.4285.97253.stgit@softrs>
 <20151120093648.4285.17715.stgit@softrs>
 <20151125095457.GB29499@pd.tnic>
 <04EAB7311EE43145B2D3536183D1A84454A3B032@GSjpTKYDCembx31.service.hitachi.net>
 <20151202154023.GH3783@pd.tnic>
 <04EAB7311EE43145B2D3536183D1A84454A3CD95@GSjpTKYDCembx31.service.hitachi.net>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <04EAB7311EE43145B2D3536183D1A84454A3CD95@GSjpTKYDCembx31.service.hitachi.net>
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
To: =?utf-8?B?5rKz5ZCI6Iux5a6PIC8gS0FXQUnvvIxISURFSElSTw==?= <hidehiro.kawai.ez@hitachi.com>
Cc: "x86@kernel.org" <x86@kernel.org>, Baoquan He <bhe@redhat.com>, Jonathan Corbet <corbet@lwn.net>, Peter Zijlstra <peterz@infradead.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Michal Hocko <mhocko@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, "Eric W. Biederman" <ebiederm@xmission.com>, "H. Peter Anvin" <hpa@zytor.com>, =?utf-8?B?5bmz5p2+6ZuF5bezIC8gSElSQU1BVFXvvIxNQVNBTUk=?= <masami.hiramatsu.pt@hitachi.com>, Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>, Vivek Goyal <vgoyal@redhat.com>

T24gVGh1LCBEZWMgMDMsIDIwMTUgYXQgMDI6MDE6MzhBTSArMDAwMCwg5rKz5ZCI6Iux5a6PIC8g
S0FXQUnvvIxISURFSElSTyB3cm90ZToKPiA+IE9uIFdlZCwgRGVjIDAyLCAyMDE1IGF0IDExOjU3
OjM4QU0gKzAwMDAsIOays+WQiOiLseWujyAvIEtBV0FJ77yMSElERUhJUk8gd3JvdGU6Cj4gPiA+
IFdlIGNhbiBkbyBzbywgYnV0IEkgdGhpbmsgcmVzZXR0aW5nIHBhbmljX2NwdSBhbHdheXMgd291
bGQgYmUKPiA+ID4gc2ltcGxlciBhbmQgc2FmZXIuCj4gCj4gSSdsbCBzdGF0ZSBpbiBkZXRhaWwu
Cj4gCj4gV2hlbiB3ZSBjYWxsIGNyYXNoX2tleGVjKCkgd2l0aG91dCBlbnRlcmluZyBwYW5pYygp
IGFuZCByZXR1cm4gZnJvbQo+IGl0LCBwYW5pYygpIHNob3VsZCBiZSBjYWxsZWQgZXZlbnR1YWxs
eS4KCkh1aCwgdGhlIGNhbGwgY2hhaW4gaXMKCnBhbmljLT5jcmFzaF9rZXhlYwoKT3IgZG8geW91
IG1lYW4sIHdoZW4gY3Jhc2hfa2V4ZWMoKSBpcyBub3QgY2FsbGVkIGJ5IHBhbmljKCkgYnV0IGJ5
IHNvbWUKb2YgaXRzIG90aGVyIGNhbGxlcnM/Cgo+IEJ1dCB0aGUgY29kZSBwYXRocyBhcmUgYSBi
aXQgY29tcGxpY2F0ZWQgYW5kIHRoZXJlIGFyZSBtYW55Cj4gaW1wbGVtZW50YXRpb25zIGZvciBl
YWNoIGFyY2hpdGVjdHVyZS4gU28gb25lIGRheSwgdGhpcyBhc3N1bXB0aW9uIG1heQo+IGJlIGJy
b2tlbjsgdGhlIENQVSBkb2Vzbid0IGNhbGwgcGFuaWMoKS4gT3IgdGhlIENQVSBtYXkgZmFpbCB0
byBjYWxsCj4gcGFuaWMoKSBiZWNhdXNlIHdlIGFyZSBhbHJlYWR5IGluIGluc2FuZSBzdGF0ZS4g
SXQgd291bGQgYmUgbmVydm91cywKPiBidXQgYWxsb3dpbmcgYW5vdGhlciBDUFUgdG8gcHJvY2Vz
cyBwYW5pYyByb3V0aW5lcyBieSByZXNldHRpbmcKPiBwYW5pY19jcHUgaXMgc2FmZXIgYXBwcm9h
Y2guCgpNeSBzdWdnZXN0aW9uIHdhcyB0byBkbyB0aGlzIG9ubHkgb24gdGhlIHBhbmljIHBhdGgg
LSBub3QgbmVjZXNzYXJpbHkgb24KdGhlIG90aGVycy4KCj4gU2luY2UgdGhpcyBjb2RlIGlzIGV4
ZWN1dGVkIG9ubHkgb25jZSBkdWUgdG8gcGFuaWNfY3B1LAo+IEkgdGhpbmsgaW50cm9kdWNpbmcg
dGhpcyBsb2dpYyBpcyBub3QgbXVjaCB2YWx1YWJsZS4KPiBBbHNvLCBjdXJyZW50IGltcGxlbWVu
dGF0aW9uIGlzIGFscmVhZHkgcXVpdGUgc2ltcGxlOgo+IAo+IHBhbmljKCkKPiB7Cj4gLi4uCj4g
CV9fY3Jhc2hfa2V4ZWMoTlVMTCkgewo+IAkJaWYgKG11dGV4X3RyeWxvY2soJmtleGVjX211dGV4
KSkgewo+IAkJCWlmIChrZXhlY19jcmFzaF9pbWFnZSkgewo+IAkJCQkvKiBkb24ndCByZXR1cm4g
Ki8KPiAJCQl9CgpJIGRvbid0IG1lYW4gdGhlIGtleGVjX2NyYXNoX2ltYWdlIGNhc2UgLSBJIG1l
YW4gdGhlIG9wcG9zaXRlIG9uZToKIWtleGVjX2NyYXNoX2ltYWdlLiBBbmQgSSB0aGluayBJIGtu
b3cgbm93IHdoYXQgeW91J3JlIHRyeWluZyB0byB0ZWxsCm1lOiB0aGUgZmlyc3QgQ1BVIHdoaWNo
IGhpdHMgcGFuaWMsIHdpbGwgZmluaXNoIHBhbmljIGV2ZW50dWFsbHkgYW5kIHNvCml0IHdpbGwg
dGFrZSBkb3duIHRoZSBtYWNoaW5lLgoKRXZlcnkgb3RoZXIgQ1BVIHdoaWNoIGhhcHBlbnMgdG8g
ZW50ZXIgcGFuaWMgaW4gYmV0d2VlbiB0aGUgZmlyc3QgQ1BVCmFuZCB0aGUgbWFjaGluZSBiZWlu
ZyB0YWtlbiBkb3duLCBkb2Vzbid0IG1hdHRlciBiZWNhdXNlLCB3ZWxsLCB3aG8KY2FyZXMsIHdl
J3JlIHBhbmlja2luZyBhbHJlYWR5LgoKQW0gSSBjbG9zZT8KCi0tIApSZWdhcmRzL0dydXNzLAog
ICAgQm9yaXMuCgpFQ08gdGlwICMxMDE6IFRyaW0geW91ciBtYWlscyB3aGVuIHlvdSByZXBseS4K
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmtleGVjIG1h
aWxpbmcgbGlzdAprZXhlY0BsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRl
YWQub3JnL21haWxtYW4vbGlzdGluZm8va2V4ZWMK
