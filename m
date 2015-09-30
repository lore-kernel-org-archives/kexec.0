Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Date: Wed, 30 Sep 2015 13:53:47 +0200
From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: Re: [V4 PATCH 3/4] kexec: Fix race between panic() and
 crash_kexec() called directly
Message-ID: <20150930115347.GH2881@worktop.programming.kicks-ass.net>
References: <20150925112809.4258.39950.stgit@softrs>
 <201509281128.r1CboaDC%fengguang.wu@intel.com>
 <04EAB7311EE43145B2D3536183D1A84454994C26@GSjpTKYDCembx31.service.hitachi.net>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <04EAB7311EE43145B2D3536183D1A84454994C26@GSjpTKYDCembx31.service.hitachi.net>
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
Cc: "x86@kernel.org" <x86@kernel.org>, Jonathan Corbet <corbet@lwn.net>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Michal Hocko <mhocko@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, "Eric W. Biederman" <ebiederm@xmission.com>, "H. Peter Anvin" <hpa@zytor.com>, =?utf-8?B?5bmz5p2+6ZuF5bezIC8gSElSQU1BVFXvvIxNQVNBTUk=?= <masami.hiramatsu.pt@hitachi.com>, Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>, Vivek Goyal <vgoyal@redhat.com>, "kbuild-all@01.org" <kbuild-all@01.org>

T24gTW9uLCBTZXAgMjgsIDIwMTUgYXQgMDc6MDg6MTlBTSArMDAwMCwg5rKz5ZCI6Iux5a6PIC8g
S0FXQUnvvIxISURFSElSTyB3cm90ZToKPiA+ID4+IGtlcm5lbC9rZXhlY19jb3JlLmM6ODk5OjM6
IG5vdGU6IGluIGV4cGFuc2lvbiBvZiBtYWNybyAnYXRvbWljX3hjaGcnCj4gPiAgICAgICBhdG9t
aWNfeGNoZygmcGFuaWNfY3B1LCAtMSk7Cj4gPiAgICAgICBeCj4gCj4gSSBjaGFuZ2VkIHRvIHVz
ZSBhdG9taWNfeGNoZygpIGluc3RlYWQgb2YgYXRvbWljX3NldCgpIGluIFYzCj4gYmVjYXVzZSBh
dG9taWNfc2V0KCkgZG9lc24ndCBtZWFuIG1lbW9yeSBiYXJyaWVyLiAgSG93ZXZlciwKPiBJIHRo
b3VnaHQgYWdhaW4gYW5kIHRoZXJlIGlzIG5vIG5lZWQgb2YgYmFycmllcjsgdGhlcmUgaXMgbm8K
PiBwcm9ibGVtIGlmIGEgY29tcGV0aXRvciBzZWVzIG9sZCB2YWx1ZSBvZiBwYW5pY19jcHUgb3Ig
bmV3IG9uZS4KPiBTbywgYXRvbWljX3NldCgpIGlzIHN1ZmZpY2llbnQgYW5kIHVzaW5nIGl0IHdp
bGwgcmVtb3ZlIHRoaXMgd2FybmluZy4KPiAKPiBJIHdpbGwgcmVzZW5kIHRoZSBmaXhlZCB2ZXJz
aW9uIGxhdGVyLgoKU28gaWYgeW91IHJlbHkgb24gdGhlIG1lbW9yeSBiYXJyaWVyOyB5b3Ugc2hv
dWxkIGhhdmUgYWxzbyBwdXQgYSBjb21tZW50Cm9uIGV4cGxhaW5pbmcgdGhlIG9yZGVyaW5nIHJl
cXVpcmVtZW50cy4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fCmtleGVjIG1haWxpbmcgbGlzdAprZXhlY0BsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9s
aXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8va2V4ZWMK
