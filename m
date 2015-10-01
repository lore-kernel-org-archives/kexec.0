Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail.skyhub.de ([2a01:4f8:120:8448::d00d])
 by bombadil.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1ZhbcE-0003pm-4D
 for kexec@lists.infradead.org; Thu, 01 Oct 2015 11:01:34 +0000
Date: Thu, 1 Oct 2015 13:01:10 +0200
From: Borislav Petkov <bp@alien8.de>
Subject: Re: [V4 PATCH 4/4] x86/apic: Introduce noextnmi boot option
Message-ID: <20151001110110.GA3544@pd.tnic>
References: <20150925112803.4258.94241.stgit@softrs>
 <20150925112811.4258.54494.stgit@softrs>
 <20150930115548.GI2881@worktop.programming.kicks-ass.net>
 <04EAB7311EE43145B2D3536183D1A8445499CD11@GSjpTKYDCembx31.service.hitachi.net>
 <20151001062733.GL2881@worktop.programming.kicks-ass.net>
 <04EAB7311EE43145B2D3536183D1A8445499D30D@GSjpTKYDCembx31.service.hitachi.net>
 <20151001084335.GA3764@pd.tnic>
 <04EAB7311EE43145B2D3536183D1A8445499DB92@GSjpTKYDCembx31.service.hitachi.net>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <04EAB7311EE43145B2D3536183D1A8445499DB92@GSjpTKYDCembx31.service.hitachi.net>
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

T24gVGh1LCBPY3QgMDEsIDIwMTUgYXQgMTA6MjQ6MTlBTSArMDAwMCwg5rKz5ZCI6Iux5a6PIC8g
S0FXQUnvvIxISURFSElSTyB3cm90ZToKPiBCdXQgaG93IGRvIHdlIGNoZWNrIGlmIHRoZSBzdGFy
dGluZyBrZXJuZWwgaXMgYSBkdW1wIGNhcHR1cmUga2VybmVsPwoKSG93IGRvZXMgdGhhdCBmaXJz
dCBrZXJuZWwgcGFzcyBpbmZvIHRvIHRoZSBjYXB0dXJlIGtlcm5lbD8KCj4gSSB0aGluayB1c2lu
ZyBjbWRsaW5lIG9wdGlvbiBpcyB0aGUgc2ltcGxlc3Qgd2F5LgoKTW9yZSBvZnRlbiB0aGFuIG5v
dCwgc2ltcGxlc3QgIT0gY29ycmVjdC4KCldoYXQgaGFwcGVucyBpZiBJIHBhc3MgdGhpcyBvcHRp
b24gdG8gdGhlIGZpcnN0IGtlcm5lbD8gQWxsIG9mIGEgc3VkZGVuCm15ICpmaXJzdCoga2VybmVs
IGRvZXNuJ3QgZ2V0IGV4dGVybmFsIE5NSXMuCgpEbyB5b3UgY2F0Y2ggbXkgZHJpZnQ/CgotLSAK
UmVnYXJkcy9HcnVzcywKICAgIEJvcmlzLgoKRUNPIHRpcCAjMTAxOiBUcmltIHlvdXIgbWFpbHMg
d2hlbiB5b3UgcmVwbHkuCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwprZXhlYyBtYWlsaW5nIGxpc3QKa2V4ZWNAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRw
Oi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2tleGVjCg==
