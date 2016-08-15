Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pf0-x22b.google.com ([2607:f8b0:400e:c00::22b])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bZMCy-0006Ww-2I
 for kexec@lists.infradead.org; Mon, 15 Aug 2016 18:01:57 +0000
Received: by mail-pf0-x22b.google.com with SMTP id h186so18841154pfg.3
 for <kexec@lists.infradead.org>; Mon, 15 Aug 2016 11:01:35 -0700 (PDT)
Subject: Re: [V4 PATCH 2/2] mips/panic: Replace smp_send_stop() with kdump
 friendly version in panic path
References: <20160810080946.11028.97686.stgit@sysi4-13.yrl.intra.hitachi.co.jp>
 <20160810080950.11028.28000.stgit@sysi4-13.yrl.intra.hitachi.co.jp>
 <20160812031755.GB2983@dhcp-128-65.nay.redhat.com>
 <57ADD55D.1050003@mvista.com>
 <04EAB7311EE43145B2D3536183D1A84454CBBB00@GSjpTKYDCembx31.service.hitachi.net>
 <a618ef9b-25d5-da8b-6829-ce124b76033e@mvista.com>
From: Corey Minyard <cminyard@mvista.com>
Message-ID: <95d06858-6874-d795-dca5-ec33bf33d5da@mvista.com>
Date: Mon, 15 Aug 2016 13:01:32 -0500
MIME-Version: 1.0
In-Reply-To: <a618ef9b-25d5-da8b-6829-ce124b76033e@mvista.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: =?UTF-8?B?5rKz5ZCI6Iux5a6PIC8gS0FXQUnvvIxISURFSElSTw==?= <hidehiro.kawai.ez@hitachi.com>, Dave Young <dyoung@redhat.com>
Cc: Daniel Walker <dwalker@fifo99.com>, "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>, Baoquan He <bhe@redhat.com>, David Daney <david.daney@cavium.com>, Xunlei Pang <xpang@redhat.com>, "x86@kernel.org" <x86@kernel.org>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Ralf Baechle <ralf@linux-mips.org>, HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>, "Eric W. Biederman" <ebiederm@xmission.com>, "Steven J. Hill" <steven.hill@cavium.com>, "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>, Aaro Koskinen <aaro.koskinen@iki.fi>, Andrew Morton <akpm@linux-foundation.org>, Vivek Goyal <vgoyal@redhat.com>, Masami Hiramatsu <mhiramat@kernel.org>

