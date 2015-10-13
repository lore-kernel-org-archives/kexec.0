Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail7.hitachi.co.jp ([133.145.228.42])
 by bombadil.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1ZlyB7-0008WA-B9
 for kexec@lists.infradead.org; Tue, 13 Oct 2015 11:55:45 +0000
From: =?utf-8?B?5rKz5ZCI6Iux5a6PIC8gS0FXQUnvvIxISURFSElSTw==?=
 <hidehiro.kawai.ez@hitachi.com>
Subject: RE: [V4 PATCH 4/4] x86/apic: Introduce noextnmi boot option
Date: Tue, 13 Oct 2015 11:55:10 +0000
Message-ID: <04EAB7311EE43145B2D3536183D1A844549B7264@GSjpTKYDCembx31.service.hitachi.net>
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
 <20151005101431.GC23259@nazgul.tnic>
In-Reply-To: <20151005101431.GC23259@nazgul.tnic>
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

SGVsbG8sIEJvcmlzDQoNClNvcnJ5IGZvciB0aGUgbGF0ZSByZXBseS4NCg0KPiBPbiBNb24sIE9j
dCAwNSwgMjAxNSBhdCAwOToyMTowMkFNICswMDAwLCDmsrPlkIjoi7Hlro8gLyBLQVdBSe+8jEhJ
REVISVJPIHdyb3RlOg0KPiA+IFNvLCB0aGUgcHJvYmxlbSBmb3IgeW91IGlzIHRoYXQgIm5vZXh0
bm1pIiBvcHRpb24gaXMgdmlzaWJsZSBhbmQgZWZmZWN0aXZlDQo+ID4gaW4gdGhlIGZpcnN0IGtl
cm5lbCwgaXNuJ3QgaXQ/DQo+IA0KPiBObywgc3VjaCBhbiBvcHRpb24gc2hvdWxkbid0IGV4aXN0
IGF0IGFsbC4gWW91IHNob3VsZCBiZSBwYXNzaW5nDQo+IGluZm9ybWF0aW9uICppbiogKmEqICpk
aWZmZXJlbnQqICptYW5uZXIqIHRvIHRoZSBrZHVtcCBrZXJuZWwgLSBub3Qgd2l0aA0KPiBhIGtl
cm5lbCBjb21tYW5kIGxpbmUgb3B0aW9uLg0KDQpTb3JyeSwgSSBjb3VsZG4ndCBmaW5kIG91dCB0
aGUgcmVhc29uIHdoeSBJIHNob3VsZG4ndCB1c2UgY21kbGluZSBvcHRpb24uDQpJdCBkb2Vzbid0
IG5lZWQgbmV3IHVzZXIgSS9GIHRvIGluZm9ybSB0aGUgMXN0IGtlcm5lbCBhYm91dCBtYXNraW5n
L3VubWFza2luZw0KZXh0ZXJuYWwgTk1JIGluIHRoZSAybmQga2VybmVsLCBkb2Vzbid0IG5lZWQg
bmV3IGRhdGEgcGFzc2luZyBpbmZyYXN0cnVjdHVyZSwNCmFuZCBpcyBlYXN5IHRvIGNvbmZpZ3Vy
ZSB0aGF0LiAgQWxzbywgImVsZmNvcmVoZHIiIGFuZCAiZGlzYWJsZV9jcHVfYXBpY2lkIg0KaGF2
ZSBhbHJlYWR5IGJlZW4gaW50cm9kdWNlZCBhcyBjbWRsaW5lIG9wdGlvbnMgZm9yIGR1bXAgY2Fw
dHVyZSBrZXJuZWwuDQpUaGlzIG1lYW5zIHRoZSBjbWRsaW5lIG9wdGlvbiBhcHByb2FjaCB3b3Vs
ZCBiZSBtb3N0bHkgYWNjZXB0YWJsZS4NCg0KPiBJIGdldCB0aGUgZmVlbGluZyBJJ20gc3RhcnRp
bmcgdG8gc291bmQgbGlrZSBhIGJyb2tlbiByZWNvcmQgb24gdGhpcw0KPiBtYWlsIHRocmVhZC4u
LiA6LSgNCj4gDQo+IE9uZSBvdGhlciB0aGluZyB3ZSBjb3VsZCBwcm9iYWJseSB0cnkgdG8gZG8g
aXMgdXNlIGJvb3RfcGFyYW1zIHdoaWNoDQo+IGlzLCBJSVVDLCBwYXNzZWQgdG8gdGhlIHNlY29u
ZCBrZXJuZWwuIFNvIHdlIGNhbiBhZGQgYW5vdGhlciBiaXQgdG8NCj4gYm9vdF9wYXJhbXMuaGRy
LmxvYWRmbGFncyBvciBzbyBhbmQgdXNlIHRoYXQuIE9yIHNvbWV0aGluZyBzaW1pbGFyLg0KDQpJ
IHRoaW5rIHVzaW5nIGJvb3RfcGFyYW1zIHdvdWxkIGJlIHdvcnNlIHRoYW4gRUxGIGhlYWRlciBh
cHByb2FjaC4NCkl0IG5lZWRzIHRvIHJlc2VydmUgYm9vdF9wYXJhbXMgYml0cyBmb3IgYWxsIGJv
b3QgbG9hZGVycy4NCg0KUmVnYXJkcywNCg0KSGlkZWhpcm8gS2F3YWkNCkhpdGFjaGksIEx0ZC4g
UmVzZWFyY2ggJiBEZXZlbG9wbWVudCBHcm91cA0KDQoNCl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fCmtleGVjIG1haWxpbmcgbGlzdAprZXhlY0BsaXN0cy5p
bmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8v
a2V4ZWMK
