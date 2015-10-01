Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail4.hitachi.co.jp ([133.145.228.5])
 by bombadil.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1ZhXsd-0000H9-75
 for kexec@lists.infradead.org; Thu, 01 Oct 2015 07:02:16 +0000
From: =?utf-8?B?5rKz5ZCI6Iux5a6PIC8gS0FXQUnvvIxISURFSElSTw==?=
 <hidehiro.kawai.ez@hitachi.com>
Subject: RE: [V4 PATCH 4/4] x86/apic: Introduce noextnmi boot option
Date: Thu, 1 Oct 2015 07:01:50 +0000
Message-ID: <04EAB7311EE43145B2D3536183D1A8445499D30D@GSjpTKYDCembx31.service.hitachi.net>
References: <20150925112803.4258.94241.stgit@softrs>
 <20150925112811.4258.54494.stgit@softrs>
 <20150930115548.GI2881@worktop.programming.kicks-ass.net>
 <04EAB7311EE43145B2D3536183D1A8445499CD11@GSjpTKYDCembx31.service.hitachi.net>
 <20151001062733.GL2881@worktop.programming.kicks-ass.net>
In-Reply-To: <20151001062733.GL2881@worktop.programming.kicks-ass.net>
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
To: 'Peter Zijlstra' <peterz@infradead.org>
Cc: "x86@kernel.org" <x86@kernel.org>, Jonathan Corbet <corbet@lwn.net>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Michal Hocko <mhocko@kernel.org>, Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, "Eric
 W. Biederman" <ebiederm@xmission.com>, "H. Peter Anvin" <hpa@zytor.com>, =?utf-8?B?5bmz5p2+6ZuF5bezIC8gSElSQU1BVFXvvIxNQVNBTUk=?= <masami.hiramatsu.pt@hitachi.com>, Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>, Vivek Goyal <vgoyal@redhat.com>

