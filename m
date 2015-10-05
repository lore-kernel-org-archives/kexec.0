Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail.skyhub.de ([2a01:4f8:120:8448::d00d])
 by bombadil.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Zj2mj-00085n-5O
 for kexec@lists.infradead.org; Mon, 05 Oct 2015 10:14:21 +0000
Date: Mon, 5 Oct 2015 12:14:31 +0200
From: Borislav Petkov <bp@alien8.de>
Subject: Re: [V4 PATCH 4/4] x86/apic: Introduce noextnmi boot option
Message-ID: <20151005101431.GC23259@nazgul.tnic>
References: <20151001062733.GL2881@worktop.programming.kicks-ass.net>
 <04EAB7311EE43145B2D3536183D1A8445499D30D@GSjpTKYDCembx31.service.hitachi.net>
 <20151001084335.GA3764@pd.tnic>
 <04EAB7311EE43145B2D3536183D1A8445499DB92@GSjpTKYDCembx31.service.hitachi.net>
 <20151001110110.GA3544@pd.tnic>
 <04EAB7311EE43145B2D3536183D1A8445499ED83@GSjpTKYDCembx31.service.hitachi.net>
 <20151002074721.GA16538@pd.tnic>
 <04EAB7311EE43145B2D3536183D1A844549A4557@GSjpTKYDCembx31.service.hitachi.net>
 <20151005082704.GA23259@nazgul.tnic>
 <04EAB7311EE43145B2D3536183D1A844549A48D3@GSjpTKYDCembx31.service.hitachi.net>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <04EAB7311EE43145B2D3536183D1A844549A48D3@GSjpTKYDCembx31.service.hitachi.net>
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
Cc: "x86@kernel.org" <x86@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 'Peter Zijlstra' <peterz@infradead.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Michal Hocko <mhocko@kernel.org>, Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, "Eric W. Biederman" <ebiederm@xmission.com>, "H. Peter Anvin" <hpa@zytor.com>, =?utf-8?B?5bmz5p2+6ZuF5bezIC8gSElSQU1BVFXvvIxNQVNBTUk=?= <masami.hiramatsu.pt@hitachi.com>, Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>, Vivek Goyal <vgoyal@redhat.com>

T24gTW9uLCBPY3QgMDUsIDIwMTUgYXQgMDk6MjE6MDJBTSArMDAwMCwg5rKz5ZCI6Iux5a6PIC8g
S0FXQUnvvIxISURFSElSTyB3cm90ZToKPiBTbywgdGhlIHByb2JsZW0gZm9yIHlvdSBpcyB0aGF0
ICJub2V4dG5taSIgb3B0aW9uIGlzIHZpc2libGUgYW5kIGVmZmVjdGl2ZQo+IGluIHRoZSBmaXJz
dCBrZXJuZWwsIGlzbid0IGl0PwoKTm8sIHN1Y2ggYW4gb3B0aW9uIHNob3VsZG4ndCBleGlzdCBh
dCBhbGwuIFlvdSBzaG91bGQgYmUgcGFzc2luZwppbmZvcm1hdGlvbiAqaW4qICphKiAqZGlmZmVy
ZW50KiAqbWFubmVyKiB0byB0aGUga2R1bXAga2VybmVsIC0gbm90IHdpdGgKYSBrZXJuZWwgY29t
bWFuZCBsaW5lIG9wdGlvbi4KCkkgZ2V0IHRoZSBmZWVsaW5nIEknbSBzdGFydGluZyB0byBzb3Vu
ZCBsaWtlIGEgYnJva2VuIHJlY29yZCBvbiB0aGlzCm1haWwgdGhyZWFkLi4uIDotKAoKT25lIG90
aGVyIHRoaW5nIHdlIGNvdWxkIHByb2JhYmx5IHRyeSB0byBkbyBpcyB1c2UgYm9vdF9wYXJhbXMg
d2hpY2gKaXMsIElJVUMsIHBhc3NlZCB0byB0aGUgc2Vjb25kIGtlcm5lbC4gU28gd2UgY2FuIGFk
ZCBhbm90aGVyIGJpdCB0bwpib290X3BhcmFtcy5oZHIubG9hZGZsYWdzIG9yIHNvIGFuZCB1c2Ug
dGhhdC4gT3Igc29tZXRoaW5nIHNpbWlsYXIuCgpOb3QgcGFydGljdWxhcmx5IGNyYXp5IGFib3V0
IGl0IGJ1dCBpdCBpcyBzdGlsbCBtdWNoIGJldHRlciB0aGFuIGEKY29tbWFuZCBsaW5lIHBhcmFt
Li4uCgotLSAKUmVnYXJkcy9HcnVzcywKICAgIEJvcmlzLgoKRUNPIHRpcCAjMTAxOiBUcmltIHlv
dXIgbWFpbHMgd2hlbiB5b3UgcmVwbHkuCi0tCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwprZXhlYyBtYWlsaW5nIGxpc3QKa2V4ZWNAbGlzdHMuaW5mcmFk
ZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2tleGVj
Cg==
