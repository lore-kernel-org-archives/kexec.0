Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Date: Tue, 25 Aug 2015 16:52:58 +0200
From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [V3 PATCH 3/4] kexec: Fix race between panic() and crash_kexec()
 called directly
Message-ID: <20150825145258.GS16853@twins.programming.kicks-ass.net>
References: <20150806054543.25766.29590.stgit@softrs>
 <20150806054543.25766.5914.stgit@softrs>
 <20150820230845.GF3161@worktop.event.rightround.com>
 <04EAB7311EE43145B2D3536183D1A8445493C868@GSjpTKYDCembx31.service.hitachi.net>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <04EAB7311EE43145B2D3536183D1A8445493C868@GSjpTKYDCembx31.service.hitachi.net>
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
Cc: "x86@kernel.org" <x86@kernel.org>, Jonathan Corbet <corbet@lwn.net>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Michal Hocko <mhocko@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, "Eric W. Biederman" <ebiederm@xmission.com>, "H. Peter Anvin" <hpa@zytor.com>, =?utf-8?B?5bmz5p2+6ZuF5bezIC8gSElSQU1BVFXvvIxNQVNBTUk=?= <masami.hiramatsu.pt@hitachi.com>, Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>, Vivek Goyal <vgoyal@redhat.com>

T24gU2F0LCBBdWcgMjIsIDIwMTUgYXQgMDI6MzU6MjRBTSArMDAwMCwg5rKz5ZCI6Iux5a6PIC8g
S0FXQUnvvIxISURFSElSTyB3cm90ZToKPiA+IEZyb206IFBldGVyIFppamxzdHJhIFttYWlsdG86
cGV0ZXJ6QGluZnJhZGVhZC5vcmddCj4gPiAKPiA+IE9uIFRodSwgQXVnIDA2LCAyMDE1IGF0IDAy
OjQ1OjQzUE0gKzA5MDAsIEhpZGVoaXJvIEthd2FpIHdyb3RlOgo+ID4gPiAgdm9pZCBjcmFzaF9r
ZXhlYyhzdHJ1Y3QgcHRfcmVncyAqcmVncykKPiA+ID4gIHsKPiA+ID4gKwlpbnQgb2xkX2NwdSwg
dGhpc19jcHU7Cj4gPiA+ICsKPiA+ID4gKwkvKgo+ID4gPiArCSAqIGBvbGRfY3B1ID09IC0xJyBt
ZWFucyB3ZSBhcmUgdGhlIGZpcnN0IGNvbWVyIGFuZCBjcmFzaF9rZXhlYygpCj4gPiA+ICsJICog
d2FzIGNhbGxlZCB3aXRob3V0IGVudGVyaW5nIHBhbmljKCkuCj4gPiA+ICsJICogYG9sZF9jcHUg
PT0gdGhpc19jcHUnIG1lYW5zIGNyYXNoX2tleGVjKCkgd2FzIGNhbGxlZCBmcm9tIHBhbmljKCku
Cj4gPiA+ICsJICovCj4gPiA+ICsJdGhpc19jcHUgPSByYXdfc21wX3Byb2Nlc3Nvcl9pZCgpOwo+
ID4gPiArCW9sZF9jcHUgPSBhdG9taWNfY21weGNoZygmcGFuaWNfY3B1LCAtMSwgdGhpc19jcHUp
Owo+ID4gPiArCWlmIChvbGRfY3B1ICE9IC0xICYmIG9sZF9jcHUgIT0gdGhpc19jcHUpCj4gPiA+
ICsJCXJldHVybjsKPiA+IAo+ID4gVGhpcyBhbGxvd3MgcmVjdXJzaXZlIGNhbGxpbmcgb2YgY3Jh
c2hfa2V4ZWMoKSwgdGhlIENoYW5nZWxvZyBkaWQgbm90Cj4gPiBtZW50aW9uIHRoYXQuIElzIHRo
aXMgcmVhbGx5IHJlcXVpcmVkPwo+IAo+IFdoYXQgcGFydCBhcmUgeW91IGFyZ3Vpbmc/ICBSZWN1
cnNpdmUgY2FsbCBvZiBjcmFzaF9rZXhlYygpIGRvZXNuJ3QKPiBoYXBwZW4uICBJbiB0aGUgZmly
c3QgcGxhY2UsIG9uZSBvZiB0aGUgcHVycG9zZSBvZiB0aGlzIHBhdGNoIGlzCj4gdG8gcHJldmVu
dCBhIHJlY3Vyc2l2ZSBjYWxsIG9mIGNyYXNoX2tleGVjKCkgaW4gdGhlIGZvbGxvd2luZyBjYXNl
Cj4gYXMgSSBzdGF0ZWQgaW4gdGhlIGRlc2NyaXB0aW9uOgo+IAo+IENQVSAwOgo+ICAgb29wc19l
bmQoKQo+ICAgICBjcmFzaF9rZXhlYygpCj4gICAgICAgbXV0ZXhfdHJ5bG9jaygpIC8vIGFjcXVp
cmVkCj4gICAgICAgICA8Tk1JPgo+ICAgICAgICAgaW9fY2hlY2tfZXJyb3IoKQo+ICAgICAgICAg
ICBwYW5pYygpCj4gICAgICAgICAgICAgY3Jhc2hfa2V4ZWMoKQo+ICAgICAgICAgICAgICAgbXV0
ZXhfdHJ5bG9jaygpIC8vIGZhaWxlZCB0byBhY3F1aXJlCj4gICAgICAgICAgICAgaW5maW5pdGUg
bG9vcAo+IAoKWWVzLCBidXQgd2hhdCB0byB3ZSB3YW50IHRvIGRvIHRoZXJlPyBJdCBzZWVtcyB0
byBtZSB0aGF0IGlzIHdyb25nLCB3ZQpkbyBub3Qgd2FudCB0byBsZXQgYSByZWN1cnNpdmUgY3Jh
c2hfa2V4ZWMoKSBwcm9jZWVkLgoKV2hlcmVhcyB0aGUgY29uZGl0aW9uIHlvdSBjcmVhdGVkIGV4
cGxpY2l0bHkgYWxsb3dzIHRoaXMgcmVjdXJzaW9uIGJ5CnZpcnR1ZSBvZiB0aGUgJ29sZF9jcHUg
IT0gdGhpc19jcHUnIGNoZWNrLgoKWW91IGNoYW5nZWxvZyBkb2VzIG5vdCBleHBsYWluIHdoeSB5
b3Ugd2FudCBhIHJlY3Vyc2l2ZSBjcmFzaF9rZXhlYygpLgoKPiBBbHNvLCB0aGUgbG9naWMgZG9l
c24ndCBjaGFuZ2UgZm9ybSBWMSAoYWx0aG91Z2ggdGhlIGltcGxlbWVudGF0aW9uCj4gY2hhbmdl
ZCksIHNvIEkgZGlkbid0IGFkZCBjaGFuZ2Vsb2dzIGFueSBtb3JlLgoKSSBjYW5ub3QgcmVtZW1i
ZXIgVjEsIG5vciBjYW4gYW55IHByaW9yIHBhdGNoIGJlIHJlbGV2YW50LgoKCl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmtleGVjIG1haWxpbmcgbGlzdApr
ZXhlY0BsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxt
YW4vbGlzdGluZm8va2V4ZWMK
