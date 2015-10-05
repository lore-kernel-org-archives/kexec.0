Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail7.hitachi.co.jp ([133.145.228.42])
 by bombadil.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Zj1xX-00016F-NX
 for kexec@lists.infradead.org; Mon, 05 Oct 2015 09:21:28 +0000
From: =?utf-8?B?5rKz5ZCI6Iux5a6PIC8gS0FXQUnvvIxISURFSElSTw==?=
 <hidehiro.kawai.ez@hitachi.com>
Subject: RE: [V4 PATCH 4/4] x86/apic: Introduce noextnmi boot option
Date: Mon, 5 Oct 2015 09:21:02 +0000
Message-ID: <04EAB7311EE43145B2D3536183D1A844549A48D3@GSjpTKYDCembx31.service.hitachi.net>
References: <20150930115548.GI2881@worktop.programming.kicks-ass.net>
 <04EAB7311EE43145B2D3536183D1A8445499CD11@GSjpTKYDCembx31.service.hitachi.net>
 <20151001062733.GL2881@worktop.programming.kicks-ass.net>
 <04EAB7311EE43145B2D3536183D1A8445499D30D@GSjpTKYDCembx31.service.hitachi.net>
 <20151001084335.GA3764@pd.tnic>
 <04EAB7311EE43145B2D3536183D1A8445499DB92@GSjpTKYDCembx31.service.hitachi.net>
 <20151001110110.GA3544@pd.tnic>
 <04EAB7311EE43145B2D3536183D1A8445499ED83@GSjpTKYDCembx31.service.hitachi.net>
 <20151002074721.GA16538@pd.tnic>
 <04EAB7311EE43145B2D3536183D1A844549A4557@GSjpTKYDCembx31.service.hitachi.net>
 <20151005082704.GA23259@nazgul.tnic>
In-Reply-To: <20151005082704.GA23259@nazgul.tnic>
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

