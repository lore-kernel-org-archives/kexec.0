Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pf0-x22c.google.com ([2607:f8b0:400e:c00::22c])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bZLM2-00073y-Pr
 for kexec@lists.infradead.org; Mon, 15 Aug 2016 17:07:15 +0000
Received: by mail-pf0-x22c.google.com with SMTP id x72so18508964pfd.2
 for <kexec@lists.infradead.org>; Mon, 15 Aug 2016 10:06:54 -0700 (PDT)
Subject: Re: [V4 PATCH 2/2] mips/panic: Replace smp_send_stop() with kdump
 friendly version in panic path
References: <20160810080946.11028.97686.stgit@sysi4-13.yrl.intra.hitachi.co.jp>
 <20160810080950.11028.28000.stgit@sysi4-13.yrl.intra.hitachi.co.jp>
 <20160812031755.GB2983@dhcp-128-65.nay.redhat.com>
 <57ADD55D.1050003@mvista.com>
 <04EAB7311EE43145B2D3536183D1A84454CBBB00@GSjpTKYDCembx31.service.hitachi.net>
From: Corey Minyard <cminyard@mvista.com>
Message-ID: <a618ef9b-25d5-da8b-6829-ce124b76033e@mvista.com>
Date: Mon, 15 Aug 2016 12:06:50 -0500
MIME-Version: 1.0
In-Reply-To: <04EAB7311EE43145B2D3536183D1A84454CBBB00@GSjpTKYDCembx31.service.hitachi.net>
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

