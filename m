Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail4.hitachi.co.jp ([133.145.228.5])
 by bombadil.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1ZKiLh-00039M-6E
 for kexec@lists.infradead.org; Thu, 30 Jul 2015 07:33:54 +0000
From: =?utf-8?B?5rKz5ZCI6Iux5a6PIC8gS0FXQUnvvIxISURFSElSTw==?=
 <hidehiro.kawai.ez@hitachi.com>
Subject: RE: Re: [V2 PATCH 1/3] x86/panic: Fix re-entrance problem due to
 panic on NMI
Date: Thu, 30 Jul 2015 07:33:15 +0000
Message-ID: <04EAB7311EE43145B2D3536183D1A8445491F614@GSjpTKYDCembx31.service.hitachi.net>
References: <20150727015850.4928.87717.stgit@softrs>
 <20150727015850.4928.50289.stgit@softrs>
 <20150727143405.GF11317@dhcp22.suse.cz> <55B6E2A3.8070004@hitachi.com>
 <04EAB7311EE43145B2D3536183D1A8445491D5E8@GSjpTKYDCembx31.service.hitachi.net>
 <20150729082329.GA15801@dhcp22.suse.cz>
 <04EAB7311EE43145B2D3536183D1A8445491DB5E@GSjpTKYDCembx31.service.hitachi.net>
 <20150729092157.GC15801@dhcp22.suse.cz>
 <04EAB7311EE43145B2D3536183D1A8445491F23A@GSjpTKYDCembx31.service.hitachi.net>
In-Reply-To: <04EAB7311EE43145B2D3536183D1A8445491F23A@GSjpTKYDCembx31.service.hitachi.net>
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
To: "'ltc-kernel@ml.yrl.intra.hitachi.co.jp'" <ltc-kernel@ml.yrl.intra.hitachi.co.jp>, 'Michal Hocko' <mhocko@kernel.org>
Cc: "x86@kernel.org" <x86@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Peter Zijlstra <peterz@infradead.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, "Eric W. Biederman" <ebiederm@xmission.com>, "H. Peter Anvin" <hpa@zytor.com>, =?utf-8?B?5bmz5p2+6ZuF5bezIC8gSElSQU1BVFXvvIxNQVNBTUk=?= <masami.hiramatsu.pt@hitachi.com>, Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>, Vivek Goyal <vgoyal@redhat.com>

