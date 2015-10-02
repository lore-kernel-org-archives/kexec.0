Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail7.hitachi.co.jp ([133.145.228.42])
 by bombadil.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1ZhogB-0003wb-I0
 for kexec@lists.infradead.org; Fri, 02 Oct 2015 00:58:32 +0000
From: =?utf-8?B?5rKz5ZCI6Iux5a6PIC8gS0FXQUnvvIxISURFSElSTw==?=
 <hidehiro.kawai.ez@hitachi.com>
Subject: RE: [V4 PATCH 4/4] x86/apic: Introduce noextnmi boot option
Date: Fri, 2 Oct 2015 00:58:02 +0000
Message-ID: <04EAB7311EE43145B2D3536183D1A8445499ED83@GSjpTKYDCembx31.service.hitachi.net>
References: <20150925112803.4258.94241.stgit@softrs>
 <20150925112811.4258.54494.stgit@softrs>
 <20150930115548.GI2881@worktop.programming.kicks-ass.net>
 <04EAB7311EE43145B2D3536183D1A8445499CD11@GSjpTKYDCembx31.service.hitachi.net>
 <20151001062733.GL2881@worktop.programming.kicks-ass.net>
 <04EAB7311EE43145B2D3536183D1A8445499D30D@GSjpTKYDCembx31.service.hitachi.net>
 <20151001084335.GA3764@pd.tnic>
 <04EAB7311EE43145B2D3536183D1A8445499DB92@GSjpTKYDCembx31.service.hitachi.net>
 <20151001110110.GA3544@pd.tnic>
In-Reply-To: <20151001110110.GA3544@pd.tnic>
Content-Language: ja-JP
MIME-Version: 1.0
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
To: 'Borislav Petkov' <bp@alien8.de>
Cc: "x86@kernel.org" <x86@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 'Peter Zijlstra' <peterz@infradead.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Michal Hocko <mhocko@kernel.org>, Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, "Eric W. Biederman" <ebiederm@xmission.com>, "H. Peter Anvin" <hpa@zytor.com>, =?utf-8?B?5bmz5p2+6ZuF5bezIC8gSElSQU1BVFXvvIxNQVNBTUk=?= <masami.hiramatsu.pt@hitachi.com>, Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>, Vivek Goyal <vgoyal@redhat.com>

PiBPbiBUaHUsIE9jdCAwMSwgMjAxNSBhdCAxMDoyNDoxOUFNICswMDAwLCDmsrPlkIjoi7Hlro8g
LyBLQVdBSe+8jEhJREVISVJPIHdyb3RlOg0KPiA+IEJ1dCBob3cgZG8gd2UgY2hlY2sgaWYgdGhl
IHN0YXJ0aW5nIGtlcm5lbCBpcyBhIGR1bXAgY2FwdHVyZSBrZXJuZWw/DQo+IA0KPiBIb3cgZG9l
cyB0aGF0IGZpcnN0IGtlcm5lbCBwYXNzIGluZm8gdG8gdGhlIGNhcHR1cmUga2VybmVsPw0KDQpB
cyBJIGRlc2NyaWJlZCBpbiB0aGUgcHJldmlvdXMgbWFpbCwgWW91IGp1c3QgaGF2ZSB0byBhZGQg
Im5vZXh0bm1pIg0KdG8gS0RVTVBfQ09NTUFORExJTkVfQVBQRU5EIGluIC9ldGMvc3lzY29uZmln
L2tkdW1wLiAgVGhlbiwgIm5vZXh0bm1pIg0Kb3B0aW9uIGlzIHBhc3NlZCB0byB0aGUgY2FwdHVy
ZSBrZXJuZWwgYnkgdGhlIGFjdGlvbiBvZiBrZXhlYyBjb21tYW5kLg0KDQpDbWRsaW5lIG9wdGlv
biBnaXZlcyB1c2VycyBmbGV4aWJpbGl0eS4gIEknbSBub3Qgc3VyZSBhbGwgdXNlcnMNCndhbnQg
dG8gZGlzYWJsZSBleHRlcm5hbCBOTUlzIGluIHRoZSAybmQga2VybmVsLg0KDQo+ID4gSSB0aGlu
ayB1c2luZyBjbWRsaW5lIG9wdGlvbiBpcyB0aGUgc2ltcGxlc3Qgd2F5Lg0KPiANCj4gTW9yZSBv
ZnRlbiB0aGFuIG5vdCwgc2ltcGxlc3QgIT0gY29ycmVjdC4NCj4gDQo+IFdoYXQgaGFwcGVucyBp
ZiBJIHBhc3MgdGhpcyBvcHRpb24gdG8gdGhlIGZpcnN0IGtlcm5lbD8gQWxsIG9mIGEgc3VkZGVu
DQo+IG15ICpmaXJzdCoga2VybmVsIGRvZXNuJ3QgZ2V0IGV4dGVybmFsIE5NSXMuDQoNClllcywg
eW91ciBmaXJzdCBrZXJuZWwgZG9lc24ndCBnZXQgZXh0ZXJuYWwgTk1JcywgYnV0IGJhc2ljYWxs
eQ0KeW91IGRvbid0IGhhdmUgdG8gc2V0ICJub2V4dG5taSIgb3B0aW9uIHRvIHRoZSBmaXJzdCBr
ZXJuZWwuDQoNCg0KSGlkZWhpcm8gS2F3YWkNCkhpdGFjaGksIEx0ZC4gUmVzZWFyY2ggJiBEZXZl
bG9wbWVudCBHcm91cA0KDQoNCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fCmtleGVjIG1haWxpbmcgbGlzdAprZXhlY0BsaXN0cy5pbmZyYWRlYWQub3JnCmh0
dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8va2V4ZWMK
