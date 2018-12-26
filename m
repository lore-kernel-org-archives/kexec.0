Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gc2TD-0003YB-B5
 for kexec@lists.infradead.org; Wed, 26 Dec 2018 06:15:08 +0000
Subject: Re: [PATCH 1/2 v3] kdump: add the vmcoreinfo documentation
References: <20181216131617.2612-1-lijiang@redhat.com>
 <20181216131617.2612-2-lijiang@redhat.com> <20181217130024.GD12165@zn.tnic>
 <826c1a6b-41da-bc1a-f9c2-0d52e774b572@redhat.com>
 <20181226032433.GB13556@dhcp-128-65.nay.redhat.com>
 <20181226033658.GB13822@dhcp-128-65.nay.redhat.com>
From: lijiang <lijiang@redhat.com>
Message-ID: <c64a0459-e715-0e10-c674-c50570f32f08@redhat.com>
Date: Wed, 26 Dec 2018 14:14:40 +0800
MIME-Version: 1.0
In-Reply-To: <20181226033658.GB13822@dhcp-128-65.nay.redhat.com>
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
To: Dave Young <dyoung@redhat.com>
Cc: bhe@redhat.com, linux-doc@vger.kernel.org, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Kazuhito Hagio <khagio@redhat.com>, mingo@redhat.com, Borislav Petkov <bp@alien8.de>, anderson@redhat.com, tglx@linutronix.de, akpm@linux-foundation.org

5ZyoIDIwMTjlubQxMuaciDI25pelIDExOjM2LCBEYXZlIFlvdW5nIOWGmemBkzoKPiBPbiAxMi8y
Ni8xOCBhdCAxMToyNGFtLCBEYXZlIFlvdW5nIHdyb3RlOgo+Pj4+PiArCj4+Pj4+ICtLRVJORUxf
SU1BR0VfU0laRQo+Pj4+PiArPT09PT09PT09PT09PT09PT0KPj4+Pj4gK1RoZSBzaXplIG9mICdL
RVJORUxfSU1BR0VfU0laRScsIGN1cnJlbnRseSB1bnVzZWQuCj4+Pj4KPj4+PiBTbyByZW1vdmU/
Cj4+Pj4KPj4+Cj4+PiBJJ20gbm90IHN1cmUgd2hldGhlciBpdCBzaG91bGQgYmUgcmVtb3ZlZCwg
c28gaSBrZWVwIGl0Lgo+Pgo+PiBKdXN0IHJlbW92ZSBpdC4gIEl0IHdhcyBhZGRlZCBieSBCYW9x
dWFuIGZvciBLQVNMUiBpc3N1ZXMsIGxhdGVyCj4+IG1ha2VkdW1wZmlsZSByZXZlcnRlZCB0aGUg
dXNlcnNwYWNlIHBhcnQgYW5kIGFkZGVkIG90aGVyIGltcGxlbWVudGF0aW9uLgo+Pgo+PiBJbiBj
YXNlIG9sZCBtYWtlZHVtcGZpbGUgZG9lcyBub3Qgc3VwcG9ydCBuZXcga2VybmVsLCBpdCBoYXMg
c29tZSBrZXJuZWwKPj4gdmVyc2lvbnMgc3VwcG9ydCBsaXN0IGluIGNvZGUsIHRodXMgbm8gd29y
cnkgYWJvdXQgdGhlIGNvbXBhdGliaWxpdHkKPj4gaXNzdWUuCj4gCj4gQWgsIGl0IGlzIG5vdCB1
bnVzZWQgYWN0dWFsbHksIGNsb25lIGNyYXNoIHRvb2wgZ2l0Ogo+ICQgZ2l0IGdyZXAgS0VSTkVM
X0lNQUdFX1NJWkUKPiB4ODZfNjQuYzogICAgICAgICAgICAgICBpZiAoKHN0cmluZyA9IHBjLT5y
ZWFkX3ZtY29yZWluZm8oIk5VTUJFUihLRVJORUxfSU1BR0VfU0laRSkiKSkpIHsKPiAKPiBTbyBp
biB0aGUgZG9jdW1lbnRhdGlvbiwgdGhlIHVzZSBjYXNlcyBvZiBjcmFzaCB0b29sIHNob3VsZCBh
bHNvIGJlCj4gY292ZXJlZC4KPiAKClN1cmUsIG1heWJlIG9ubHkgdGhpcyBvbmUgd2FzIGlnbm9y
ZWQuCgpJIHdpbGwgaW1wcm92ZSB0aGlzIHZhcmlhYmxlIGluIHRoZSBkb2N1bWVudGF0aW9uLgoK
PiBMaWFuYm8sIGl0IHdvdWxkIGJlIGdvb2QgdG8gY2MgRGF2ZSBhbmQgS2F6dSBmb3IgdGhlc2Ug
cGF0Y2hlcywgY291bGQKPiB5b3UgY2MgdGhlbSBpbiB5b3VyIG5leHQgcG9zdD8KPiAKClllcywg
aSB3aWxsIGFkZCBEYXZlIGFuZCBLYXp1LCBhbmQgYWxzbyByZXNlbmQgcGF0Y2ggdjQuCgpUaGFu
a3MuCgo+Pgo+PiBUaGFua3MKPj4gRGF2ZQo+IAo+IFRoYW5rcwo+IERhdmUKPiAKCl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmtleGVjIG1haWxpbmcgbGlz
dAprZXhlY0BsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21h
aWxtYW4vbGlzdGluZm8va2V4ZWMK
