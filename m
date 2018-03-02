Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by bombadil.infradead.org with esmtp (Exim 4.89 #1 (Red Hat Linux))
 id 1erk59-0002LE-8n
 for kexec@lists.infradead.org; Fri, 02 Mar 2018 12:46:41 +0000
Date: Fri, 2 Mar 2018 13:46:10 +0100
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH 4/5] kexec: fallback to KEXEC_LOAD when KEXEC_FILE_LOAD
 is not supported.
Message-ID: <20180302124610.3tyvym3dayq3coiz@verge.net.au>
References: <e810acd57d9fc2d7ba3b0e95d470c20de9948462.1519646210.git.msuchanek@suse.de>
 <ebc4bc6f1dc7d62ba5c81f40c7f7d83a8ae3eb5d.1519646210.git.msuchanek@suse.de>
 <20180302092419.GB15374@dhcp-128-65.nay.redhat.com>
 <20180302133252.69a36ffd@kitsune.suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20180302133252.69a36ffd@kitsune.suse.cz>
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
To: Michal =?utf-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>
Cc: kexec@lists.infradead.org, Dave Young <dyoung@redhat.com>, Petr Tesarik <ptesarik@suse.cz>, Tony Jones <tonyj@suse.com>

T24gRnJpLCBNYXIgMDIsIDIwMTggYXQgMDE6MzI6NTJQTSArMDEwMCwgTWljaGFsIFN1Y2jDoW5l
ayB3cm90ZToKPiBPbiBGcmksIDIgTWFyIDIwMTggMTc6MjQ6MTkgKzA4MDAKPiBEYXZlIFlvdW5n
IDxkeW91bmdAcmVkaGF0LmNvbT4gd3JvdGU6Cj4gCj4gPiBPbiAwMi8yNi8xOCBhdCAwMTowMHBt
LCBNaWNoYWwgU3VjaGFuZWsgd3JvdGU6Cj4gPiA+IE5vdCBhbGwgYXJjaGl0ZWN0dXJlcyBpbXBs
ZW1lbnQgS0VYRUNfRklMRV9MT0FELiBIb3dldmVyLCBvbiBzb21lCj4gPiA+IGFyY2hpZWN0dXJl
cyBLRVhFQ19GSUxFX0xPQUQgaXMgcmVxdWlyZWQgd2hlbiBzZWN1cmUgYm9vdCBpcwo+ID4gPiBl
bmFibGVkIGluIGxvY2tlZC1kb3duIG1vZGUuIFByZXZpb3VzbHkgdXNlcnMgaGFkIHRvIHNlbGVj
dCB0aGUKPiA+ID4gS0VYRUNfRklMRV9MT0FEIHN5c2NhbGwgd2l0aCB1bmRvY3VtZW50ZWQgLXMg
b3B0aW9uLiBIb3dldmVyLCBpZgo+ID4gPiB0aGV5IGRpZCBwYXNzIHRoZSBvcHRpb24ga2V4ZWMg
d291bGQgZmFpbCBvbiBhcmNoaXRlY3R1cmVzIHRoYXQgZG8KPiA+ID4gbm90IHN1cHBvcnQgaXQu
Cj4gPiA+IAo+ID4gPiBXaGVuIG5vIG9wdGlvbiBpcyBwYXNzZWQgdG8gc2VsZWN0IG9uZSBzeXNj
YWxsIG9yIHRoZSBvdGhlciB0cnkKPiA+ID4gS0VYRUNfRklMRV9MT0FEIGFuZCBmYWxsIGJhY2sg
dG8gS0VYRUNfTE9BRCB3aGVuIG5vdCBzdXBvcnRlZC4gIAo+ID4gCj4gPiBBZ2FpbiwgSU1ITyB0
aGUgZGVmYXVsdCBiZWhhdmlvciBzaG91bGQgbm90IGJlIGNoYW5nZWQuLgo+IAo+IFNvIGFkZGlu
ZyBhIG5ldyBvcHRpb24gdG8gZW5hYmxlIHRoZSBmYWxsYmFjayB3b3VsZCBiZSBvaz8KCkkgYW0g
YWxzbyB3YXJ5IG9mIGNoYW5naW5nIHRoZSBkZWZhdWx0IGJlaGF2aW91ciBhbmQKSSB0aGluayBh
IG5ldyBmYWxsYmFjayBvcHRpb24gd291bGQgYmUgYmV0dGVyLgoKRGF2ZT8KCl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmtleGVjIG1haWxpbmcgbGlzdApr
ZXhlY0BsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxt
YW4vbGlzdGluZm8va2V4ZWMK