T24gMDgvMTUvMjAxNiAxMjowNiBQTSwgQ29yZXkgTWlueWFyZCB3cm90ZToKPiBPbiAwOC8xNS8y
MDE2IDA2OjM1IEFNLCDmsrPlkIjoi7Hlro8gLyBLQVdBSe+8jEhJREVISVJPIHdyb3RlOgo+PiBI
aSBDb3JleSwKPj4KPj4+IEZyb206IENvcmV5IE1pbnlhcmQgW21haWx0bzpjbWlueWFyZEBtdmlz
dGEuY29tXQo+Pj4gU2VudDogRnJpZGF5LCBBdWd1c3QgMTIsIDIwMTYgMTA6NTYgUE0KPj4+IEkn
bGwgdHJ5IHRvIHRlc3QgdGhpcywgYnV0IEkgaGF2ZSBvbmUgY29tbWVudCBpbmxpbmUuLi4KPj4g
VGhhbmsgeW91IHZlcnkgbXVjaCEKPj4KPj4+IE9uIDA4LzExLzIwMTYgMTA6MTcgUE0sIERhdmUg
WW91bmcgd3JvdGU6Cj4+Pj4gT24gMDgvMTAvMTYgYXQgMDU6MDlwbSwgSGlkZWhpcm8gS2F3YWkg
d3JvdGU6Cj4+IFtzbmlwXQo+Pj4+PiBkaWZmIC0tZ2l0IGEvYXJjaC9taXBzL2tlcm5lbC9jcmFz
aC5jIGIvYXJjaC9taXBzL2tlcm5lbC9jcmFzaC5jCj4+Pj4+IGluZGV4IDYxMGYwZjMuLjE3MjNi
MTcgMTAwNjQ0Cj4+Pj4+IC0tLSBhL2FyY2gvbWlwcy9rZXJuZWwvY3Jhc2guYwo+Pj4+PiArKysg
Yi9hcmNoL21pcHMva2VybmVsL2NyYXNoLmMKPj4+Pj4gQEAgLTQ3LDkgKzQ3LDE0IEBAIHN0YXRp
YyB2b2lkIGNyYXNoX3NodXRkb3duX3NlY29uZGFyeSh2b2lkIAo+Pj4+PiAqcGFzc2VkX3JlZ3Mp
Cj4+Pj4+Cj4+Pj4+ICAgIHN0YXRpYyB2b2lkIGNyYXNoX2tleGVjX3ByZXBhcmVfY3B1cyh2b2lk
KQo+Pj4+PiAgICB7Cj4+Pj4+ICsgICAgc3RhdGljIGludCBjcHVzX3N0b3BwZWQ7Cj4+Pj4+ICAg
ICAgICB1bnNpZ25lZCBpbnQgbXNlY3M7Cj4+Pj4+ICsgICAgdW5zaWduZWQgaW50IG5jcHVzOwo+
Pj4+Pgo+Pj4+PiAtICAgIHVuc2lnbmVkIGludCBuY3B1cyA9IG51bV9vbmxpbmVfY3B1cygpIC0g
MTsvKiBFeGNsdWRpbmcgdGhlIAo+Pj4+PiBwYW5pYyBjcHUgKi8KPj4+Pj4gKyAgICBpZiAoY3B1
c19zdG9wcGVkKQo+Pj4+PiArICAgICAgICByZXR1cm47Cj4+PiBXb3VsZG4ndCB5b3Ugd2FudCBh
biBhdG9taWMgb3BlcmF0aW9uIGFuZCBzb21lIHNwZWNpYWwgaGFuZGxpbmcgaGVyZSB0bwo+Pj4g
ZW5zdXJlIHRoYXQgb25seSBvbmUgQ1BVIGRvZXMgdGhpcz8gIFNvIGlmIGEgQ1BVIGNvbWVzIGlu
IGhlcmUgYW5kCj4+PiBhbm90aGVyIENQVSBpcyBhbHJlYWR5IGluIHRoZSBwcm9jZXNzIHN0b3Bw
aW5nIHRoZSBDUFVzIGl0IHdvbid0IAo+Pj4gcmVzdWx0IGluIGEKPj4+IGRlYWRsb2NrLgo+PiBC
ZWNhdXNlIHRoaXMgZnVuY3Rpb24gY2FuIGJlIGNhbGxlZCBvbmx5IG9uZSBwYW5pY2tpbmcgQ1BV
LAo+PiB0aGVyZSBpcyBubyBwcm9ibGVtLgo+Pgo+PiBUaGVyZSBhcmUgdHdvIHBhdGhzIHdoaWNo
IGNyYXNoX2tleGVjX3ByZXBhcmVfY3B1cyBpcyBjYWxsZWQuCj4+Cj4+IFBhdGggMSAocGFuaWMg
cGF0aCk6Cj4+IHBhbmljKCkKPj4gICAgY3Jhc2hfc21wX3NlbmRfc3RvcCgpCj4+ICAgICAgY3Jh
c2hfa2V4ZWNfcHJlcGFyZV9jcHVzKCkKPj4KPj4gUGF0aCAyIChvb3BzIHBhdGgpOgo+PiBjcmFz
aF9rZXhlYygpCj4+ICAgIF9fY3Jhc2hfa2V4ZWMoKQo+PiAgICAgIG1hY2hpbmVfY3Jhc2hfc2h1
dGRvd24oKQo+PiAgICAgICAgZGVmYXVsdF9tYWNoaW5lX2NyYXNoX3NodXRkb3duKCkgLy8gZm9y
IE1JUFMKPj4gICAgICAgICAgY3Jhc2hfa2V4ZWNfcHJlcGFyZV9jcHVzKCkKPj4KPj4gSGVyZSwg
cGFuaWMoKSBhbmQgY3Jhc2hfa2V4ZWMoKSBydW4gZXhjbHVzaXZlbHkgdmlhCj4+IHBhbmljX2Nw
dSBhdG9taWMgdmFyaWFibGUuICBTbyB3ZSBjYW4gdXNlIGNwdXNfc3RvcHBlZCBhcwo+PiBub3Jt
YWwgdmFyaWFibGUuCj4KPiBPaywgaWYgdGhlIGNvZGUgY2FuIG9ubHkgYmUgZW50ZXJlZCBvbmNl
LCB3aGF0J3MgdGhlIHB1cnBvc2Ugb2YgCj4gY3B1c19zdG9wcGVkPwo+IEkgZ3Vlc3MgdGhhdCdz
IHdoYXQgY29uZnVzZWQgbWUuICBZb3UgYXJlIHJpZ2h0LCB0aGUgcGFuaWNfY3B1IGF0b21pYyAK
PiBzaG91bGQKPiBrZWVwIHRoaXMgb24gYSBzaW5nbGUgQ1BVLgoKTmV2ZXIgbWluZCwgSSBzZWUg
dGhlIHBhdGggdGhyb3VnaCBwYW5pYygpIHdoZXJlIHRoYXQgaXMgcmVxdWlyZWQuIE15IApxdWVz
dGlvbgpiZWxvdyBzdGlsbCByZW1haW5zLCB0aG91Z2guCgotY29yZXkKCj4KPiBBbHNvLCBwYW5p
YygpIHdpbGwgY2FsbCBwYW5pY19zbXBfc2VsZl9zdG9wKCkgaWYgaXQgZmluZHMgYW5vdGhlciBD
UFUgCj4gaGFzIGFscmVhZHkKPiBjYWxsZWQgcGFuaWMsIHdoaWNoIHdpbGwganVzdCBzcGluIHdp
dGggaW50ZXJydXB0cyBvZmYgYnkgZGVmYXVsdC4gSSAKPiBkaWRuJ3Qgc2VlIGEKPiBkZWZpbml0
aW9uIGZvciBpdCBpbiBNSVBTLCB3b3VsZG4ndCBpdCBuZWVkIHRvIGJlIG92ZXJyaWRkZW4gdG8g
YXZvaWQgCj4gYSBkZWFkbG9jaz8KPgo+IC1jb3JleQo+Cj4+Cj4+IEJlc3QgcmVnYXJkcywKPj4K
Pj4gSGlkZWhpcm8gS2F3YWkKPj4KPgoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fCmtleGVjIG1haWxpbmcgbGlzdAprZXhlY0BsaXN0cy5pbmZyYWRlYWQu
b3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8va2V4ZWMK
