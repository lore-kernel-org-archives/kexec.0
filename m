Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail9.hitachi.co.jp ([133.145.228.44])
 by bombadil.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1ZMan2-0000hx-Nh
 for kexec@lists.infradead.org; Tue, 04 Aug 2015 11:53:53 +0000
From: =?utf-8?B?5rKz5ZCI6Iux5a6PIC8gS0FXQUnvvIxISURFSElSTw==?=
 <hidehiro.kawai.ez@hitachi.com>
Subject: RE: Re: [V2 PATCH 1/3] x86/panic: Fix re-entrance problem due to
 panic on NMI
Date: Tue, 4 Aug 2015 11:53:28 +0000
Message-ID: <04EAB7311EE43145B2D3536183D1A844549269F3@GSjpTKYDCembx31.service.hitachi.net>
References: <55B6E2A3.8070004@hitachi.com>
 <04EAB7311EE43145B2D3536183D1A8445491D5E8@GSjpTKYDCembx31.service.hitachi.net>
 <20150729082329.GA15801@dhcp22.suse.cz>
 <04EAB7311EE43145B2D3536183D1A8445491DB5E@GSjpTKYDCembx31.service.hitachi.net>
 <20150729092157.GC15801@dhcp22.suse.cz>
 <04EAB7311EE43145B2D3536183D1A8445491F23A@GSjpTKYDCembx31.service.hitachi.net>
 <20150730074812.GA9387@dhcp22.suse.cz>
 <04EAB7311EE43145B2D3536183D1A8445491FC55@GSjpTKYDCembx31.service.hitachi.net>
 <20150730122747.GA3954@dhcp22.suse.cz>
 <04EAB7311EE43145B2D3536183D1A844549220E7@GSjpTKYDCembx31.service.hitachi.net>
 <20150804085651.GC18509@dhcp22.suse.cz>
In-Reply-To: <20150804085651.GC18509@dhcp22.suse.cz>
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
To: 'Michal Hocko' <mhocko@kernel.org>
Cc: "x86@kernel.org" <x86@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Peter Zijlstra <peterz@infradead.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, "Eric W. Biederman" <ebiederm@xmission.com>, "H. Peter Anvin" <hpa@zytor.com>, =?utf-8?B?5bmz5p2+6ZuF5bezIC8gSElSQU1BVFXvvIxNQVNBTUk=?= <masami.hiramatsu.pt@hitachi.com>, Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>, Vivek Goyal <vgoyal@redhat.com>

