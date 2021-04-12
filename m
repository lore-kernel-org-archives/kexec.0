Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lVlhT-005pXe-Di
 for kexec@lists.infradead.org; Mon, 12 Apr 2021 01:49:17 +0000
Received: by mail-pf1-x435.google.com with SMTP id y16so8181182pfc.5
 for <kexec@lists.infradead.org>; Sun, 11 Apr 2021 18:49:15 -0700 (PDT)
From: Andy Lutomirski <luto@amacapital.net>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] x86/efi: Do not release sub-1MB memory regions when the
 crashkernel option is specified
Date: Sun, 11 Apr 2021 18:49:12 -0700
Message-Id: <8FAA2A0E-0A09-4308-B936-CDD2C0568BAE@amacapital.net>
References: <20210412011347.GA4282@MiWiFi-R3L-srv>
In-Reply-To: <20210412011347.GA4282@MiWiFi-R3L-srv>
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
To: Baoquan He <bhe@redhat.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>, Lianbo Jiang <lijiang@redhat.com>, linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org, platform-driver-x86@vger.kernel.org, x86@kernel.org, ardb@kernel.org, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, dvhart@infradead.org, andy@infradead.org, kexec@lists.infradead.org, dyoung@redhat.com

Cgo+IE9uIEFwciAxMSwgMjAyMSwgYXQgNjoxNCBQTSwgQmFvcXVhbiBIZSA8YmhlQHJlZGhhdC5j
b20+IHdyb3RlOgo+IAo+IO+7v09uIDA0LzA5LzIxIGF0IDA3OjU5cG0sIEguIFBldGVyIEFudmlu
IHdyb3RlOgo+PiBXaHkgZG9uJ3Qgd2UgZG8gdGhpcyB1bmNvbmRpdGlvbmFsbHk/IEF0IHRoZSB2
ZXJ5IGJlc3Qgd2UgZ2FpbiBoYWxmIGEgbWVnYWJ5dGUgb2YgbWVtb3J5IChleGNlcHQgdGhlIHRy
YW1wb2xpbmUsIHdoaWNoIGhhcyB0byBsaXZlIHRoZXJlLCBidXQgaXQgaXMgb25seSBhIGZldyBr
aWxvYnl0ZXMuKQo+IAo+IFRoaXMgaXMgYSBncmVhdCBzdWdnZXN0aW9uLCB0aGFua3MuIEkgdGhp
bmsgd2UgY2FuIGZpeCBpdCBpbiB0aGlzIHdheSB0bwo+IG1ha2UgY29kZSBzaW1wbGVyLiBUaGVu
IHRoZSBzcGVjaWZpYyBjYXJpbmcgb2YgcmVhbCBtb2RlIGluCj4gZWZpX2ZyZWVfYm9vdF9zZXJ2
aWNlcygpIGNhbiBiZSByZW1vdmVkIHRvby4KPiAKClRoaXMgd2hvbGUgc2l0dWF0aW9uIG1ha2Vz
IG1lIHRoaW5rIHRoYXQgdGhlIGNvZGUgaXMgYnVnZ3kgYmVmb3JlIGFuZCBidWdneSBhZnRlci4K
ClRoZSBpc3N1ZSBoZXJlIChJIHRoaW5rKSBpcyB0aGF0IHZhcmlvdXMgcGllY2VzIG9mIGNvZGUg
d2FudCB0byByZXNlcnZlIHNwZWNpZmljIHBpZWNlcyBvZiBvdGhlcndpc2UtYXZhaWxhYmxlIGxv
dyBtZW1vcnkgZm9yIHRoZWlyIG93biBuZWZhcmlvdXMgdXNlcy4gSSBkb27igJl0IGtub3cgKndo
eSogY3Jhc2gga2VybmVsIG5lZWRzIHRoaXMsIGJ1dCB0aGF0IGRvZXNu4oCZdCBtYXR0ZXIgdG9v
IG11Y2guCgpJIHByb3Bvc2UgdGhhdCB0aGUgcmlnaHQgc29sdXRpb24gaXMgdG8gZ2l2ZSBsb3ct
bWVtb3J5LXJlc2VydmluZyBjb2RlIHBhdGhzIHR3byBjaGFuY2VzIHRvIGRvIHdoYXQgdGhleSBu
ZWVkOiBvbmNlIGF0IHRoZSB2ZXJ5IGJlZ2lubmluZyBhbmQgb25jZSBhZnRlciBFRkkgYm9vdCBz
ZXJ2aWNlcyBhcmUgZnJlZWQuCgpBbHRlcm5hdGl2ZWx5LCBqdXN0IHJlc2VydmUgKmFsbCogb3Ro
ZXJ3aXNlIHVudXNlZCBzdWIgMU0gbWVtb3J5IHVwIGZyb250LCB0aGVuIHJlbGVhc2UgaXQgcmln
aHQgYWZ0ZXIgcmVsZWFzaW5nIGJvb3Qgc2VydmljZXMsIGFuZCB0aGVuIGludm9rZSB0aGUgc3Bl
Y2lhbCBjYXNlcyBleGFjdGx5IG9uY2UuCgpJbiBlaXRoZXIgY2FzZSwgdGhlIHJlc3VsdCBpcyB0
aGF0IHRoZSBjcmFzaGtlcm5lbCBtZXNzIGdldHMgdW5pZmllZCB3aXRoIHRoZSB0cmFtcG9saW5l
IG1lc3MuICBPbmUgd2F5IHRoZSByZXN1bHQgaXMgY2FsbGVkIHR3aWNlIGFuZCBuZWVkcyB0byBi
ZSBtb3JlIGNhcmVmdWwsIGFuZCB0aGUgb3RoZXIgd2F5IGl04oCZcyBjYWxsZWQgb25seSBvbmNl
LgoKSnVzdCBza2lwcGluZyBmcmVlaW5nIGJvb3Qgc2VydmljZXMgc2VlbXMgd3JvbmcuICBJdCBk
b2VzbuKAmXQgdW5tYXAgYm9vdCBzZXJ2aWNlcywgYW5kIHNraXBwaW5nIHRoYXQgaXMgaW5jb3Jy
ZWN0LCBJIHRoaW5rLiBBbmQgaXQgc2VlbXMgdG8gcmVzdWx0IGluIGEgYm9ndXMgbWVtb3J5IG1h
cCBpbiB3aGljaCB0aGUgc3lzdGVtIHRoaW5rcyB0aGF0IHNvbWUgY3Jhc2hrZXJuZWwgbWVtb3J5
IGlzIEVGSSBtZW1vcnkgaW5zdGVhZC4KCkxldOKAmXMgcGxlYXNlIGp1c3QgZml4IHRoZSBwcm9i
bGVtIGluc3RlYWQgb2YgcGFwZXJpbmcgb3ZlciBpdCB3aXRoIG1vcmUgaGFja3MuCgo+IFRoYW5r
cwo+IEJhb3F1YW4KPiAKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fCmtleGVjIG1haWxpbmcgbGlzdAprZXhlY0BsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6
Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8va2V4ZWMK
