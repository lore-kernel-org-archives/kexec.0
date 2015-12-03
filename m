Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail.skyhub.de ([2a01:4f8:120:8448::d00d])
 by bombadil.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1a4SuN-0000rY-RG
 for kexec@lists.infradead.org; Thu, 03 Dec 2015 12:22:49 +0000
Date: Thu, 3 Dec 2015 13:22:20 +0100
From: Borislav Petkov <bp@alien8.de>
Subject: Re: [V5 PATCH 3/4] kexec: Fix race between panic() and crash_kexec()
 called directly
Message-ID: <20151203122220.GA3213@pd.tnic>
References: <20151120093641.4285.97253.stgit@softrs>
 <20151120093648.4285.17715.stgit@softrs>
 <20151125095457.GB29499@pd.tnic>
 <04EAB7311EE43145B2D3536183D1A84454A3B032@GSjpTKYDCembx31.service.hitachi.net>
 <20151202154023.GH3783@pd.tnic>
 <04EAB7311EE43145B2D3536183D1A84454A3CD95@GSjpTKYDCembx31.service.hitachi.net>
 <20151203093544.GC22271@pd.tnic>
 <04EAB7311EE43145B2D3536183D1A84454A3DF12@GSjpTKYDCembx31.service.hitachi.net>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <04EAB7311EE43145B2D3536183D1A84454A3DF12@GSjpTKYDCembx31.service.hitachi.net>
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

T24gVGh1LCBEZWMgMDMsIDIwMTUgYXQgMTE6Mjk6MjFBTSArMDAwMCwg5rKz5ZCI6Iux5a6PIC8g
S0FXQUnvvIxISURFSElSTyB3cm90ZToKPiBJIHdhcyBhcmd1aW5nIGFib3V0IHRoZSBjYXNlIG9m
IG9vcHNfZW5kIC0tPiBjcmFzaF9rZXhlYwo+IC0tPiByZXR1cm4gZnJvbSBjcmFzaF9rZXhlYyBi
ZWNhdXNlIG9mICFrZXhlY19jcmFzaF9pbWFnZSAtLT4KPiBwYW5pYy4KCkFoYS4KCj4gSW4gdGhl
IGNhc2Ugb2YgcGFuaWMgLS0+IF9fY3Jhc2hfa2V4ZWMsIF9fY3Jhc2hfa2V4ZWMgaXMgY2FsbGVk
Cj4gb25seSBvbmNlLCBzbyB3ZSBkb24ndCBuZWVkIHRvIGNoZWNrIHRoZSByZXR1cm4gdmFsdWUg
b2YgX19jcmFzaF9rZXhlYwo+IGFzIHlvdSBzdWdnZXN0ZWQuICBTbyBJIHRob3VnaHQgeW91IHN0
YXRlZCBhYm91dCBjcmFzaF9rZXhlYyAtLT4gcGFuaWMKPiBjYXNlLgoKTm8sIEkgbWVhbnQgdGhl
IG90aGVyIHdheSBhcm91bmQuCgo+IEkgYWxzbyBtZW50aW9uZWQgIWtleGVjX2NyYXNoX2ltYWdl
IGNhc2UuLi4KCkkgbXVzdCd2ZSBtaXNzZWQgaXQuCgo+IE5vLiAgVGhlIGZpcnN0IENQVSBjYWxs
cyBwYW5pYywgYW5kIHRoZW4gaXQgY2FsbHMgX19jcmFzaF9rZXhlYy4KPiBCZWNhdXNlIG9mICFr
ZXhlY19jcmFzaF9pbWFnZSwgaXQgcmV0dXJucyBmcm9tIF9fY3Jhc2hfa2V4ZWMgYW5kCj4gY29u
dGludWVzIHRvIHRoZSBwYW5pYyBwcm9jZWR1cmUuICBBdCB0aGUgc2FtZSB0aW1lLCBhbm90aGVy
IENQVQo+IHRyaWVzIHRvIGNhbGwgcGFuaWMoKSwgYnV0IGl0IGRvZXNuJ3QgcnVuIHRoZSBwYW5p
YyBwcm9jZWR1cmU7Cj4gcGFuaWNfY3B1IHByZXZlbnRzIHRoZSBzZWNvbmQgQ1BVIGZyb20gcnVu
bmluZyBpdC4KPgo+IFRoaXMgbWVhbnMgX19jcmFzaF9rZXhlYyBpcyBjYWxsZWQgb25seSBvbmNl
IGV2ZW4gaWYgd2UgZG9uJ3QKPiBjaGVjayB0aGUgcmV0dXJuIHZhbHVlIG9mIF9fY3Jhc2hfa2V4
ZWMuCgpJIHRoaW5rIHdlJ3JlIG9uIHRoZSBzYW1lIHBhZ2UsIGV2ZW4gaWYgd2UgZXhwcmVzcyBp
dCBkaWZmZXJlbnRseSAtIHRoZQpvdGhlciBDUFVzIGVudGVyaW5nIHBhbmljKCkgd2lsbCBsb29w
IGluIHBhbmljX3NtcF9zZWxmX3N0b3AoKSBzbyB0aGV5Cndvbid0IHJlYWNoIF9fY3Jhc2hfa2V4
ZWMoKS4KCj4gKFBsZWFzZSBub3RlIHRoYXQgY3Jhc2hfa2V4ZWMgY2FuIGJlIGNhbGxlZCBtdWx0
aXBsZSB0aW1lcyBpbiB0aGUKPiBjYXNlIG9mIG9vcHNfZW5kKCkgLS0+IGNyYXNoX2tleGVjKCku
KQoKUmlnaHQsIGFuZCB0aGF0IHdhcyB0aGUgY2FzZSB0aGF0IHdhcyBidWdnaW5nIG1lIC0gY2Fs
bGluZyBpbnRvCmNyYXNoX2tleGVjKCkgb24gbXVsdGlwbGUgQ1BVcyBidXQgaXQgaXMgYSB0cnls
b2NrIGFuZCBhIHBvaW50ZXIgdGVzdCAtCkkgZ3Vlc3MgdGhhdCdzIGRpbWluaXNoaW5nbHkgc21h
bGwgb3ZlcmhlYWQgdG8gY2FyZS4KClRoYW5rcy4KCi0tIApSZWdhcmRzL0dydXNzLAogICAgQm9y
aXMuCgpFQ08gdGlwICMxMDE6IFRyaW0geW91ciBtYWlscyB3aGVuIHlvdSByZXBseS4KCl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmtleGVjIG1haWxpbmcg
bGlzdAprZXhlY0BsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3Jn
L21haWxtYW4vbGlzdGluZm8va2V4ZWMK
