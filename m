Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail.skyhub.de ([2a01:4f8:120:8448::d00d])
 by bombadil.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1a1WqG-0007AC-LP
 for kexec@lists.infradead.org; Wed, 25 Nov 2015 09:58:25 +0000
Date: Wed, 25 Nov 2015 10:57:58 +0100
From: Borislav Petkov <bp@alien8.de>
Subject: Re: [V5 PATCH 2/4] panic/x86: Allow cpus to save registers even if
 they are looping in NMI context
Message-ID: <20151125095758.GC29499@pd.tnic>
References: <20151120093641.4285.97253.stgit@softrs>
 <20151120093646.4285.62259.stgit@softrs>
 <20151124104853.GC3785@pd.tnic>
 <04EAB7311EE43145B2D3536183D1A84454A2A425@GSjpTKYDCembx31.service.hitachi.net>
 <20151125085620.GA29499@pd.tnic>
 <04EAB7311EE43145B2D3536183D1A84454A2B929@GSjpTKYDCembx31.service.hitachi.net>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <04EAB7311EE43145B2D3536183D1A84454A2B929@GSjpTKYDCembx31.service.hitachi.net>
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
Cc: "x86@kernel.org" <x86@kernel.org>, Baoquan He <bhe@redhat.com>, Jonathan Corbet <corbet@lwn.net>, Peter Zijlstra <peterz@infradead.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Michal Hocko <mhocko@kernel.org>, Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, "Eric W. Biederman" <ebiederm@xmission.com>, "H. Peter Anvin" <hpa@zytor.com>, =?utf-8?B?5bmz5p2+6ZuF5bezIC8gSElSQU1BVFXvvIxNQVNBTUk=?= <masami.hiramatsu.pt@hitachi.com>, Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>, Vivek Goyal <vgoyal@redhat.com>

T24gV2VkLCBOb3YgMjUsIDIwMTUgYXQgMDk6NDY6MzdBTSArMDAwMCwg5rKz5ZCI6Iux5a6PIC8g
S0FXQUnvvIxISURFSElSTyB3cm90ZToKPiBEb2VzICpvbGQqIGNvZGUgbWVhbiB0aGUgY29kZSB3
aXRob3V0IHRoaXMgcGF0Y2ggKnNlcmllcyogPwoKWWVzLgoKPiBJIHByZWZlciB0aGlzLCBidXQg
d2UgbWlnaHQgd2FudCB0byBhZGQgc29tZSBtb3JlIHByZWZpeCBvciBzdWZmaXguCj4gRm9yIGV4
YW1wbGUsICJjb25kaXRpb25hbGx5X3J1bl9jcmFzaF9ubWlfY2FsbGJhY2siLgoKVGhhdCdzIHVu
bmVjZXNzYXJ5IElNTy4gSWYgeW91IG5lZWQgdG8gZXhwcmVzcyB0aGF0LCB5b3UgY291bGQgd3Jp
dGUKdGhhdCBpbiBhIGNvbW1lbnQgYWJvdmUgdGhlIGZ1bmN0aW9uIGRlZmluaXRpb24uIEFueW9u
ZSB3aG8gbG9va3MgYXQKdGhlIGNvZGUgdGhlbiB3aWxsIGtub3cgdGhhdCBpdCBpcyBjb25kaXRp
b25hbCwgbGlrZSBzbyBtYW55IG90aGVyCmtlcm5lbCBmdW5jdGlvbnMuIDopCgo+IFRoYW5rcyBm
b3IgeW91ciBkZWVwIHJldmlldyEKClRoYW5rcyBmb3IgdGhlIHBhdGllbmNlIQoKOi0pCgotLSAK
UmVnYXJkcy9HcnVzcywKICAgIEJvcmlzLgoKRUNPIHRpcCAjMTAxOiBUcmltIHlvdXIgbWFpbHMg
d2hlbiB5b3UgcmVwbHkuCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwprZXhlYyBtYWlsaW5nIGxpc3QKa2V4ZWNAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRw
Oi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2tleGVjCg==
