Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail7.hitachi.co.jp ([133.145.228.42])
 by bombadil.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Zhb2Z-0001ll-Qb
 for kexec@lists.infradead.org; Thu, 01 Oct 2015 10:24:44 +0000
From: =?utf-8?B?5rKz5ZCI6Iux5a6PIC8gS0FXQUnvvIxISURFSElSTw==?=
 <hidehiro.kawai.ez@hitachi.com>
Subject: RE: [V4 PATCH 4/4] x86/apic: Introduce noextnmi boot option
Date: Thu, 1 Oct 2015 10:24:19 +0000
Message-ID: <04EAB7311EE43145B2D3536183D1A8445499DB92@GSjpTKYDCembx31.service.hitachi.net>
References: <20150925112803.4258.94241.stgit@softrs>
 <20150925112811.4258.54494.stgit@softrs>
 <20150930115548.GI2881@worktop.programming.kicks-ass.net>
 <04EAB7311EE43145B2D3536183D1A8445499CD11@GSjpTKYDCembx31.service.hitachi.net>
 <20151001062733.GL2881@worktop.programming.kicks-ass.net>
 <04EAB7311EE43145B2D3536183D1A8445499D30D@GSjpTKYDCembx31.service.hitachi.net>
 <20151001084335.GA3764@pd.tnic>
In-Reply-To: <20151001084335.GA3764@pd.tnic>
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

PiBPbiBUaHUsIE9jdCAwMSwgMjAxNSBhdCAwNzowMTo1MEFNICswMDAwLCDmsrPlkIjoi7Hlro8g
LyBLQVdBSe+8jEhJREVISVJPIHdyb3RlOg0KPiA+IEkgc3VwcG9zZSB0aGF0IGEgc2V2ZXIgd2hp
Y2ggdXNlcyB0aGlzIGZlYXR1cmUgd2lsbCBlcXVpcCBhIEJNQw0KPiA+IGFuZCBCTUMgbWFuZGF0
b3JpbHkgc3VwcG9ydHMgaGFyZCByZXNldCBjb21tYW5kIGZvciB0aGUgc2VydmVyLg0KPiA+IElm
IHRoZSBIQSBjbHVzdGVyaW5nIHNvZnR3YXJlIGRldGVjdHMgbm8gcmVzcG9uc2UgZnJvbSB0aGUg
c2VydmVyDQo+ID4gYWZ0ZXIgcmVsYXRpdmVseSBsb25nIHRpbWVvdXQsIGl0IG1pZ2h0IHdhbnQg
dG8gaW5zZXJ0IGhhcmQgcmVzZXQNCj4gPiB0byB0aGUgc2VydmVyIGJ5IElQTUkgb3ZlciBMQU4u
DQo+IA0KPiBTbyB3aHkgZG9lc24ndCB0aGUgY2FwdHVyZSBrZXJuZWwgKmF1dG9tYXRpY2FsbHkq
IGlnbm9yZSBleHRlcm5hbCBOTUlzLA0KPiB3aXRob3V0IGEgY21kbGluZSBvcHRpb24/DQo+IA0K
PiBCZWZvcmUgaXQgc3RhcnRzIGNhcHR1cmluZywgaXQgc2F5czogIkknbSBzdGFydGluZyBjYXB0
dXJpbmcgYW5kIGFtDQo+IGlnbm9yaW5nIGV4dGVybmFsIE5NSXMgZnJvbSBub3cgb24uIg0KDQpC
dXQgaG93IGRvIHdlIGNoZWNrIGlmIHRoZSBzdGFydGluZyBrZXJuZWwgaXMgYSBkdW1wIGNhcHR1
cmUga2VybmVsPw0KSSB0aGluayB1c2luZyBjbWRsaW5lIG9wdGlvbiBpcyB0aGUgc2ltcGxlc3Qg
d2F5LiAgWW91IGp1c3QgaGF2ZSB0bw0KYWRkICJub2V4dG5taSIgdG8gS0RVTVBfQ09NTUFORExJ
TkVfQVBQRU5EIGluIC9ldGMvc3lzY29uZmlnL2tkdW1wLg0KDQpSZWdhcmRzLA0KDQpIaWRlaGly
byBLYXdhaQ0KSGl0YWNoaSwgTHRkLiBSZXNlYXJjaCAmIERldmVsb3BtZW50IEdyb3VwDQoNCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmtleGVjIG1haWxp
bmcgbGlzdAprZXhlY0BsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQu
b3JnL21haWxtYW4vbGlzdGluZm8va2V4ZWMK
