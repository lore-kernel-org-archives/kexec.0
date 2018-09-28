Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1g5piL-0002pQ-Bg
 for kexec@lists.infradead.org; Fri, 28 Sep 2018 10:11:37 +0000
Subject: Re: [PATCH v7 RESEND 2/4] kexec: allocate unencrypted control pages
 for kdump in case SME is enabled
References: <20180927071954.29615-1-lijiang@redhat.com>
 <20180927071954.29615-3-lijiang@redhat.com> <20180927165323.GC19779@zn.tnic>
 <ef91c6cd-03dd-1a72-eea8-97d05d0ad370@redhat.com>
 <20180928075654.GA20768@zn.tnic>
From: lijiang <lijiang@redhat.com>
Message-ID: <2c5000d8-9f20-cc85-6d41-d6ece314c6ba@redhat.com>
Date: Fri, 28 Sep 2018 18:09:04 +0800
MIME-Version: 1.0
In-Reply-To: <20180928075654.GA20768@zn.tnic>
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
To: Borislav Petkov <bp@alien8.de>
Cc: thomas.lendacky@amd.com, jroedel@suse.de, brijesh.singh@amd.com, bhe@redhat.com, tiwai@suse.de, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, mingo@redhat.com, baiyaowei@cmss.chinamobile.com, hpa@zytor.com, bhelgaas@google.com, tglx@linutronix.de, dyoung@redhat.com, akpm@linux-foundation.org, dan.j.williams@intel.com

5ZyoIDIwMTjlubQwOeaciDI45pelIDE1OjU3LCBCb3Jpc2xhdiBQZXRrb3Yg5YaZ6YGTOgo+IE9u
IEZyaSwgU2VwIDI4LCAyMDE4IGF0IDExOjUyOjIxQU0gKzA4MDAsIGxpamlhbmcgd3JvdGU6Cj4+
IFRoZXJlIGFyZSB0d28gZnVuY3Rpb25zIHRoYXQgYXJlIHVzdWFsbHkgY2FsbGVkIGluIHBhaXJz
LCB0aGV5IGFyZToKPj4gYXJjaF9rZXhlY19wb3N0X2FsbG9jX3BhZ2VzKCkgYW5kIGFyY2hfa2V4
ZWNfcHJlX2ZyZWVfcGFnZXMoKS4KPj4KPj4gT25lIG1hcmtzIHRoZSBwYWdlcyBhcyBkZWNyeXB0
ZWQsIGFub3RoZXIgb25lIG1hcmtzIHRoZSBwYWdlcyBhcyBlbmNyeXB0ZWQuCj4+Cj4+IEJ1dCBm
b3IgdGhlIGNyYXNoIGNvbnRyb2wgcGFnZXMsIG5vIG5lZWQgdG8gY2FsbCBhcmNoX2tleGVjX3By
ZV9mcmVlX3BhZ2VzKCksCj4+IHRoZXJlIGFyZSB0aHJlZSByZWFzb25zOgo+PiAxLiBDcmFzaCBw
YWdlcyBhcmUgcmVzZXJ2ZWQgaW4gbWVtYmxvY2ssIHRoZXNlIHBhZ2VzIGFyZSBvbmx5IHVzZWQg
Ynkga2R1bXAsCj4+ICAgIG5vIG90aGVyIHBlb3BsZSB1c2VzIHRoZXNlIHBhZ2VzOwo+Pgo+PiAy
LiBXaGVuZXZlciBjcmFzaCBwYWdlcyBhcmUgYWxsb2NhdGVkLCB0aGVzZSBwYWdlcyBhcmUgYWx3
YXlzIG1hcmtlZCBhcwo+PiAgICBkZWNyeXB0ZWQod2hlbiBTTUUgaXMgYWN0aXZlKTsKPj4KPj4g
My4gSWYgd2UgcGxhbiB0byBjYWxsIHRoZSBhcmNoX2tleGVfcHJlX2ZyZWVfcGFnZXMoKSwgd2Ug
aGF2ZSB0byBzdG9yZSB0aGVzZQo+PiBwYWdlcyB0byBzb21ld2hlcmUsIHdoaWNoIHdpbGwgaGF2
ZSBtb3JlIGNvZGUgY2hhbmdlcy4KPiAKPiBJIGRvbid0IHRoaW5rIGFueSBvZiB0aGF0IGFuc3dl
cnMgdGhlIHF1ZXN0aW9uICp3aHkqIGNvbnRyb2wgcGFnZXMgZG8KPiBub3QgbmVlZCB0byBiZSBt
YXJrZWQgZW5jcnlwdGVkIGFnYWluLiBBbmQgSSB0aGluayB0aGUgcmVhc29uIGlzIHNpbXBsZToK
PiBiZWNhdXNlIHlvdSBkb24ndCByZWFsbHkgbmVlZCB0bywgYmVjYXVzZSBvbmNlIHRoZSBjcmFz
aCBrZXJuZWwgaXMgZG9uZSwKPiB5b3UgcmVib290IHRoZSBib3guCj4gClRoYW5rcyBmb3IgeW91
ciBjb21tZW50LCB5b3VyIGV4cGxhbmF0aW9uIGlzIHZlcnkgZ29vZC4KCkJ1dCB0aGVyZSBhcmUg
YW5vdGhlciBjYXNlcywgd2UgbWlnaHQgbG9hZCBvciB1bmxvYWQgdGhlIGNyYXNoIGtlcm5lbCBp
bWFnZSBhbmQKaW5pdHJhZm1zLCBtYXliZSBhZ2FpbiBhbmQgYWdhaW4gZm9yIHRlc3Qgb3IgZGVi
dWcsIHdlIGRvbid0IHJlYm9vdCBhdCBvbmNlLiBGb3IKZXhhbXBsZSwgcmVwZWF0IHRoZSBmb2xs
b3dpbmcgc3RlcHM6CgpzeXN0ZW1jdGwgc3RhcnQga2R1bXAuc2VydmljZQouLi4Kc3lzdGVtY3Rs
IHN0b3Aga2R1bXAuc2VydmljZQoKQnV0IHdlIGFsd2F5cyBtYXJrIHRoZXNlIHBhZ2VzIGFzIGRl
Y3J5cHRlZCB3aGVuZXZlciB0aGVzZSBjb250cm9sIHBhZ2VzIGFyZQphbGxvY2F0ZWQsIGJlY2F1
c2Ugb3RoZXIgcGVvcGxlIGNhbid0IHVzZSB0aGVzZSBwYWdlcyhyZXNlcnZlZCBtZW1vcnkpLCB3
aGljaAphcmUgb25seSB1c2VkIGJ5IGtkdW1wLCBzbyBubyBuZWVkIHRvIG1hcmsgdGhlc2UgcGFn
ZXMgYXMgZW5jcnlwdGVkIGFnYWluLgoKUmVnYXJkcywKTGlhbmJvCgpfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwprZXhlYyBtYWlsaW5nIGxpc3QKa2V4ZWNA
bGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xp
c3RpbmZvL2tleGVjCg==