PiBPbiBUaHUsIE9jdCAwMSwgMjAxNSBhdCAwMjozMzoxOEFNICswMDAwLCDmsrPlkIjoi7Hlro8g
LyBLQVdBSe+8jEhJREVISVJPIHdyb3RlOg0KPiA+ID4gT24gRnJpLCBTZXAgMjUsIDIwMTUgYXQg
MDg6Mjg6MTFQTSArMDkwMCwgSGlkZWhpcm8gS2F3YWkgd3JvdGU6DQo+ID4gPiA+IFRoaXMgcGF0
Y2ggaW50cm9kdWNlcyBuZXcgYm9vdCBvcHRpb24gIm5vZXh0bm1pIiB3aGljaCBkaXNhYmxlcw0K
PiA+ID4gPiBleHRlcm5hbCBOTUkuICBUaGlzIG9wdGlvbiBpcyB1c2VmdWwgZm9yIHRoZSBkdW1w
IGNhcHR1cmUga2VybmVsDQo+ID4gPiA+IHNvIHRoYXQgYW4gSEEgYXBwbGljYXRpb24gb3IgYWRt
aW5pc3RyYXRvciB3b3VsZG4ndCBtaXN0YWtlbmx5DQo+ID4gPiA+IHNob290IGRvd24gdGhlIGtl
cm5lbCBieSBOTUkuDQo+ID4gPg0KPiA+ID4gU28gdGhhdCB0aGV5IGNhbiBnZXQgcmVhbGx5IHN0
dWNrIHdoZW4gdGhlIGNyYXNoIGtlcm5lbCBjcmFzaGVzLCByaWdodD8NCj4gPiA+IDstKQ0KPiA+
DQo+ID4gTm8sIGl0IGlzIGRpZmZlcmVudCBmcm9tIG15IGludGVudGlvbi4NCj4gPg0KPiA+IGBt
aXN0YWtlbmx5JyBpbiB0aGUgYWJvdmUgbWVhbnM7IHRoZXkgaXNzdWUgTk1JIGR1ZSB0byBhIG1p
c2NvbmNlcHRpb24NCj4gPiB0aGF0IHRoZSBtb25pdG9yZWQgaG9zdCBpcyBzdHVjayBpbiB0aGUg
MXN0IGtlcm5lbCB3aGlsZSBpdCBpcyBhY3R1YWxseQ0KPiA+IHRha2luZyBhIGNyYXNoIGR1bXAg
aW4gdGhlIDJuZCBrZXJuZWwuICBUbyBhdm9pZCB0aGlzIGtpbmQgb2YgYWNjaWRlbnQsDQo+ID4g
dGhlcmUgaXMgYSB0b29sIHN1Y2ggYXMgZmVuY2Vfa2R1bXAgd2hpY2ggbm90aWZpZXMgIkknbSB0
YWtpbmcgYSBjcmFzaA0KPiA+IGR1bXAsIHNvIGRvbid0IHNlbmQgTk1JIiB0byB0aGUgSEEgY2x1
c3RlcmluZyBzb2Z0d2FyZS4gIEhvd2V2ZXIsIHRoZXJlDQo+ID4gaXMgYSB0aW1lIHdpbmRvdyBi
ZXR3ZWVuIGtlcm5lbCBwYW5pYyBhbmQgdGhlIG5vdGlmaWNhdGlvbi4NCj4gPg0KPiA+ICJub2V4
dG5taSIgYWxsb3dzIHVzZXJzIHRvIGF2b2lkIHRoaXMga2luZCBvZiBhY2NpZGVudCBhbGwgdGhl
IHRpbWUgb2YNCj4gPiAybmQga2VybmVsLg0KPiANCj4gWWVzIHllcywgSSB1bmRlcnN0YW5kLiBC
dXQgaWYgdGhlIGNyYXNoIGtlcm5lbCBhbHNvIGdldHMgc3R1Y2sgdGhleSBoYXZlDQo+IG5vIG1l
YW5zIG9mIHJlY292ZXJ5LCByaWdodD8gKG90aGVyIHRoYW4gcG93ZXIgY3ljbGluZyB0aGUgaGFy
ZHdhcmUpDQoNClllcywgYnV0IEkgdGhpbmsgaXQncyBub3QgYSBiaWcgcHJvYmxlbS4NCg0KSSBz
dXBwb3NlIHRoYXQgYSBzZXZlciB3aGljaCB1c2VzIHRoaXMgZmVhdHVyZSB3aWxsIGVxdWlwIGEg
Qk1DDQphbmQgQk1DIG1hbmRhdG9yaWx5IHN1cHBvcnRzIGhhcmQgcmVzZXQgY29tbWFuZCBmb3Ig
dGhlIHNlcnZlci4NCklmIHRoZSBIQSBjbHVzdGVyaW5nIHNvZnR3YXJlIGRldGVjdHMgbm8gcmVz
cG9uc2UgZnJvbSB0aGUgc2VydmVyDQphZnRlciByZWxhdGl2ZWx5IGxvbmcgdGltZW91dCwgaXQg
bWlnaHQgd2FudCB0byBpbnNlcnQgaGFyZCByZXNldA0KdG8gdGhlIHNlcnZlciBieSBJUE1JIG92
ZXIgTEFOLg0KDQo+IEp1c3QgcGxheWluZyBkZXZpbHMgYWR2b2NhdGUgaGVyZSwgSSBkb24ndCBh
Y3R1YWxseSBvYmplY3QgdG8gdGhlIHBhdGNoLg0KDQpSZWdhcmRzLA0KDQpIaWRlaGlybyBLYXdh
aQ0KSGl0YWNoaSwgTHRkLiBSZXNlYXJjaCAmIERldmVsb3BtZW50IEdyb3VwDQoNCg0KDQpfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwprZXhlYyBtYWlsaW5n
IGxpc3QKa2V4ZWNAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9y
Zy9tYWlsbWFuL2xpc3RpbmZvL2tleGVjCg==
