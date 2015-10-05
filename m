Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail7.hitachi.co.jp ([133.145.228.42])
 by bombadil.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Ziv8a-0003oI-Dw
 for kexec@lists.infradead.org; Mon, 05 Oct 2015 02:04:25 +0000
From: =?utf-8?B?5rKz5ZCI6Iux5a6PIC8gS0FXQUnvvIxISURFSElSTw==?=
 <hidehiro.kawai.ez@hitachi.com>
Subject: RE: [V4 PATCH 4/4] x86/apic: Introduce noextnmi boot option
Date: Mon, 5 Oct 2015 02:03:58 +0000
Message-ID: <04EAB7311EE43145B2D3536183D1A844549A4557@GSjpTKYDCembx31.service.hitachi.net>
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
 <20151002074721.GA16538@pd.tnic>
In-Reply-To: <20151002074721.GA16538@pd.tnic>
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

PiBPbiBGcmksIE9jdCAwMiwgMjAxNSBhdCAxMjo1ODowMkFNICswMDAwLCDmsrPlkIjoi7Hlro8g
LyBLQVdBSe+8jEhJREVISVJPIHdyb3RlOg0KPiA+ID4gT24gVGh1LCBPY3QgMDEsIDIwMTUgYXQg
MTA6MjQ6MTlBTSArMDAwMCwg5rKz5ZCI6Iux5a6PIC8gS0FXQUnvvIxISURFSElSTyB3cm90ZToN
Cj4gPiA+ID4gQnV0IGhvdyBkbyB3ZSBjaGVjayBpZiB0aGUgc3RhcnRpbmcga2VybmVsIGlzIGEg
ZHVtcCBjYXB0dXJlIGtlcm5lbD8NCj4gPiA+DQo+ID4gPiBIb3cgZG9lcyB0aGF0IGZpcnN0IGtl
cm5lbCBwYXNzIGluZm8gdG8gdGhlIGNhcHR1cmUga2VybmVsPw0KPiA+DQo+ID4gQXMgSSBkZXNj
cmliZWQgaW4gdGhlIHByZXZpb3VzIG1haWwsDQo+IA0KPiBJIG1lYW50OiAiSG93IGRvZXMgdGhl
IGZpcnN0IGtlcm5lbCBwYXNzIGluZm8gdG8gdGhlIGNhcHR1cmUga2VybmVsIGJ5DQo+ICpub3Qq
IHVzaW5nIHRoZSBrZXJuZWwgY29tbWFuZCBsaW5lIj8NCj4gDQo+IFRoZSBrZXJuZWwgY29tbWFu
ZCBsaW5lIGlzIG5vdCB0aGUgY2hhbm5lbCB0byBwYXNzIGRhdGEgdG8gdGhlIGtkdW1wDQo+IGtl
cm5lbC4NCg0KVGhhdCdzIGRpZmZlcmVudCBmcm9tIG15IHBvaW50IG9mIHZpZXcuICBJJ20gbm90
IGdvaW5nIHRvIHBhc3MNCnNvbWUgZGF0YSBmcm9tIHRoZSBmaXJzdCBrZXJuZWwgdG8gdGhlIHNl
Y29uZCBrZXJuZWwuIEknbSBqdXN0IGdvaW5nIHRvDQpwcm92aWRlIGEgY29uZmlndXJhYmxlIG9w
dGlvbiBmb3IgdGhlIHNlY29uZCBrZXJuZWwgdG8gdXNlcnMuDQoNCldlIHNvdWxkbid0IGVuYWJs
ZSB0aGlzIGZlYXR1cmUgc2lsZW50bHkuICBTb21lIHVzZXJzIHdvdWxkbid0IGxpa2UNCnRvIGVu
YWJsZSB0aGlzIGZlYXR1cmUuICBGb3IgZXhhbXBsZSwgYSB1c2VyIGVuYWJsZXMgYSB3YXRjaGRv
ZyB0aW1lcg0Kd2hpY2ggcmFpc2VzIGFuIGV4dGVybmFsIE5NSSB3aGVuIHRoZSBjb3VudGVyIGlz
IG5vdCByZXNldCBmb3IgYQ0Kc3BlY2lmaWMgZHVyYXRpb24uICBUaGVuLCB0aGUgc2Vjb25kIGtl
cm5lbCBoYW5ncyB1cCB3aGlsZSBzYXZpbmcNCmNyYXNoIGR1bXAsIGFuZCBOTUkgaXMgZGVsaXZl
cmVkIHRvIHRoZSBDUFUuICBUaGUga2VybmVsIGdldHMgcGFuaWMNCmR1ZSB0byB0aGUgTk1JLCBw
cmludHMgc29tZSBpbmZvcm1hdGlvbiB0byB0aGUgZGlzcGxheSBhbmQgc2VyaWFsDQpjb25zb2xl
LCBhbmQgdGhlbiBhdXRvbWF0aWNhbGx5IHJlYm9vdC4gIEluIHRoaXMgY2FzZSwgdXNlcnMgZG9u
J3QNCndhbnQgdG8gYmxvY2sgZXh0ZXJuYWwgTk1Jcy4NCg0KU28sIG1ha2luZyB0aGlzIGZlYXR1
cmUgY29uZmlndXJhYmxlIGJ5IGNvbW1hbmQgbGluZSBvcHRpb24gaXMNCnJlYXNvbmFibGUuDQoN
Cj4gPiBZZXMsIHlvdXIgZmlyc3Qga2VybmVsIGRvZXNuJ3QgZ2V0IGV4dGVybmFsIE5NSXMsIGJ1
dCBiYXNpY2FsbHkNCj4gPiB5b3UgZG9uJ3QgaGF2ZSB0byBzZXQgIm5vZXh0bm1pIiBvcHRpb24g
dG8gdGhlIGZpcnN0IGtlcm5lbC4NCj4gDQo+IFNvIGl0IGRvZXNuJ3QgYmVsb25nIHRoZXJlIGFz
IGEga2VybmVsIGNvbW1hbmQgbGluZSBwYXJhbWV0ZXIgaW4gdGhlDQo+IGZpcnN0IHBsYWNlLg0K
PiANCj4gSU9XLCB5b3UgbmVlZCBhIGRpZmZlcmVudCBtZXRob2QgdG8gcGFzcyBkYXRhIHRvIHRo
ZSBzZWNvbmQga2VybmVsLiBCZQ0KPiBpdCBhbiBFTEYgaGVhZGVyLCBiZSBpdCBhIHNoYXJlZCBw
YWdlLCB3aGF0ZXZlci4NCg0KSSB0aGluayB3ZSBzaG91bGQgdXNlIHRoZSBFTEYgaGVhZGVyIG9u
bHkgaWYgdGhlIHBhc3NlZCBpbmZvcm1hdGlvbg0KaXMgc2F2ZWQgdG8gYSBjcmFzaCBkdW1wLg0K
DQpBbHNvLCB3ZSB3b3VsZG4ndCB3YW50IHRvIGludHJvZHVjZSBuZXcgc2hhcmVkIHBhZ2UgZm9y
IHRoYXQgcHVycG9zZS4NCkEgbWVtb3J5IHNlZ21lbnQgcHJvdmlkZWQgYnkga2V4ZWMgc3lzY2Fs
bCBpcyBub3QgdXNhYmxlIGJlY2F1c2UNCnRoZSBzZWNvbmQga2VybmVsIGRvZXNuJ3Qga25vdyB3
aGF0IHRoZXJlIGlzIGluIGEgc2VnbWVudCB3aXRob3V0IGENCmNvbW1hbmQgbGluZSBvcHRpb24u
ICBQbGVhc2Ugbm90ZSB0aGF0ICJlbGZjb3JlaGRyIiBjb21tYW5kIGxpbmUgb3B0aW9uDQpwcmVw
YXJlZCBieSBrZXhlYyBjb21tYW5kIGlzIHVzZWQgdG8gaW5mb3JtIHRoZSBzZWNvbmQga2VybmVs
IGFib3V0DQp0aGUgYWRkcmVzcyBvZiB0aGUgRUxGIGhlYWRlciBtZW1vcnkgc2VnbWVudC4NCg0K
UmVnYXJkcywNCg0KDQpIaWRlaGlybyBLYXdhaQ0KSGl0YWNoaSwgTHRkLiBSZXNlYXJjaCAmIERl
dmVsb3BtZW50IEdyb3VwDQoNCg0KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18Ka2V4ZWMgbWFpbGluZyBsaXN0CmtleGVjQGxpc3RzLmluZnJhZGVhZC5vcmcK
aHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9rZXhlYwo=
