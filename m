Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UK24F-0003p8-IC
 for kexec@lists.infradead.org; Mon, 25 Mar 2013 07:43:44 +0000
Message-ID: <514FFFD1.5080704@cn.fujitsu.com>
Date: Mon, 25 Mar 2013 15:42:09 +0800
From: Zhang Yanfei <zhangyanfei@cn.fujitsu.com>
MIME-Version: 1.0
Subject: Re: [PATCH] kexec: lengthen the kernel command line image
References: <E1U2S71-00057C-Hj@eag09.americas.sgi.com>
 <20130305015127.GA28547@verge.net.au>
In-Reply-To: <20130305015127.GA28547@verge.net.au>
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
To: Simon Horman <horms@verge.net.au>
Cc: kexec@lists.infradead.org, Cliff Wickman <cpw@sgi.com>

5LqOIDIwMTPlubQwM+aciDA15pelIDA5OjUxLCBTaW1vbiBIb3JtYW4g5YaZ6YGTOgo+IE9uIE1v
biwgRmViIDA0LCAyMDEzIGF0IDAxOjUzOjU1UE0gLTA2MDAsIENsaWZmIFdpY2ttYW4gd3JvdGU6
Cj4+IEZyb206IENsaWZmIFdpY2ttYW4gPGNwd0BzZ2kuY29tPgo+Pgo+PiBUaGUgY3Jhc2gga2Vy
bmVsJ3MgYm9vdCBjb21tYW5kIGxpbmUgaXMgbm90IGxvbmcgZW5vdWdoIHRvIGNvbnRhaW4gdGhl
Cj4+IG5lY2Vzc2FyeSBtZW1tYXA9IG9wdGlvbnMgZm9yIGEgbGFyZ2UgbWVtb3J5Lgo+Pgo+PiBU
aGUgZml4IGlzIHNpbXBsZSwgYXMgbG9uZyBhcyB0aGUgYm9vdCBsb2FkZXIncyBjb21tYW5kIGxp
bmUgaXMgYWxzbyBsb25nIGVub3VnaC4KPj4gSSdtIG5vdCBzdXJlIGFib3V0IGJvb3QgbG9hZGVy
IG9yIGtlcm5lbCByZXN0cmljdGlvbnMgdG8gdGhpcyBsZW5ndGguCj4+Cj4+IFNpZ25lZC1vZmYt
Ynk6IENsaWZmIFdpY2ttYW4gPGNwd0BzZ2kuY29tPgo+IAo+IFRoYW5rcywgYXBwbGllZC4KCkhl
bGxvCgpJIGhhdmUgYSBxdWVzdGlvbiBhYm91dCB0aGlzIHBhdGNoLgoKSW4geDg2IGNvZGUsIENP
TU1BTkRfTElORV9TSVpFIGlzIGRlZmluZWQgYXMgYmVsb3c6CgphcmNoL3g4Ni9pbmNsdWRlL2Fz
bS9zZXR1cC5oCgojZGVmaW5lIENPTU1BTkRfTElORV9TSVpFIDIwNDgKClNvIGV2ZW4gdGhlIHBh
dGNoIGxlbmd0aGVucyB0aGUgY29tbWFuZGxpbmUgbGVuZ3RoIGhlcmUsIHdoZW4gcmVib290IGlu
dG8KdGhlIG5ldyBrZXJuZWwsIHRoZSBjb21tYW5kbGluZSB3aWxsIHN0aWxsIGJlIHN0cmlwcGVk
IHRvIDIwNDg/IHJpZ2h0PwoKU28gdGhlIHBhdGNoIHNlZW1zIHVubmVjZXNzYXJ5IG9yIHVudXNh
YmxlLiBDb3JyZWN0IG1lIGlmIEkgYW0gd3JvbmcuCgpUaGFua3MKWmhhbmcKCj4gCj4gX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KPiBrZXhlYyBtYWlsaW5n
IGxpc3QKPiBrZXhlY0BsaXN0cy5pbmZyYWRlYWQub3JnCj4gaHR0cDovL2xpc3RzLmluZnJhZGVh
ZC5vcmcvbWFpbG1hbi9saXN0aW5mby9rZXhlYwo+IAoKCl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fCmtleGVjIG1haWxpbmcgbGlzdAprZXhlY0BsaXN0cy5p
bmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8v
a2V4ZWMK
