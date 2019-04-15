Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1hG0dL-00070L-3u
 for kexec@lists.infradead.org; Mon, 15 Apr 2019 12:22:48 +0000
Subject: Re: [PATCH 1/2 RESEND v10] x86/mm, resource: add a new I/O resource
 descriptor 'IORES_DESC_RESERVED'
References: <20190329123914.20939-1-lijiang@redhat.com>
 <20190329123914.20939-2-lijiang@redhat.com> <20190402090652.GD6826@zn.tnic>
 <c94f887e-2ac8-49c6-e02c-92453e1ad894@redhat.com>
 <20190402124328.GG6826@zn.tnic>
From: lijiang <lijiang@redhat.com>
Message-ID: <384ba880-1b53-8013-8be8-66f294c27100@redhat.com>
Date: Mon, 15 Apr 2019 20:22:22 +0800
MIME-Version: 1.0
In-Reply-To: <20190402124328.GG6826@zn.tnic>
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
Cc: Thomas.Lendacky@amd.com, x86@kernel.org, bhe@redhat.com, peterz@infradead.org, dave.hansen@linux.intel.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, mingo@redhat.com, luto@kernel.org, hpa@zytor.com, tglx@linutronix.de, dyoung@redhat.com, akpm@linux-foundation.org

5ZyoIDIwMTnlubQwNOaciDAy5pelIDIwOjQzLCBCb3Jpc2xhdiBQZXRrb3Yg5YaZ6YGTOgo+IE9u
IFR1ZSwgQXByIDAyLCAyMDE5IGF0IDA4OjAyOjA0UE0gKzA4MDAsIGxpamlhbmcgd3JvdGU6Cj4+
IFRoZXNlIHJlZ2lvbnMoRTgyMF9UWVBFX3tSRVNFUlZFRF9LRVJOLFJBTSxVTlVTQUJMRX0pIGFy
ZSBzdGlsbCBtYXJrZWQgYXMKPj4gSU9SRVNfREVTQ19OT05FIGFuZCBzaG91bGQgbm90IGJlIG1h
cHBlZCBlbmNyeXB0ZWQgd2hlbiB1c2luZyBpb3JlbWFwKCkuCj4gCj4gU2VlbXMgdG8gbWUgbGlr
ZSB3ZSdyZSBnb2luZyBpbiBjaXJjbGVzLiBZb3Ugc2FpZCBoZXJlOgo+IAo+IGh0dHBzOi8vbGtt
bC5rZXJuZWwub3JnL3IvOWViNjE1MjMtN2EwOC0yNGM0LWFjMTUtMDUwNTM3YmQ5MjAzQHJlZGhh
dC5jb20KPiAKPiB0aGF0IHRoZSBrZXJuZWwgZG9lc24ndCBwYXNzIHRoZSBlODIwIHJlc2VydmVk
IHJhbmdlcyB0byB0aGUgc2Vjb25kCj4ga2VybmVsLgo+IAo+IEkgc3VnZ2VzdGVkIHRvIHVzZSBh
IHNwZWNpYWwgSU9SRVMgZGVzY3JpcHRvciBmb3IgdGhlbSAtCj4gSU9SRVNfREVTX1JFU0VSVkVE
Lgo+IAo+IE5vdyB5b3Ugc2F5IHRoYXQgdGhhdCBpcyBub3QgZW5vdWdoIGFuZCBzb21lIG9mIHRo
b3NlIHlvdSB3YW50IHBhc3NlZCwKPiBhcmUgc3RpbGwgbWFya2VkIGFzIElPUkVTX0RFU0NfTk9O
RS4KPiAKU29ycnkgZm9yIHRoZSBkZWxheS4KClRoZXkgYXJlIGRpZmZlcmVudCBwcm9ibGVtcy4K
ClRoZSBmaXJzdCBwcm9ibGVtIGlzIHRoYXQgcGFzc2VzIHRoZSBlODIwIHJlc2VydmVkIHJhbmdl
cyB0byB0aGUgc2Vjb25kIGtlcm5lbCwKZm9yIHRoaXMgY2FzZSwgaXQgaXMgZ29vZCBlbm91Z2gg
dG8gdXNlIHRoZSBJT1JFU19ERVNDX1JFU0VSVkVELCB3aGljaCBjYW4KZW5zdXJlIHRoYXQgZXhh
Y3RseSBtYXRjaGVzIHRoZSByZXNlcnZlZCByZXNvdXJjZSByYW5nZXMgd2hlbiB3YWxraW5nIHRo
cm91Z2gKaW9tZW0gcmVzb3VyY2VzLgoKVGhlIHNlY29uZCBwcm9ibGVtIGlzIGFib3V0IHRoZSBT
RVYgY2FzZS4gTm93LCB0aGUgSU9SRVNfREVTQ19SRVNFUlZFRCBoYXMgYmVlbgpjcmVhdGVkIGZv
ciB0aGUgcmVzZXJ2ZWQgYXJlYXMsIHRoZXJlZm9yZSB0aGUgY2hlY2sgbmVlZHMgdG8gYmUgZXhw
YW5kZWQgc28gdGhhdAp0aGVzZSBhcmVhcyBhcmUgbm90IG1hcHBlZCBlbmNyeXB0ZWQgd2hlbiB1
c2luZyBpb3JlbWFwKCkuCgorc3RhdGljIGludCBfX2lvcmVtYXBfY2hlY2tfZGVzY19ub25lX2Fu
ZF9yZXNlcnZlZChzdHJ1Y3QgcmVzb3VyY2UgKnJlcykKIHsKLSAgICAgICByZXR1cm4gKHJlcy0+
ZGVzYyAhPSBJT1JFU19ERVNDX05PTkUpOworICAgICAgIHJldHVybiAoKHJlcy0+ZGVzYyAhPSBJ
T1JFU19ERVNDX05PTkUpICYmCisgICAgICAgICAgICAgICAocmVzLT5kZXNjICE9IElPUkVTX0RF
U0NfUkVTRVJWRUQpKTsKIH0KCgpNYXliZSBpIHNob3VsZCBzcGxpdCBpdCBpbnRvIHR3byBwYXRj
aGVzLiBUaGUgY2hhbmdlIG9mIF9faW9yZW1hcF9jaGVja19kZXNjX25vbmVfYW5kX3Jlc2VydmVk
KCkKc2hvdWxkIGJlIGEgc2VwYXJhdGUgcGF0Y2guIEFueSBpZGVhPwoKVGhhbmtzLgpMaWFuYm8K
Cj4gU291bmRzIHRvIG1lIGxpa2UgeW91IG5lZWQgdHJ5IGFnYWluLgo+CgpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwprZXhlYyBtYWlsaW5nIGxpc3QKa2V4
ZWNAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFu
L2xpc3RpbmZvL2tleGVjCg==