T24gMDgvMTUvMjAxNiAwNjozNSBBTSwg5rKz5ZCI6Iux5a6PIC8gS0FXQUnvvIxISURFSElSTyB3
cm90ZToKPiBIaSBDb3JleSwKPgo+PiBGcm9tOiBDb3JleSBNaW55YXJkIFttYWlsdG86Y21pbnlh
cmRAbXZpc3RhLmNvbV0KPj4gU2VudDogRnJpZGF5LCBBdWd1c3QgMTIsIDIwMTYgMTA6NTYgUE0K
Pj4gSSdsbCB0cnkgdG8gdGVzdCB0aGlzLCBidXQgSSBoYXZlIG9uZSBjb21tZW50IGlubGluZS4u
Lgo+IFRoYW5rIHlvdSB2ZXJ5IG11Y2ghCj4KPj4gT24gMDgvMTEvMjAxNiAxMDoxNyBQTSwgRGF2
ZSBZb3VuZyB3cm90ZToKPj4+IE9uIDA4LzEwLzE2IGF0IDA1OjA5cG0sIEhpZGVoaXJvIEthd2Fp
IHdyb3RlOgo+IFtzbmlwXQo+Pj4+IGRpZmYgLS1naXQgYS9hcmNoL21pcHMva2VybmVsL2NyYXNo
LmMgYi9hcmNoL21pcHMva2VybmVsL2NyYXNoLmMKPj4+PiBpbmRleCA2MTBmMGYzLi4xNzIzYjE3
IDEwMDY0NAo+Pj4+IC0tLSBhL2FyY2gvbWlwcy9rZXJuZWwvY3Jhc2guYwo+Pj4+ICsrKyBiL2Fy
Y2gvbWlwcy9rZXJuZWwvY3Jhc2guYwo+Pj4+IEBAIC00Nyw5ICs0NywxNCBAQCBzdGF0aWMgdm9p
ZCBjcmFzaF9zaHV0ZG93bl9zZWNvbmRhcnkodm9pZCAqcGFzc2VkX3JlZ3MpCj4+Pj4KPj4+PiAg
ICBzdGF0aWMgdm9pZCBjcmFzaF9rZXhlY19wcmVwYXJlX2NwdXModm9pZCkKPj4+PiAgICB7Cj4+
Pj4gKwlzdGF0aWMgaW50IGNwdXNfc3RvcHBlZDsKPj4+PiAgICAJdW5zaWduZWQgaW50IG1zZWNz
Owo+Pj4+ICsJdW5zaWduZWQgaW50IG5jcHVzOwo+Pj4+Cj4+Pj4gLQl1bnNpZ25lZCBpbnQgbmNw
dXMgPSBudW1fb25saW5lX2NwdXMoKSAtIDE7LyogRXhjbHVkaW5nIHRoZSBwYW5pYyBjcHUgKi8K
Pj4+PiArCWlmIChjcHVzX3N0b3BwZWQpCj4+Pj4gKwkJcmV0dXJuOwo+PiBXb3VsZG4ndCB5b3Ug
d2FudCBhbiBhdG9taWMgb3BlcmF0aW9uIGFuZCBzb21lIHNwZWNpYWwgaGFuZGxpbmcgaGVyZSB0
bwo+PiBlbnN1cmUgdGhhdCBvbmx5IG9uZSBDUFUgZG9lcyB0aGlzPyAgU28gaWYgYSBDUFUgY29t
ZXMgaW4gaGVyZSBhbmQKPj4gYW5vdGhlciBDUFUgaXMgYWxyZWFkeSBpbiB0aGUgcHJvY2VzcyBz
dG9wcGluZyB0aGUgQ1BVcyBpdCB3b24ndCByZXN1bHQgaW4gYQo+PiBkZWFkbG9jay4KPiBCZWNh
dXNlIHRoaXMgZnVuY3Rpb24gY2FuIGJlIGNhbGxlZCBvbmx5IG9uZSBwYW5pY2tpbmcgQ1BVLAo+
IHRoZXJlIGlzIG5vIHByb2JsZW0uCj4KPiBUaGVyZSBhcmUgdHdvIHBhdGhzIHdoaWNoIGNyYXNo
X2tleGVjX3ByZXBhcmVfY3B1cyBpcyBjYWxsZWQuCj4KPiBQYXRoIDEgKHBhbmljIHBhdGgpOgo+
IHBhbmljKCkKPiAgICBjcmFzaF9zbXBfc2VuZF9zdG9wKCkKPiAgICAgIGNyYXNoX2tleGVjX3By
ZXBhcmVfY3B1cygpCj4KPiBQYXRoIDIgKG9vcHMgcGF0aCk6Cj4gY3Jhc2hfa2V4ZWMoKQo+ICAg
IF9fY3Jhc2hfa2V4ZWMoKQo+ICAgICAgbWFjaGluZV9jcmFzaF9zaHV0ZG93bigpCj4gICAgICAg
IGRlZmF1bHRfbWFjaGluZV9jcmFzaF9zaHV0ZG93bigpIC8vIGZvciBNSVBTCj4gICAgICAgICAg
Y3Jhc2hfa2V4ZWNfcHJlcGFyZV9jcHVzKCkKPgo+IEhlcmUsIHBhbmljKCkgYW5kIGNyYXNoX2tl
eGVjKCkgcnVuIGV4Y2x1c2l2ZWx5IHZpYQo+IHBhbmljX2NwdSBhdG9taWMgdmFyaWFibGUuICBT
byB3ZSBjYW4gdXNlIGNwdXNfc3RvcHBlZCBhcwo+IG5vcm1hbCB2YXJpYWJsZS4KCk9rLCBpZiB0
aGUgY29kZSBjYW4gb25seSBiZSBlbnRlcmVkIG9uY2UsIHdoYXQncyB0aGUgcHVycG9zZSBvZiAK
Y3B1c19zdG9wcGVkPwpJIGd1ZXNzIHRoYXQncyB3aGF0IGNvbmZ1c2VkIG1lLiAgWW91IGFyZSBy
aWdodCwgdGhlIHBhbmljX2NwdSBhdG9taWMgc2hvdWxkCmtlZXAgdGhpcyBvbiBhIHNpbmdsZSBD
UFUuCgpBbHNvLCBwYW5pYygpIHdpbGwgY2FsbCBwYW5pY19zbXBfc2VsZl9zdG9wKCkgaWYgaXQg
ZmluZHMgYW5vdGhlciBDUFUgCmhhcyBhbHJlYWR5CmNhbGxlZCBwYW5pYywgd2hpY2ggd2lsbCBq
dXN0IHNwaW4gd2l0aCBpbnRlcnJ1cHRzIG9mZiBieSBkZWZhdWx0LiBJIApkaWRuJ3Qgc2VlIGEK
ZGVmaW5pdGlvbiBmb3IgaXQgaW4gTUlQUywgd291bGRuJ3QgaXQgbmVlZCB0byBiZSBvdmVycmlk
ZGVuIHRvIGF2b2lkIGEgCmRlYWRsb2NrPwoKLWNvcmV5Cgo+Cj4gQmVzdCByZWdhcmRzLAo+Cj4g
SGlkZWhpcm8gS2F3YWkKPgoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fCmtleGVjIG1haWxpbmcgbGlzdAprZXhlY0BsaXN0cy5pbmZyYWRlYWQub3JnCmh0
dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8va2V4ZWMK
