Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail9.hitachi.co.jp ([133.145.228.44])
 by bombadil.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1ZKis3-00040S-IZ
 for kexec@lists.infradead.org; Thu, 30 Jul 2015 08:07:20 +0000
From: =?utf-8?B?5rKz5ZCI6Iux5a6PIC8gS0FXQUnvvIxISURFSElSTw==?=
 <hidehiro.kawai.ez@hitachi.com>
Subject: RE: Re: [V2 PATCH 1/3] x86/panic: Fix re-entrance problem due to
 panic on NMI
Date: Thu, 30 Jul 2015 08:06:56 +0000
Message-ID: <04EAB7311EE43145B2D3536183D1A8445491F722@GSjpTKYDCembx31.service.hitachi.net>
References: <20150727015850.4928.87717.stgit@softrs>
 <20150727015850.4928.50289.stgit@softrs>
 <20150727143405.GF11317@dhcp22.suse.cz> <55B6E2A3.8070004@hitachi.com>
 <04EAB7311EE43145B2D3536183D1A8445491D5E8@GSjpTKYDCembx31.service.hitachi.net>
 <20150729082329.GA15801@dhcp22.suse.cz>
 <04EAB7311EE43145B2D3536183D1A8445491DB5E@GSjpTKYDCembx31.service.hitachi.net>
 <20150729092157.GC15801@dhcp22.suse.cz>
 <04EAB7311EE43145B2D3536183D1A8445491F23A@GSjpTKYDCembx31.service.hitachi.net>
 <04EAB7311EE43145B2D3536183D1A8445491F614@GSjpTKYDCembx31.service.hitachi.net>
 <20150730075512.GB9387@dhcp22.suse.cz>
In-Reply-To: <20150730075512.GB9387@dhcp22.suse.cz>
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

SGksDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTWljaGFsIEhvY2tv
IFttYWlsdG86bWhvY2tvQGtlcm5lbC5vcmddDQo+IA0KPiBPbiBUaHUgMzAtMDctMTUgMDc6MzM6
MTUsIOays+WQiOiLseWujyAvIEtBV0FJ77yMSElERUhJUk8gd3JvdGU6DQo+IFsuLi5dDQo+ID4g
QXJlIHlvdSB1c2luZyBTR0kgVVY/ICBPbiB0aGF0IHBsYXRmb3JtLCBOTUlzIG1heSBiZSBkZWxp
dmVyZWQgdG8NCj4gPiBhbGwgY3B1cyBiZWNhdXNlIExWVDEgb2YgYWxsIGNwdXMgYXJlIG5vdCBt
YXNrZWQgYXMgZm9sbG93czoNCj4gDQo+IFRoaXMgaXMgQ29tcHV0ZSBCbGFkZSA1MjBYQjEgZnJv
bSBIaXRhY2hpIHdpdGggMjQwIGNwdXMuDQoNClRoYW5rcyBmb3IgdGhlIGluZm9ybWF0aW9uIQ0K
DQpJIGFza2VkIG15IGNvbGxlYWd1ZSBpbiBvdGhlciBkZXBhcnRtZW50IGFib3V0IE5NSSBidXR0
b24gYmVoYXZpb3INCm9mIG91ciBzZXJ2ZXIganVzdCBiZWZvcmUgcmVjZWl2ZSB5b3VyIG1haWws
IGFuZCBjZXJ0YWlubHkgd2hhdCB5b3UNCnNhaWQgaGFwcGVuczsgYWxsIGNwdXMgc2F5ICJVaGh1
aC4gTk1JIHJlY2VpdmVkIGZvciB1bmtub3duIHJlYXNvbiAzZA0Kb24gQ1BVIE4iIHdoZW4gTk1J
IGJ1dHRvbiBpcyBwdXNzaGVkLiAgU28sIHRoaXMgd2FzIGFsc28gb3VyIHByb2JsZW0uLi4NCg0K
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18Ka2V4ZWMgbWFp
bGluZyBsaXN0CmtleGVjQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVh
ZC5vcmcvbWFpbG1hbi9saXN0aW5mby9rZXhlYwo=