SGksDQoNCj4gRnJvbTogTWljaGFsIEhvY2tvIFttYWlsdG86bWhvY2tvQGtlcm5lbC5vcmddDQo+
IE9uIEZyaSAzMS0wNy0xNSAxMToyMzowMCwg5rKz5ZCI6Iux5a6PIC8gS0FXQUnvvIxISURFSElS
TyB3cm90ZToNCj4gPiA+IEZyb206IE1pY2hhbCBIb2NrbyBbbWFpbHRvOm1ob2Nrb0BrZXJuZWwu
b3JnXQ0KPiA+ID4gPiBUaGVyZSBpcyBhIHRpbWVvdXQgb2YgMTAwMG1zIGluIG5taV9zaG9vdGRv
d25fY3B1cygpLCBzbyBJIGRvbid0IGtub3cNCj4gPiA+ID4gd2h5IENQVSAxMzAgd2FpdHMgc28g
bG9uZy4gIEknbGwgdHJ5IHRvIGNvbnNpZGVyIGZvciBhIHdoaWxlLg0KPiA+ID4NCj4gPiA+IFll
cywgSSBkbyBub3QgdW5kZXJzdGFuZCB0aGUgdGltaW5nIGhlcmUgZWl0aGVyIGFuZCB0aGUgZmFj
dCB0aGF0IHRoZQ0KPiA+ID4gbG9nIGlzIGEgY29tcGxldGUgbWVzcyBpbiB0aGUgaW1wb3J0YW50
IHBhcnRzIGRvZXNuJ3QgaGVscCBhIHdlZSBiaXQuDQo+ID4NCj4gPiBJJ20gaW50ZXJlc3RlZCBp
biB3aGVyZSAia2VybmVsIHBhbmljIC1ub3Qgc3luY2luZzogIiBpcy4NCj4gPiBJdCBtYXkgZ2l2
ZSB1cyBhIGNsdWUuDQo+IA0KPiBUaGlzIG9uZSBpcyBsb3N0IGluIHRoZSBtYW5nbGVkIHRleHQ6
DQo+IFsgIDE2Ny44NDM3NzFdIFU8MD5bICAxNjcuODQzNzcxXSBoaHVoLiBOTUkgcmVjZWl2ZWQg
Zm9yIHVua248MD48MD5bICAxNjcuODQzNzY1XSBVaFsgIDE2Tk04NDM3NzRJIG93biByZWEgcmVp
dmVkIGZvcg0KPiB1bmtub3c8MCByICAxNm4gMmQgNzY1XSBVaGh1aC4gQ1BVIHJlY2VpMTEuIDww
a25vd24gcmVhc29uIDcuIG9uNzcwXSBLZXI8WyAtIG5vdCBybiBOTUk6bmljIC0gbm90IGNvbnR0
IHNpbmcNCj4gDQo+IDwwID5bIDogTm90IGNvbi5pbnU0MzdhemVkIGFuZCBjb25mdXNlZCwgYl0g
RHRyeWluZ2FlZCBhbm51ZQ0KPiANCj4gZnUgMTY3Ljh1dCB0cnlpbmc+WyAgIHRvIDcuPDAzNzcg
MTY3Ljg0Mzc3NV0gVTwwPlsgIDE2Ny44NDM3NzZdIF1oaHUuaXZlZCBmb3IgdTNua25vd24gck1h
c29uIDMgcmUgb2l2ZWQgZm9yIFtuazE2Ny44NDM3ODFdDQoNClRoYW5rcyBmb3IgdGhlIGluZm9y
bWF0aW9uLg0KDQpJIGFudGljaXBhdGVkIHRoYXQgc29tZSBsb2NrIGNvbnRlbnRpb24gb24gaXNz
dWluZyBtZXNzYWdlcyAoZS5nLg0KbG9ja3MgdXNlZCBieSBuZXR3b3JrL25ldGNvbnNvbGUgZHJp
dmVyKSBkZWxheWVkIHRoZSBwYW5pYyBwcm9jZWR1cmUsDQpidXQgaXQgc2VlbXMgbm90IHRvIGJl
IHJlbGF0ZWQgYmVjYXVzZSB0aGUgcGFuaWMgbWVzc2FnZSBmaW5pc2hlZCB0bw0KYmUgaXNzdWVk
IGVhcmx5Lg0KDQpJZiBJIGNvbWUgdXAgd2l0aCBzb21ldGhpbmcsIEkgd2lsbCBwb3N0IGEgbWFp
bC4gIEkgdGhpbmsgdGhlcmUNCm1heSBiZSBwb3RlbnRpYWwgaXNzdWVzLg0KDQo+IDEuDQo+IDwu
IE4wPlsgIDE2Ny44NDM3ODFdIFVoLiBOTUkgcmVjZW4gM2Qgb24gQ1BVIDAuaTwgPlsgbm93b24g
M2Qgb25dIENoaHVoLk1JDQo+IGVjZWl2ZWRbIG9yNy44NDNua25vVWhodWgud24gck1hc29uIGUz
ZCBjZUNQaXZVZCAxMjAuDQo+IDwwbms+bm8gMTY3LnduODQzYXNvbiAzbmEgcyBwMTIwLg0KPiBv
PDBlciBzYXZpIGQ2IGU4NDNhYjg4XSBEbyB5ZXUgaGF2ZSBhDQo+IDx0cmFuZ2UwPlsgZXIgc2F2
aW5nIG1vZGUgZSBuYWJsMWQ/Nzw0XVsgIDE2NyA4NGh1OTRdTUl1aC4gTmNlSWl2ZWQgZm9yIHVu
a25vd24gcmVhcyB2ZGZvciAxbm8zd2FzMD5bIDJkIDY3Ljg0Mzgwb24gQ0kNCj4gclVlIDEyZS4N
Cj4gaXZlN2Q4dTM4MDB3biBydmVhc2VvIGYyZCBvbiBDUG8zLnI8IHU+a1tvIDEgcmVhNnMubzJk
OCBvbyB5b3UgaG4gYVB2ZSA8MHN0PmEgZSBwb3dlciAxczcuODQzODE2XSBEbyB5b2F1diBuZyBt
b2FkZQ0KPiBlbmJzbHJhP25nWyBlIDE2Ny44NDM4cDQxb11lciBzaGh1aGF2aS5uZ0lyb2VuaXZl
ZCBmYmxlZD9ua25vdw0KPiA8IHJlYXNvMD4gMmQgb24gW1BVMTYyNi40MV0wPiAgIFVoNjcuaC4g
Tk0zODdJXSByZWNlaWhlZCBmb3IgLm5rbm93biByZWFzb24gIDJObiBNQyBVIGNlaXZlZCBmb3Ig
Lg0KPiBbc29uIDJkIG9uIENQVSA2Lg0KPiA8ICAxNjA+Ny44NDY3Ljg0ODczXSBVaGh1aC4gM01J
IHJlY2VpdmVkIDkwOCBvIGtuc3RyYQ0KPiBbIG4xNjcuODQzOTA4XSBEbyB5Z28gcGF2ZSB3ZXN0
cmFuZ2VzYSBwdm52IG1vZGUgZW5hYmxlbmcgbW9kZSBlZD8NCj4gbjxiMGVkPw0KDQpSZWdhcmRz
LA0KS2F3YWkNCg0KDQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXwprZXhlYyBtYWlsaW5nIGxpc3QKa2V4ZWNAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8v
bGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2tleGVjCg==