SGkgTWljaGFsLA0KDQo+IEZyb206IOays+WQiOiLseWujyAvIEtBV0FJ77yMSElERUhJUk8gW21h
aWx0bzpoaWRlaGlyby5rYXdhaS5lekBoaXRhY2hpLmNvbV0NCj4gPiBXaGVuIEkgd2FzIHRlc3Rp
bmcgbXkNCj4gPiBwcmV2aW91cyBhcHByb2FjaCAob24gMy4wIGJhc2VkIGtlcm5lbCkgSSBoYWQg
YmFzaWNhbGx5IHRoZSBzYW1lIHRoaW5nDQo+ID4gKG9uZSBOTUkgdG8gcHJvY2VzcyBwYW5pYykg
YW5kIG90aGVycyB0byByZXR1cm4uIFRoaXMgbGVkIHRvIGEgc3RyYW5nZQ0KPiA+IGJlaGF2aW9y
IHdoZW4gdGhlIE5NSSBidXR0b24gdHJpZ2dlcmVkIE5NSSBvbiBhbGwgKGh1bmRyZWRzKSBDUFVz
Lg0KPiANCj4gSXQncyBzdHJhbmdlLiAgVXN1YWxseSwgTk1JIGNhdXNlZCBieSBOTUkgYnV0dG9u
IGlzIHJvdXRlZCB0byBvbmx5IENQVSAwDQo+IGFzIGFuIGV4dGVybmFsIE5NSS4gIEV4dGVybmFs
IE5NSSBmb3IgQ1BVcyBvdGhlciB0aGFuIENQVSAwIGFyZSBtYXNrZWQNCj4gYXQgYm9vdCB0aW1l
LiAgRG9lcyBpdCByZWFsbHkgaGFwcGVuPyAgRG9lcyB0aGUgcHJvYmxlbSBzdGlsbCBoYXBwZW4g
b24NCj4gdGhlIGxhdGVzdCBrZXJuZWw/ICBXaGF0IGtpbmQgb2YgTk1JIGlzIGRlbGl2ZXJkIHRv
IGVhY2ggQ1BVPw0KDQpBcmUgeW91IHVzaW5nIFNHSSBVVj8gIE9uIHRoYXQgcGxhdGZvcm0sIE5N
SXMgbWF5IGJlIGRlbGl2ZXJlZCB0bw0KYWxsIGNwdXMgYmVjYXVzZSBMVlQxIG9mIGFsbCBjcHVz
IGFyZSBub3QgbWFza2VkIGFzIGZvbGxvd3M6DQoNCnZvaWQgdXZfbm1pX2luaXQodm9pZCkNCnsN
CiAgICAgICAgdW5zaWduZWQgaW50IHZhbHVlOw0KDQogICAgICAgIC8qDQogICAgICAgICAqIFVu
bWFzayBOTUkgb24gYWxsIGNwdXMNCiAgICAgICAgICovDQogICAgICAgIHZhbHVlID0gYXBpY19y
ZWFkKEFQSUNfTFZUMSkgfCBBUElDX0RNX05NSTsNCiAgICAgICAgdmFsdWUgJj0gfkFQSUNfTFZU
X01BU0tFRDsNCiAgICAgICAgYXBpY193cml0ZShBUElDX0xWVDEsIHZhbHVlKTsNCn0NCg0KPiAN
Cj4gVHJhZGl0aW9uYWxseSwgd2Ugc2hvdWxkIGhhdmUgYXNzdW1lZCB0aGF0IE5NSSBmb3IgY3Jh
c2ggZHVtcGluZyBpcw0KPiBkZWxpdmVyZWQgdG8gb25seSBvbmUgY3B1LiAgT3RoZXJ3aXNlLCB3
ZSBzaG91bGQgb2Z0ZW4gZmFpbCB0byB0YWtlDQo+IGEgcHJvcGVyIGNyYXNoIGR1bXAuICBJdCBz
ZWVtcyB0aGF0IHlvdXIgY2FzZSBpcyBhbm90aGVyIHByb2JsZW0gdG8gYmUNCj4gc29sdmVkIHNl
cGFyYXRlbHkuDQo+IA0KPiA+IFRoZQ0KPiA+IGNyYXNoIGtlcm5lbCBib290ZWQgZXZlbnR1YWxs
eSBidXQgdGhlIGxvZyBjb250YWluZWQgbG9ja3VwcyB3aGVuIGENCj4gPiBDUFUgd2FpdGVkIGZv
ciBhbiBJUEkgdG8gdGhlIENQVSB3aGljaCB3YXMgaGFuZGxpbmcgdGhlIE5NSSBwYW5pYy4NCj4g
DQo+IENvdWxkIHlvdSBleHBsYWluIG1vcmUgcHJlY2lzZWx5Pw0KPiANCj4gPiBBbnl3YXksIEkg
ZG8gbm90IHRoaW5nIHRoaXMgaXMgcmVhbGx5IG5lY2Vzc2FyeSB0byBzb2x2ZSB0aGUgcGFuaWMN
Cj4gPiByZWVudHJhbmN5IGlzc3VlLg0KPiA+IElmIHRoZSBtaXNzaW5nIHNhdmVkIHN0YXRlIGlz
IGEgcmVhbCBwcm9ibGVtIHRoZW4gaXQNCj4gPiBzaG91bGQgYmUgaGFuZGxlZCBzZXBhcmF0ZWx5
IC0gbWF5YmUgaXQgY2FuIGJlIGFjaGlldmVkIHdpdGhvdXQgYW4gSVBJDQo+ID4gYW5kIGRpcmVj
dGx5IGZyb20gdGhlIHBhbmljIGNvbnRleHQgaWYgd2UgYXJlIGluIE5NSS4NCj4gDQo+IFdoYXQg
SSB3b3VsZCBsaWtlIHRvIGRvIHZpYSB0aGlzIHBhdGNoc2UgaXMgdG8gc29sdmUgcmFjZSBpc3N1
ZXMNCj4gYW1vbmcgTk1JLCBwYW5pYygpIGFuZCBjcmFzaF9rZXhlYygpLiAgU28sIEkgZG9uJ3Qg
dGhpbmsgd2Ugc2hvdWxkIGZpeA0KPiB0aGF0IHNlcGFyYXRlbHksIGFsdGhvdWdoIEkgd291bGQg
bmVlZCB0byByZXdvcmQgc29tZSBkZXNjcmlwdGlvbnMNCj4gYW5kIHRpdGxlcy4NCj4gDQo+IEFu
eXdheSwgSSdtIGdvaW5nIHRvIHNlbnQgb3V0IG15IHJldmlzZWQgdmVyc2lvbiBvbmNlIGluIG9y
ZGVyIHRvDQo+IHRpZHkgdXAuICBJIGFsc28gd291bGQgbGlrZSB0byBoZWFyIGtleGVjL2tkdW1w
IGd1eXMnIG9waW5pb25zLg0KPiANCj4gUmVnYXJkcywNCj4gS2F3YWkNCg0KX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18Ka2V4ZWMgbWFpbGluZyBsaXN0Cmtl
eGVjQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1h
bi9saXN0aW5mby9rZXhlYwo=
