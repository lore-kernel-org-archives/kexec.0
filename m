Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Date: Thu, 1 Oct 2015 08:27:33 +0200
From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [V4 PATCH 4/4] x86/apic: Introduce noextnmi boot option
Message-ID: <20151001062733.GL2881@worktop.programming.kicks-ass.net>
References: <20150925112803.4258.94241.stgit@softrs>
 <20150925112811.4258.54494.stgit@softrs>
 <20150930115548.GI2881@worktop.programming.kicks-ass.net>
 <04EAB7311EE43145B2D3536183D1A8445499CD11@GSjpTKYDCembx31.service.hitachi.net>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <04EAB7311EE43145B2D3536183D1A8445499CD11@GSjpTKYDCembx31.service.hitachi.net>
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
Cc: "x86@kernel.org" <x86@kernel.org>, Jonathan Corbet <corbet@lwn.net>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Michal Hocko <mhocko@kernel.org>, Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, "Eric W. Biederman" <ebiederm@xmission.com>, "H. Peter Anvin" <hpa@zytor.com>, =?utf-8?B?5bmz5p2+6ZuF5bezIC8gSElSQU1BVFXvvIxNQVNBTUk=?= <masami.hiramatsu.pt@hitachi.com>, Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>, Vivek Goyal <vgoyal@redhat.com>

T24gVGh1LCBPY3QgMDEsIDIwMTUgYXQgMDI6MzM6MThBTSArMDAwMCwg5rKz5ZCI6Iux5a6PIC8g
S0FXQUnvvIxISURFSElSTyB3cm90ZToKPiA+IE9uIEZyaSwgU2VwIDI1LCAyMDE1IGF0IDA4OjI4
OjExUE0gKzA5MDAsIEhpZGVoaXJvIEthd2FpIHdyb3RlOgo+ID4gPiBUaGlzIHBhdGNoIGludHJv
ZHVjZXMgbmV3IGJvb3Qgb3B0aW9uICJub2V4dG5taSIgd2hpY2ggZGlzYWJsZXMKPiA+ID4gZXh0
ZXJuYWwgTk1JLiAgVGhpcyBvcHRpb24gaXMgdXNlZnVsIGZvciB0aGUgZHVtcCBjYXB0dXJlIGtl
cm5lbAo+ID4gPiBzbyB0aGF0IGFuIEhBIGFwcGxpY2F0aW9uIG9yIGFkbWluaXN0cmF0b3Igd291
bGRuJ3QgbWlzdGFrZW5seQo+ID4gPiBzaG9vdCBkb3duIHRoZSBrZXJuZWwgYnkgTk1JLgo+ID4g
Cj4gPiBTbyB0aGF0IHRoZXkgY2FuIGdldCByZWFsbHkgc3R1Y2sgd2hlbiB0aGUgY3Jhc2gga2Vy
bmVsIGNyYXNoZXMsIHJpZ2h0Pwo+ID4gOy0pCj4gCj4gTm8sIGl0IGlzIGRpZmZlcmVudCBmcm9t
IG15IGludGVudGlvbi4KPiAKPiBgbWlzdGFrZW5seScgaW4gdGhlIGFib3ZlIG1lYW5zOyB0aGV5
IGlzc3VlIE5NSSBkdWUgdG8gYSBtaXNjb25jZXB0aW9uCj4gdGhhdCB0aGUgbW9uaXRvcmVkIGhv
c3QgaXMgc3R1Y2sgaW4gdGhlIDFzdCBrZXJuZWwgd2hpbGUgaXQgaXMgYWN0dWFsbHkKPiB0YWtp
bmcgYSBjcmFzaCBkdW1wIGluIHRoZSAybmQga2VybmVsLiAgVG8gYXZvaWQgdGhpcyBraW5kIG9m
IGFjY2lkZW50LAo+IHRoZXJlIGlzIGEgdG9vbCBzdWNoIGFzIGZlbmNlX2tkdW1wIHdoaWNoIG5v
dGlmaWVzICJJJ20gdGFraW5nIGEgY3Jhc2gKPiBkdW1wLCBzbyBkb24ndCBzZW5kIE5NSSIgdG8g
dGhlIEhBIGNsdXN0ZXJpbmcgc29mdHdhcmUuICBIb3dldmVyLCB0aGVyZQo+IGlzIGEgdGltZSB3
aW5kb3cgYmV0d2VlbiBrZXJuZWwgcGFuaWMgYW5kIHRoZSBub3RpZmljYXRpb24uCj4gCj4gIm5v
ZXh0bm1pIiBhbGxvd3MgdXNlcnMgdG8gYXZvaWQgdGhpcyBraW5kIG9mIGFjY2lkZW50IGFsbCB0
aGUgdGltZSBvZgo+IDJuZCBrZXJuZWwuCgpZZXMgeWVzLCBJIHVuZGVyc3RhbmQuIEJ1dCBpZiB0
aGUgY3Jhc2gga2VybmVsIGFsc28gZ2V0cyBzdHVjayB0aGV5IGhhdmUKbm8gbWVhbnMgb2YgcmVj
b3ZlcnksIHJpZ2h0PyAob3RoZXIgdGhhbiBwb3dlciBjeWNsaW5nIHRoZSBoYXJkd2FyZSkKCkp1
c3QgcGxheWluZyBkZXZpbHMgYWR2b2NhdGUgaGVyZSwgSSBkb24ndCBhY3R1YWxseSBvYmplY3Qg
dG8gdGhlIHBhdGNoLgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18Ka2V4ZWMgbWFpbGluZyBsaXN0CmtleGVjQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDov
L2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9rZXhlYwo=
