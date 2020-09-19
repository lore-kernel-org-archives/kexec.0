Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kJgpl-0006yY-R6
 for kexec@lists.infradead.org; Sat, 19 Sep 2020 17:39:40 +0000
Received: by mail-pf1-x442.google.com with SMTP id o20so5555959pfp.11
 for <kexec@lists.infradead.org>; Sat, 19 Sep 2020 10:39:37 -0700 (PDT)
From: Andy Lutomirski <luto@amacapital.net>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH 1/4] x86: add __X32_COND_SYSCALL() macro
Date: Sat, 19 Sep 2020 10:39:32 -0700
Message-Id: <027BAF5D-1473-4A35-8A58-D80315D52073@amacapital.net>
References: <85F32523-4E9E-443A-A150-10A9E5EB0CE3@zytor.com>
In-Reply-To: <85F32523-4E9E-443A-A150-10A9E5EB0CE3@zytor.com>
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
To: hpa@zytor.com
Cc: linux-arch <linux-arch@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Brian Gerst <brgerst@gmail.com>, kexec@lists.infradead.org, LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>, Christoph Hellwig <hch@infradead.org>, Linux-MM <linux-mm@kvack.org>, Borislav Petkov <bp@alien8.de>, Eric Biederman <ebiederm@xmission.com>, Andy Lutomirski <luto@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Christoph Hellwig <hch@lst.de>, Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Alexander Viro <viro@zeniv.linux.org.uk>

Cj4gT24gU2VwIDE5LCAyMDIwLCBhdCAxMDoxNCBBTSwgaHBhQHp5dG9yLmNvbSB3cm90ZToKPiAK
PiDvu79PbiBTZXB0ZW1iZXIgMTksIDIwMjAgOToyMzoyMiBBTSBQRFQsIEFuZHkgTHV0b21pcnNr
aSA8bHV0b0BrZXJuZWwub3JnPiB3cm90ZToKPj4+IE9uIEZyaSwgU2VwIDE4LCAyMDIwIGF0IDEw
OjM1IFBNIENocmlzdG9waCBIZWxsd2lnIDxoY2hAaW5mcmFkZWFkLm9yZz4KPj4+IHdyb3RlOgo+
Pj4gCj4+PiBPbiBGcmksIFNlcCAxOCwgMjAyMCBhdCAwMzoyNDozNlBNICswMjAwLCBBcm5kIEJl
cmdtYW5uIHdyb3RlOgo+Pj4+IHN5c19tb3ZlX3BhZ2VzKCkgaXMgYW4gb3B0aW9uYWwgc3lzY2Fs
bCwgYW5kIG9uY2Ugd2UgcmVtb3ZlCj4+Pj4gdGhlIGNvbXBhdCB2ZXJzaW9uIG9mIGl0IGluIGZh
dm9yIG9mIHRoZSBuYXRpdmUgb25lIHdpdGggYW4KPj4+PiBpbl9jb21wYXRfc3lzY2FsbCgpIGNo
ZWNrLCB0aGUgeDMyIHN5c2NhbGwgdGFibGUgcmVmZXJzIHRvCj4+Pj4gYSBfX3gzMl9zeXNfbW92
ZV9wYWdlcyBzeW1ib2wgdGhhdCBtYXkgbm90IGV4aXN0IHdoZW4gdGhlCj4+Pj4gc3lzY2FsbCBp
cyBkaXNhYmxlZC4KPj4+PiAKPj4+PiBDaGFuZ2UgdGhlIENPTkRfU1lTQ0FMTCgpIGRlZmluaXRp
b24gb24geDg2IHRvIGFsc28gaW5jbHVkZQo+Pj4+IHRoZSByZWRpcmVjdGlvbiBmb3IgeDMyLgo+
Pj4+IAo+Pj4+IFNpZ25lZC1vZmYtYnk6IEFybmQgQmVyZ21hbm4gPGFybmRAYXJuZGIuZGU+Cj4+
PiAKPj4+IEFkZGluZyB0aGUgeDg2IG1haW50YWluZXJzIGFuZCBCcmlhbiBHZXJzdC4gIEJyaWFu
IHByb3Bvc2VkIGFub3RoZXIKPj4+IHByb2JsZW0gdG8gdGhlIG1lc3MgdGhhdCBtb3N0IG9mIHRo
ZSBjb21wYXQgc3lzY2FsbCBoYW5kbGVycyB1c2VkIGJ5Cj4+PiB4MzIgaGVyZToKPj4+IAo+Pj4g
ICBodHRwczovL2xrbWwub3JnL2xrbWwvMjAyMC82LzE2LzY2NAo+Pj4gCj4+PiBocGEgZGlkbid0
IHBhcnRpY3VsYXJseSBsaWtlIGl0LCBidXQgd2l0aCB5b3VyIGFuZCBteSBwZW5kaW5nIHNlcmll
cwo+Pj4gd2UnbGwgc29vbiB1c2UgbW9yZSBuYXRpdmUgdGhhbiBjb21wYXQgc3lzY2FsbHMgZm9y
IHgzMiwgc28gc29tZXRoaW5nCj4+PiB3aWxsIG5lZWQgdG8gY2hhbmdlLi4KPj4gCj4+IEknbSBm
aW5lIHdpdGggZWl0aGVyIHNvbHV0aW9uLgo+IAo+IE15IG1haW4gb2JqZWN0aW9uIHdhcyBuYW1p
bmcuIHg2NCBpcyBhIHdpZGVseSB1c2VkIHN5bm9ueW0gZm9yIHg4Ni02NCwgYW5kIHNvIHRoYXQg
aXMgY29uZnVzaW5nLgo+IAo+IAoKVGhlIHdheSBJIGRlYWwgd2l0aCB0aGUgc3lzY2FsbCB3cmFw
cGVycyBpcyB0aGF0IEkgYXNzdW1lIHRoZSBuYW1pbmcgbWFrZXMgbm8gc2Vuc2Ugd2hhdHNvZXZl
ciwgYW5kIEkgZ28gZnJvbSB0aGVyZS4gV2l0aCB0aGlzIHBlcnNwZWN0aXZlLCB0aGUgcGF0Y2hl
cyBhcmUgbmVpdGhlciBhbiBpbXByb3ZlbWVudCBub3IgYSB3b3JzZW5pbmcgb2YgdGhlIGN1cnJl
bnQgc2l0dWF0aW9uLgoKKFNpbWlsYXJseSwgdGhlIGxhc3QgY29sdW1uIG9mIHRoZSB0YWJsZXMg
aXMgdXNlbGVzcyBnYXJiYWdlLiAgTXkgbGFzdCBhdHRlbXB0IHRvIGZpeCB0aGF0IHN0YWxsZWQu
KQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwprZXhlYyBt
YWlsaW5nIGxpc3QKa2V4ZWNAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFk
ZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2tleGVjCg==
