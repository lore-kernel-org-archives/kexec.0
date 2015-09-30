Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Date: Wed, 30 Sep 2015 13:26:53 +0200
From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [V4 PATCH 1/4] panic/x86: Fix re-entrance problem due to panic
 on NMI
Message-ID: <20150930112653.GF2881@worktop.programming.kicks-ass.net>
References: <20150925112803.4258.94241.stgit@softrs>
 <20150925112805.4258.97380.stgit@softrs>
 <04EAB7311EE43145B2D3536183D1A8445499083F@GSjpTKYDCembx31.service.hitachi.net>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <04EAB7311EE43145B2D3536183D1A8445499083F@GSjpTKYDCembx31.service.hitachi.net>
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

T24gRnJpLCBTZXAgMjUsIDIwMTUgYXQgMTI6MTM6NTVQTSArMDAwMCwg5rKz5ZCI6Iux5a6PIC8g
S0FXQUnvvIxISURFSElSTyB3cm90ZToKPiBQZXRlciBzYWlkcyAtdGlwIHRyZWUgZG9lc24ndCBo
YXZlIHBhbmljX29uX3VucmVjb3ZlcmVkX25taSBpbiB0aGUKPiBwcmV2aW9pdXMgZGlzY3Vzc2lv
biwgYnV0IGl0IHN0aWxsIGV4aXN0cy4gIFNvLCBJIGRpZG4ndCBjaGFuZ2UKPiBhbnl0aGluZyBh
Ym91dCBwYW5pY19vbl91bnJlY292ZXJlZF9ubWkuCj4gCgo+ID4gLS0tIGEvYXJjaC94ODYva2Vy
bmVsL25taS5jCj4gPiArKysgYi9hcmNoL3g4Ni9rZXJuZWwvbm1pLmMKPiA+IEBAIC0yMzEsNyAr
MjMxLDcgQEAgdm9pZCB1bnJlZ2lzdGVyX25taV9oYW5kbGVyKHVuc2lnbmVkIGludCB0eXBlLCBj
b25zdCBjaGFyICpuYW1lKQo+ID4gICNlbmRpZgo+ID4gCj4gPiAgCWlmIChwYW5pY19vbl91bnJl
Y292ZXJlZF9ubWkpCj4gPiAtCQlwYW5pYygiTk1JOiBOb3QgY29udGludWluZyIpOwo+ID4gKwkJ
bm1pX3BhbmljKCJOTUk6IE5vdCBjb250aW51aW5nIik7Cj4gPiAKPiA+ICAJcHJfZW1lcmcoIkRh
emVkIGFuZCBjb25mdXNlZCwgYnV0IHRyeWluZyB0byBjb250aW51ZVxuIik7Cj4gPiAKCkkgd2Fz
IGxvb2tpbmcgYXQgdW5yZWdpc3Rlcl9ubWlfaGFuZGxlcigpIGJlY2F1c2UgdGhhdCdzIHRoZSBm
dW5jdGlvbgp0aGUgZGlmZiBwb2ludHMgdG8uIFRoYXQgc3RpbGwgZG9lc24ndCBoYXZlIHBhbmlj
X29uX3VucmVjb3ZlcmVkX25taS4KCkl0IGxvb2tzIGxpa2UgeW91ciBkaWZmIHRvb2wgaXMgJ2Jy
b2tlbicgYW5kIGdlbmVyYXRlcyBub25zZW5zZSBmdW5jdGlvbgpkYXRhLgoKX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18Ka2V4ZWMgbWFpbGluZyBsaXN0Cmtl
eGVjQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1h
bi9saXN0aW5mby9rZXhlYwo=
