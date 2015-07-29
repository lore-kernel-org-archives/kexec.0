Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-wi0-f172.google.com ([209.85.212.172])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1ZKMeZ-0007NG-28
 for kexec@lists.infradead.org; Wed, 29 Jul 2015 08:23:55 +0000
Received: by wibxm9 with SMTP id xm9so15006476wib.1
 for <kexec@lists.infradead.org>; Wed, 29 Jul 2015 01:23:32 -0700 (PDT)
Date: Wed, 29 Jul 2015 10:23:30 +0200
From: Michal Hocko <mhocko@kernel.org>
Subject: Re: Re: [V2 PATCH 1/3] x86/panic: Fix re-entrance problem due to
 panic on NMI
Message-ID: <20150729082329.GA15801@dhcp22.suse.cz>
References: <20150727015850.4928.87717.stgit@softrs>
 <20150727015850.4928.50289.stgit@softrs>
 <20150727143405.GF11317@dhcp22.suse.cz>
 <55B6E2A3.8070004@hitachi.com>
 <04EAB7311EE43145B2D3536183D1A8445491D5E8@GSjpTKYDCembx31.service.hitachi.net>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <04EAB7311EE43145B2D3536183D1A8445491D5E8@GSjpTKYDCembx31.service.hitachi.net>
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
Cc: "x86@kernel.org" <x86@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Peter Zijlstra <peterz@infradead.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, "Eric W. Biederman" <ebiederm@xmission.com>, "H. Peter Anvin" <hpa@zytor.com>, =?utf-8?B?5bmz5p2+6ZuF5bezIC8gSElSQU1BVFXvvIxNQVNBTUk=?= <masami.hiramatsu.pt@hitachi.com>, Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>, Vivek Goyal <vgoyal@redhat.com>

T24gV2VkIDI5LTA3LTE1IDA1OjQ4OjQ3LCDmsrPlkIjoi7Hlro8gLyBLQVdBSe+8jEhJREVISVJP
IHdyb3RlOgo+IEhpLAo+IAo+ID4gRnJvbTogbGludXgta2VybmVsLW93bmVyQHZnZXIua2VybmVs
Lm9yZyBbbWFpbHRvOmxpbnV4LWtlcm5lbC1vd25lckB2Z2VyLmtlcm5lbC5vcmddIE9uIEJlaGFs
ZiBPZiBIaWRlaGlybyBLYXdhaQo+ID4gKDIwMTUvMDcvMjcgMjM6MzQpLCBNaWNoYWwgSG9ja28g
d3JvdGU6Cj4gPiA+IE9uIE1vbiAyNy0wNy0xNSAxMDo1ODo1MCwgSGlkZWhpcm8gS2F3YWkgd3Jv
dGU6Cj4gWy4uLl0KPiA+ID4gVGhlIGNoZWNrIGNvdWxkIGJlIGFsc28gcmVsYXhlZCBhIGJpdCBh
bmQgbm1pX3BhbmljIHdvdWxkCj4gPiA+IHJldHVybiBvbmx5IGlmIHRoZSBvbmdvaW5nIHBhbmlj
IGlzIHRoZSBjdXJyZW50IGNwdSB3aGVuIHdlIHJlYWxseSBoYXZlCj4gPiA+IHRvIHJldHVybiBh
bmQgYWxsb3cgdGhlIHByZWVtcHRlZCBwYW5pYyB0byBmaW5pc2guCj4gPiAKPiA+IEl0J3MgcmVh
c29uYWJsZS4gIEknbGwgZG8gdGhhdCBpbiB0aGUgbmV4dCB2ZXJzaW9uLgo+IAo+IEkgbm90aWNl
ZCBhdG9taWNfcmVhZCgpIGlzIGluc3VmZmljaWVudC4gIFBsZWFzZSBjb25zaWRlciB0aGUgZm9s
bG93aW5nCj4gc2NlbmFyaW8uCj4gCj4gQ1BVIDE6IGNhbGwgcGFuaWMoKSBpbiB0aGUgbm9ybWFs
IGNvbnRleHQKPiBDUFUgMDogY2FsbCBubWlfcGFuaWMoKSwgY2hlY2sgdGhlIHZhbHVlIG9mIHBh
bmljX2NwdSwgdGhlbiBjYWxsIHBhbmljKCkKPiBDUFUgMTogc2V0IDEgdG8gcGFuaWNfY3B1Cj4g
Q1BVIDA6IGZhaWwgdG8gc2V0IDAgdG8gcGFuaWNfY3B1LCB0aGVuIGRvIGFuIGluZmluaXRlIGxv
b3AKPiBDUFUgMTogY2FsbCBjcmFzaF9rZXhlYygpLCB0aGVuIGNhbGwga2R1bXBfbm1pX3Nob290
ZG93bl9jcHVzKCkKPiAKPiBBdCB0aGlzIHBvaW50LCBzaW5jZSBDUFUgMCBsb29wcyBpbiBOTUkg
Y29udGV4dCwgaXQgbmV2ZXIgZXhlY3V0ZXMKPiB0aGUgTk1JIGhhbmRsZXIgcmVnaXN0ZXJlZCBi
eSBrZHVtcF9ubWlfc2hvb3Rkb3duX2NwdXMoKS4gIFRoaXMgbWVhbnMKPiB0aGF0IG5vIHJlZ2lz
dGVyIHN0YXRlcyBhcmUgc2F2ZWQgYW5kIG5vIGNsZWFudXBzIGZvciBWTVgvU1ZNIGFyZQo+IHBl
cmZvcm1lZC4KClllcyB0aGlzIGlzIHRydWUgYnV0IGl0IGlzIG5vIGRpZmZlcmVudCBmcm9tIHRo
ZSBjdXJyZW50IHN0YXRlLCBpc24ndAppdD8gU28gaWYgeW91IHdhbnQgdG8gaGFuZGxlIHRoYXQg
dGhlbiBpdCBkZXNlcnZlcyBhIHNlcGFyYXRlIHBhdGNoLgpJdCBpcyBjZXJ0YWlubHkgbm90IGhh
cm1mdWwgd3J0LiBwYW5pYyBiZWhhdmlvci4KCj4gU28sIHdlIHNob3VsZCBzdGlsbCB1c2UgYXRv
bWljX2NtcHhjaGcoKSBpbiBubWlfcGFuaWMoKSB0bwo+IHByZXZlbnQgb3RoZXIgY3B1cyBmcm9t
IHJ1bm5pbmcgcGFuaWMgcm91dGluZXMuCgpOb3Qgc3VyZSB3aGF0IHlvdSBtZWFuIGJ5IHRoYXQu
CgotLSAKTWljaGFsIEhvY2tvClNVU0UgTGFicwoKX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18Ka2V4ZWMgbWFpbGluZyBsaXN0CmtleGVjQGxpc3RzLmluZnJh
ZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9rZXhl
Ywo=
