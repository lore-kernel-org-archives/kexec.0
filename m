Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gHgDY-0008TU-85
 for kexec@lists.infradead.org; Wed, 31 Oct 2018 02:26:49 +0000
Subject: Re: [PATCH] kdump, vmcoreinfo: Export sme_me_mask value to vmcoreinfo
References: <20181029083118.GC1884@MiWiFi-R3L-srv>
 <d6f93848-c750-f29c-4ca7-9661596cad62@redhat.com>
 <20181029095738.GB20101@zn.tnic>
 <15897206-c1a6-ced6-3a1b-f71da8fc9c83@redhat.com>
 <20181029114414.GA11408@MiWiFi-R3L-srv>
 <90385882-7fd1-a674-ec5a-19bd42471a5e@redhat.com>
 <20181029134918.GB32150@zn.tnic>
 <699ab34e-1373-582d-4e58-e76bd57ec34f@redhat.com>
 <20181030050900.GA25987@dhcp-128-65.nay.redhat.com>
 <20181030091542.GD32102@zn.tnic> <20181030092314.GC14493@MiWiFi-R3L-srv>
From: lijiang <lijiang@redhat.com>
Message-ID: <dcbc925f-6935-6a34-fde1-7aa1ea378891@redhat.com>
Date: Wed, 31 Oct 2018 10:26:23 +0800
MIME-Version: 1.0
In-Reply-To: <20181030092314.GC14493@MiWiFi-R3L-srv>
Content-Language: en-US
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
To: Baoquan He <bhe@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Young <dyoung@redhat.com>
Cc: Petr Tesarik <ptesarik@suse.cz>, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, mingo@redhat.com, tglx@linutronix.de

5ZyoIDIwMTjlubQxMOaciDMw5pelIDE3OjIzLCBCYW9xdWFuIEhlIOWGmemBkzoKPiAKPiBIaSBC
b3JpcywgRGF2ZVkgYW5kIExpYW5ibywKPiAKPiBPbiAxMC8zMC8xOCBhdCAxMDoxNWFtLCBCb3Jp
c2xhdiBQZXRrb3Ygd3JvdGU6Cj4+IE9uIFR1ZSwgT2N0IDMwLCAyMDE4IGF0IDAxOjA5OjAwUE0g
KzA4MDAsIERhdmUgWW91bmcgd3JvdGU6Cj4+PiBJdCBpcyBub3QgdGhlIGNvbnRlbnQsIEkgdGhp
bmsgaXQgaXMgYSBnb29kIGNhdGNoIGZyb20gQm9yaXMsIGl0IHdvdWxkCj4+PiBiZSBnb29kIHRv
IGRvY3VtZW50IHRoZSBleHBvcnRlZCB0aGluZ3MgaW4gc29tZXdoZXJlIGVnLgo+Pj4gRG9jdW1l
bnRhdGlvbi9rZHVtcC92bWNvcmVpbmZvLnR4dAo+IAo+IEZvciB0aGUgdm1jb3JlaW5mbyB2YXJp
YWJsZXMgZG9jdW1lbnQsIEkgcGVyc29uYWxseSB0aGluayBpdCBtaWdodCBiZQo+IG5vdCBuZWNl
c3NhcnkuIFRoZSByZWFzb24gaXMgdGhhdCBhbGwgdGhlIG9sZCB2YXJpYWxibGVzIGFyZSBleHBv
cnRlZAo+IHdpdGggdGhlIG5hbWUgb2YgdGhlbXNlbHZlcy4gV2Uga25vdyB3aGF0IHRoZXkgYXJl
IG9yIHdoYXQgdGhleQo+IHJlcHJlc2VudCBzaW5jZSB0aGV5IGFyZSBhbGwga2VybmVsIHN5bWJv
bHMgb3IgbWFjcm8uIE9ubHkgdGhpcyBtZV9tYXNrLAo+IGl0J3MgYSBsb2NhbCB2YXJpYWJsZSBh
bmQgc3RvcmUgdGhlIHZhbHVlIG9mIHNtZV9tZV9tYXNrIGZvciBub3csIG1heQo+IHN0b3JlIG1v
cmUgaW5mbyBsYXRlciBsaWtlIFBldHIgbWVudGlvbmVkLCBhbmQgYWxzbyB3aWxsIHN0b3JlIHRo
ZSBtZW1vcnkKPiBlbmNyeXB0aW9uIGluZm9ybWF0aW9uIG9mIFRNRSAod2hpY2ggaXMgaW50ZWwn
cyB0cmFuc3BhcmVudCBtZW1vcnkgZW5jcnlwdGlvbikuCj4gV2UgY2FuIGFkZCBjb2RlIGNvbW1l
bnQgYXJvdW5kIHRvIHRlbGwgdGhlc2UuCj4gClRoYW5rIHlvdSwgZXZlcnlvbmUuCgpJIHBlcnNv
bmFsbHkgYWdyZWUgd2l0aCBCYW9xdWFuJ3Mgb3Bpbmlvbi4gV2hhdCBkbyB5b3UgdGhpbmsgYWJv
dXQ/IEJvcmlzIGFuZCBvdGhlciByZXZpZXdlcj8KCklmIHRoZSB2bWNvcmVpbmZvIGRvY3VtZW50
IGlzIG5lY2Vzc2FyeSwgd291bGQgeW91IGxpa2UgdG8gaGVscCBtZSB0byBwcm92aWRlIGFuIG91
dGxpbmU/CkkgY2FuIHRyeSBteSBiZXN0IHRvIHdyaXRlIHRoZSBkb2N1bWVudC4KCkFueXdheSwg
d2Ugc2hvdWxkIG1ha2UgYSBjaG9pY2UuCgpSZWdhcmRzLApMaWFuYm8KCj4gUGVyc29uYWwgb3Bp
bmlvbi4KPiAKPiBUaGFua3MKPiBCYW9xdWFuCj4gCgpfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwprZXhlYyBtYWlsaW5nIGxpc3QKa2V4ZWNAbGlzdHMuaW5m
cmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2tl
eGVjCg==
