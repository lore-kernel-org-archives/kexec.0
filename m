Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-qy0-f177.google.com ([209.85.216.177])
	by bombadil.infradead.org with esmtp (Exim 4.72 #1 (Red Hat Linux))
	id 1OoGaO-00057Z-Q4
	for kexec@lists.infradead.org; Wed, 25 Aug 2010 14:04:17 +0000
Received: by qyk8 with SMTP id 8so599500qyk.15
	for <kexec@lists.infradead.org>; Wed, 25 Aug 2010 07:04:15 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <2026062630.609651277992034780.JavaMail.root@zmail05.collab.prod.int.phx2.redhat.com>
References: <1274198794.609431277991897515.JavaMail.root@zmail05.collab.prod.int.phx2.redhat.com>
	<2026062630.609651277992034780.JavaMail.root@zmail05.collab.prod.int.phx2.redhat.com>
Date: Wed, 25 Aug 2010 22:04:15 +0800
Message-ID: <AANLkTin6_4f5FWv_XYXw1TMUL-1-r6QFBiN-YYfg2jwi@mail.gmail.com>
Subject: Re: [PATCH 0/4] crash utility: add ARM crashdump support
From: Lei Wen <adrian.wenl@gmail.com>
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Dave Anderson <anderson@redhat.com>
Cc: kexec@lists.infradead.org, Mika Westerberg <ext-mika.1.westerberg@nokia.com>, "Discussion list for crash utility usage,
	maintenance and development" <crash-utility@redhat.com>

SGkgRGF2ZSwKCldoYXQgdGhlIHN0YXR1cyBvZiB0aGlzIHBhdGNoIHNlcmllcyBub3c/IENvdWxk
IGNyYXNoIHV0aWxpdGllcwpzdXBwb3J0IGFuYWx5emluZyBhcm0gbWFjaGluZSBjb3JlIGR1bXAg
aW4gdGhlIHg4NiBob3N0PwpUaGlzIGlzIHZlcnkgdXNlZnVsIGZlYXR1cmUsIHNpbmNlIHRoZSBh
cm0ga2VybmVsIGFscmVhZHkgc3VwcG9ydCB0aGUKY29yZSBkdW1wIGJ5IGtkdW1wIGVuYWJsZWQu
CgpUaGFua3MsCkxlaQoKT24gVGh1LCBKdWwgMSwgMjAxMCBhdCA5OjQ3IFBNLCBEYXZlIEFuZGVy
c29uIDxhbmRlcnNvbkByZWRoYXQuY29tPiB3cm90ZToKPgo+IC0tLS0tICJNaWthIFdlc3RlcmJl
cmciIDxleHQtbWlrYS4xLndlc3RlcmJlcmdAbm9raWEuY29tPiB3cm90ZToKPj4KPj4gT24gV2Vk
LCBKdW4gMzAsIDIwMTAgYXQgMDM6MTA6NThQTSArMDIwMCwgZXh0IERhdmUgQW5kZXJzb24gd3Jv
dGU6Cj4+Cj4+ID4gSW4gYW55IGNhc2UsIEknbSBtb3JlIHRoYW4gaGFwcHkgdG8gZm9sZCBpbiBB
Uk0gc3VwcG9ydCwgYnV0IEkgZG9uJ3Qga25vdyB3aGF0Cj4+ID4gdG8gZG8gaW4gdGhpcyBjYXNl
Lgo+PiA+Cj4+ID4gSSB3b25kZXIgaWYgaXQgd291bGQgaXQgYmUgcG9zc2libGUgZm9yIHlvdSwg
SmFuIGFuZCBUaG9tYXMgdG8gc29tZWhvdyBjb2xsYWJvcmF0ZQo+PiA+IG9uIHRoaXMgZWZmb3J0
PyDCoEl0IHNlZW1zIHRoYXQgYm90aCBzaWRlcyB3b3VsZCBiZW5lZml0IGZyb20gdGhlIHdvcmsg
b2YgdGhlIG90aGVyCj4+ID4gc2lkZS4gwqBJJ3ZlIGFkZGVkIHRoZW0gdG8gdGhlIGNjIGxpc3Qu
Cj4+Cj4+IFN1cmUuIENhbiB0aG9zZSBwYXRjaGVzIGJlIGZvdW5kIGluIHNvbWUgcHVibGljIE1M
PyBJIHF1aWNrbHkgc2VhcmNoZWQgYnV0Cj4+IGNvdWxkbid0IGZpbmQgYW55dGhpbmcuCj4+Cj4+
IFJlZ2FyZHMsCj4+IE1XCj4KPiBKYW4gaXMgY29udGFjdGluZyB5b3Ugb2ZmLWxpc3QuCj4KPiBU
aGFua3MsCj4gwqBEYXZlCj4KPiBfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwo+IGtleGVjIG1haWxpbmcgbGlzdAo+IGtleGVjQGxpc3RzLmluZnJhZGVhZC5v
cmcKPiBodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2tleGVjCj4K
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmtleGVjIG1h
aWxpbmcgbGlzdAprZXhlY0BsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRl
YWQub3JnL21haWxtYW4vbGlzdGluZm8va2V4ZWMK
