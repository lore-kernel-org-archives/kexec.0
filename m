Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail.skyhub.de ([2a01:4f8:120:8448::d00d])
 by bombadil.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Zhv4F-0005vY-EM
 for kexec@lists.infradead.org; Fri, 02 Oct 2015 07:47:48 +0000
Date: Fri, 2 Oct 2015 09:47:21 +0200
From: Borislav Petkov <bp@alien8.de>
Subject: Re: [V4 PATCH 4/4] x86/apic: Introduce noextnmi boot option
Message-ID: <20151002074721.GA16538@pd.tnic>
References: <20150925112803.4258.94241.stgit@softrs>
 <20150925112811.4258.54494.stgit@softrs>
 <20150930115548.GI2881@worktop.programming.kicks-ass.net>
 <04EAB7311EE43145B2D3536183D1A8445499CD11@GSjpTKYDCembx31.service.hitachi.net>
 <20151001062733.GL2881@worktop.programming.kicks-ass.net>
 <04EAB7311EE43145B2D3536183D1A8445499D30D@GSjpTKYDCembx31.service.hitachi.net>
 <20151001084335.GA3764@pd.tnic>
 <04EAB7311EE43145B2D3536183D1A8445499DB92@GSjpTKYDCembx31.service.hitachi.net>
 <20151001110110.GA3544@pd.tnic>
 <04EAB7311EE43145B2D3536183D1A8445499ED83@GSjpTKYDCembx31.service.hitachi.net>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <04EAB7311EE43145B2D3536183D1A8445499ED83@GSjpTKYDCembx31.service.hitachi.net>
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

T24gRnJpLCBPY3QgMDIsIDIwMTUgYXQgMTI6NTg6MDJBTSArMDAwMCwg5rKz5ZCI6Iux5a6PIC8g
S0FXQUnvvIxISURFSElSTyB3cm90ZToKPiA+IE9uIFRodSwgT2N0IDAxLCAyMDE1IGF0IDEwOjI0
OjE5QU0gKzAwMDAsIOays+WQiOiLseWujyAvIEtBV0FJ77yMSElERUhJUk8gd3JvdGU6Cj4gPiA+
IEJ1dCBob3cgZG8gd2UgY2hlY2sgaWYgdGhlIHN0YXJ0aW5nIGtlcm5lbCBpcyBhIGR1bXAgY2Fw
dHVyZSBrZXJuZWw/Cj4gPiAKPiA+IEhvdyBkb2VzIHRoYXQgZmlyc3Qga2VybmVsIHBhc3MgaW5m
byB0byB0aGUgY2FwdHVyZSBrZXJuZWw/Cj4gCj4gQXMgSSBkZXNjcmliZWQgaW4gdGhlIHByZXZp
b3VzIG1haWwsCgpJIG1lYW50OiAiSG93IGRvZXMgdGhlIGZpcnN0IGtlcm5lbCBwYXNzIGluZm8g
dG8gdGhlIGNhcHR1cmUga2VybmVsIGJ5Cipub3QqIHVzaW5nIHRoZSBrZXJuZWwgY29tbWFuZCBs
aW5lIj8KClRoZSBrZXJuZWwgY29tbWFuZCBsaW5lIGlzIG5vdCB0aGUgY2hhbm5lbCB0byBwYXNz
IGRhdGEgdG8gdGhlIGtkdW1wCmtlcm5lbC4KCj4gWWVzLCB5b3VyIGZpcnN0IGtlcm5lbCBkb2Vz
bid0IGdldCBleHRlcm5hbCBOTUlzLCBidXQgYmFzaWNhbGx5Cj4geW91IGRvbid0IGhhdmUgdG8g
c2V0ICJub2V4dG5taSIgb3B0aW9uIHRvIHRoZSBmaXJzdCBrZXJuZWwuCgpTbyBpdCBkb2Vzbid0
IGJlbG9uZyB0aGVyZSBhcyBhIGtlcm5lbCBjb21tYW5kIGxpbmUgcGFyYW1ldGVyIGluIHRoZQpm
aXJzdCBwbGFjZS4KCklPVywgeW91IG5lZWQgYSBkaWZmZXJlbnQgbWV0aG9kIHRvIHBhc3MgZGF0
YSB0byB0aGUgc2Vjb25kIGtlcm5lbC4gQmUKaXQgYW4gRUxGIGhlYWRlciwgYmUgaXQgYSBzaGFy
ZWQgcGFnZSwgd2hhdGV2ZXIuCgotLSAKUmVnYXJkcy9HcnVzcywKICAgIEJvcmlzLgoKRUNPIHRp
cCAjMTAxOiBUcmltIHlvdXIgbWFpbHMgd2hlbiB5b3UgcmVwbHkuCgpfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwprZXhlYyBtYWlsaW5nIGxpc3QKa2V4ZWNA
bGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xp
c3RpbmZvL2tleGVjCg==
