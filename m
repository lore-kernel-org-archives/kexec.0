Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx2.suse.de ([195.135.220.15])
 by bombadil.infradead.org with esmtps (Exim 4.89 #1 (Red Hat Linux))
 id 1erkjR-0006nS-Cf
 for kexec@lists.infradead.org; Fri, 02 Mar 2018 13:28:18 +0000
Date: Fri, 2 Mar 2018 14:28:05 +0100
From: Michal =?UTF-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>
Subject: Re: [PATCH 4/5] kexec: fallback to KEXEC_LOAD when KEXEC_FILE_LOAD
 is not supported.
Message-ID: <20180302142805.1abda163@kitsune.suse.cz>
In-Reply-To: <20180302124610.3tyvym3dayq3coiz@verge.net.au>
References: <e810acd57d9fc2d7ba3b0e95d470c20de9948462.1519646210.git.msuchanek@suse.de>
 <ebc4bc6f1dc7d62ba5c81f40c7f7d83a8ae3eb5d.1519646210.git.msuchanek@suse.de>
 <20180302092419.GB15374@dhcp-128-65.nay.redhat.com>
 <20180302133252.69a36ffd@kitsune.suse.cz>
 <20180302124610.3tyvym3dayq3coiz@verge.net.au>
MIME-Version: 1.0
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
Cc: kexec@lists.infradead.org, Dave Young <dyoung@redhat.com>, Petr Tesarik <ptesarik@suse.cz>, Tony Jones <tonyj@suse.com>

T24gRnJpLCAyIE1hciAyMDE4IDEzOjQ2OjEwICswMTAwClNpbW9uIEhvcm1hbiA8aG9ybXNAdmVy
Z2UubmV0LmF1PiB3cm90ZToKCj4gT24gRnJpLCBNYXIgMDIsIDIwMTggYXQgMDE6MzI6NTJQTSAr
MDEwMCwgTWljaGFsIFN1Y2jDoW5layB3cm90ZToKPiA+IE9uIEZyaSwgMiBNYXIgMjAxOCAxNzoy
NDoxOSArMDgwMAo+ID4gRGF2ZSBZb3VuZyA8ZHlvdW5nQHJlZGhhdC5jb20+IHdyb3RlOgo+ID4g
ICAKPiA+ID4gT24gMDIvMjYvMTggYXQgMDE6MDBwbSwgTWljaGFsIFN1Y2hhbmVrIHdyb3RlOiAg
Cj4gPiA+ID4gTm90IGFsbCBhcmNoaXRlY3R1cmVzIGltcGxlbWVudCBLRVhFQ19GSUxFX0xPQUQu
IEhvd2V2ZXIsIG9uCj4gPiA+ID4gc29tZSBhcmNoaWVjdHVyZXMgS0VYRUNfRklMRV9MT0FEIGlz
IHJlcXVpcmVkIHdoZW4gc2VjdXJlIGJvb3QKPiA+ID4gPiBpcyBlbmFibGVkIGluIGxvY2tlZC1k
b3duIG1vZGUuIFByZXZpb3VzbHkgdXNlcnMgaGFkIHRvIHNlbGVjdAo+ID4gPiA+IHRoZSBLRVhF
Q19GSUxFX0xPQUQgc3lzY2FsbCB3aXRoIHVuZG9jdW1lbnRlZCAtcyBvcHRpb24uCj4gPiA+ID4g
SG93ZXZlciwgaWYgdGhleSBkaWQgcGFzcyB0aGUgb3B0aW9uIGtleGVjIHdvdWxkIGZhaWwgb24K
PiA+ID4gPiBhcmNoaXRlY3R1cmVzIHRoYXQgZG8gbm90IHN1cHBvcnQgaXQuCj4gPiA+ID4gCj4g
PiA+ID4gV2hlbiBubyBvcHRpb24gaXMgcGFzc2VkIHRvIHNlbGVjdCBvbmUgc3lzY2FsbCBvciB0
aGUgb3RoZXIgdHJ5Cj4gPiA+ID4gS0VYRUNfRklMRV9MT0FEIGFuZCBmYWxsIGJhY2sgdG8gS0VY
RUNfTE9BRCB3aGVuIG5vdAo+ID4gPiA+IHN1cG9ydGVkLiAgICAKPiA+ID4gCj4gPiA+IEFnYWlu
LCBJTUhPIHRoZSBkZWZhdWx0IGJlaGF2aW9yIHNob3VsZCBub3QgYmUgY2hhbmdlZC4uICAKPiA+
IAo+ID4gU28gYWRkaW5nIGEgbmV3IG9wdGlvbiB0byBlbmFibGUgdGhlIGZhbGxiYWNrIHdvdWxk
IGJlIG9rPyAgCj4gCj4gSSBhbSBhbHNvIHdhcnkgb2YgY2hhbmdpbmcgdGhlIGRlZmF1bHQgYmVo
YXZpb3VyIGFuZAo+IEkgdGhpbmsgYSBuZXcgZmFsbGJhY2sgb3B0aW9uIHdvdWxkIGJlIGJldHRl
ci4KPiAKPiBEYXZlPwoKT2ssIEkgd2lsbCByZXNlbmQgd2l0aCBhIHNlcGFyYXRlIGZhbGxiYWNr
IG9wdGlvbi4KClRoYW5rcwoKTWljaGFsCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwprZXhlYyBtYWlsaW5nIGxpc3QKa2V4ZWNAbGlzdHMuaW5mcmFkZWFk
Lm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2tleGVjCg==