PiBPbiBNb24sIE9jdCAwNSwgMjAxNSBhdCAwMjowMzo1OEFNICswMDAwLCDmsrPlkIjoi7Hlro8g
LyBLQVdBSe+8jEhJREVISVJPIHdyb3RlOg0KPiA+IFRoYXQncyBkaWZmZXJlbnQgZnJvbSBteSBw
b2ludCBvZiB2aWV3LiAgSSdtIG5vdCBnb2luZyB0byBwYXNzDQo+ID4gc29tZSBkYXRhIGZyb20g
dGhlIGZpcnN0IGtlcm5lbCB0byB0aGUgc2Vjb25kIGtlcm5lbC4gSSdtIGp1c3QgZ29pbmcgdG8N
Cj4gPiBwcm92aWRlIGEgY29uZmlndXJhYmxlIG9wdGlvbiBmb3IgdGhlIHNlY29uZCBrZXJuZWwg
dG8gdXNlcnMuDQo+IA0KPiBEdWRlLCBXVEY/ISBZb3UncmUgYWRkaW5nIGEga2VybmVsIGNvbW1h
bmQgbGluZSB3aGljaCBpcyBzdXBwb3NlZCB0bw0KPiBiZSB1c2VkICpvbmx5KiBieSB0aGUga2R1
bXAga2VybmVsLiBCdXQgbm9vbywgaXQgaXMgdGhlcmUgaW4gdGhlIG9wZW4NCj4gYW5kIHZpc2li
bGUgdG8gcGVvcGxlLiBBbmQgYW55b25lIGNhbiB0eXBlIGl0IGluIGR1cmluZyBib290LiBBTkQg
VEhBVA0KPiBTSE9VTEROJ1QgQkUgUE9TU0lCTEUgSU4gVEhFIEZJUlNUIFBMQUNFIQ0KPiANCj4g
VGhpcyBpbmZvcm1hdGlvbiBpcyBzdHJpY3RseSBmb3IgdGhlIGtkdW1wIGtlcm5lbCAtIGl0IHNo
b3VsZG4ndCBiZSBhDQo+IGdlbmVyaWMgY29tbWFuZCBsaW5lIG9wdGlvbi4gSG93IGhhcmQgaXQg
aXMgdG8gdW5kZXJzdGFuZCB0aGF0IHNpbXBsZQ0KPiBmYWN0PyENCg0KU28sIHRoZSBwcm9ibGVt
IGZvciB5b3UgaXMgdGhhdCAibm9leHRubWkiIG9wdGlvbiBpcyB2aXNpYmxlIGFuZCBlZmZlY3Rp
dmUNCmluIHRoZSBmaXJzdCBrZXJuZWwsIGlzbid0IGl0PyAgSWYgc28sIHdlIGNhbiBpZ25vcmUg
Im5vZXh0bm1pIiBvcHRpb24NCmlmIHdlIGFyZSBpbiB0aGUgZmlyc3Qga2VybmVsIGFuZCByZW1v
dmUgaXQgZnJvbSB0aGUgZG9jdW1lbnRhdGlvbi4NCiJlbGZjb3JlaGRyIiBjbWRsaW5lIG9wdGlv
biBwcmVwYXJlZCBieSBrZXhlYyBjb21tYW5kIGlzIHBhc3NlZCB0byBvbmx5DQp0aGUgc2Vjb25k
IGtlcm5lbCwgYW5kIGl0IGlzIGFsc28gdXNlZCB0byBjaGVjayBpZiB0aGUgYm9vdGVkIGtlcm5l
bCBpcw0KYSBrZHVtcCBrZXJuZWwuICBUaHVzLCBpZiAiZWxmY29yZWhkciIgaXMgTk9UIHNwZWNp
ZmllZCwgdGhlbiBpZ25vcmUNCiJub2V4dG5taSIuDQoNCkRvY3VtZW50YXRpb24va2VybmVsLXBh
cmFtZXRlcnMudHh0Og0KPiAgICAgICAgIGVsZmNvcmVoZHI9W3NpemVbS01HXUBdb2Zmc2V0W0tN
R10gW0lBNjQsUFBDLFNILFg4NixTMzkwXQ0KPiAgICAgICAgICAgICAgICAgICAgICAgICBTcGVj
aWZpZXMgcGh5c2ljYWwgYWRkcmVzcyBvZiBzdGFydCBvZiBrZXJuZWwgY29yZQ0KPiAgICAgICAg
ICAgICAgICAgICAgICAgICBpbWFnZSBlbGYgaGVhZGVyIGFuZCBvcHRpb25hbGx5IHRoZSBzaXpl
LiBHZW5lcmFsbHkNCj4gICAgICAgICAgICAgICAgICAgICAgICAga2V4ZWMgbG9hZGVyIHdpbGwg
cGFzcyB0aGlzIG9wdGlvbiB0byBjYXB0dXJlIGtlcm5lbC4NCj4gICAgICAgICAgICAgICAgICAg
ICAgICAgU2VlIERvY3VtZW50YXRpb24va2R1bXAva2R1bXAudHh0IGZvciBkZXRhaWxzLg0KDQo+
IDxzbmlwIG9idmlvdXMgdXNlIGNhc2U+DQo+IA0KPiA+IEkgdGhpbmsgd2Ugc2hvdWxkIHVzZSB0
aGUgRUxGIGhlYWRlciBvbmx5IGlmIHRoZSBwYXNzZWQgaW5mb3JtYXRpb24NCj4gPiBpcyBzYXZl
ZCB0byBhIGNyYXNoIGR1bXAuDQo+IA0KPiBTbyB3aGF0PyEgRUxGIGhlYWRlciB3aWxsIGNvbnRh
aW4gdGhlIGFkZGl0aW9uYWwgYml0IG9mIGluZm9ybWF0aW9uIHRoYXQNCj4gdGhlIHNlY29uZCBr
ZXJuZWwgd2Fzbid0IHJlYWN0aW5nIHRvIE5NSXMuIEJ1dCB0aGF0J3MgZmluZSwgdGhhdCAqaXMq
DQo+IHRoZSBkZXNpcmVkIGJlaGF2aW9yIGFueXdheS4NCj4gDQo+IEFsbCBJJ20gc2F5aW5nIGlz
LCB0aGlzIGlzIGEgc3RyaWN0IGtkdW1wIGtlcm5lbCAiY29tbWFuZCIsIHNvIHRvIHNwZWFrLA0K
PiBhbmQgaXQgZG9lc24ndCBiZWxvbmcgd2l0aCB0aGUgZ2VuZXJpYyBrZXJuZWwgY29tbWFuZCBs
aW5lIHBhcmFtZXRlcnMuDQoNClJlZ2FyZHMsDQoNCkhpZGVoaXJvIEthd2FpDQpIaXRhY2hpLCBM
dGQuIFJlc2VhcmNoICYgRGV2ZWxvcG1lbnQgR3JvdXANCg0KDQoNCl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmtleGVjIG1haWxpbmcgbGlzdAprZXhlY0Bs
aXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlz
dGluZm8va2V4ZWMK
