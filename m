Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UP1VJ-0005kp-1E
 for kexec@lists.infradead.org; Mon, 08 Apr 2013 02:08:18 +0000
Date: Mon, 8 Apr 2013 11:08:14 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] kexec, i386: Fix build warning of size_t print
Message-ID: <20130408020814.GG13103@verge.net.au>
References: <515FB51C.70005@gmail.com> <20130408013736.GB13103@verge.net.au>
 <51621FA9.80403@cn.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <51621FA9.80403@cn.fujitsu.com>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Zhang Yanfei <zhangyanfei@cn.fujitsu.com>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>, Zhang Yanfei <zhangyanfei.yes@gmail.com>

T24gTW9uLCBBcHIgMDgsIDIwMTMgYXQgMDk6Mzg6NDlBTSArMDgwMCwgWmhhbmcgWWFuZmVpIHdy
b3RlOgo+IOS6jiAyMDEz5bm0MDTmnIgwOOaXpSAwOTozNywgU2ltb24gSG9ybWFuIOWGmemBkzoK
PiA+IE9uIFNhdCwgQXByIDA2LCAyMDEzIGF0IDAxOjM5OjQwUE0gKzA4MDAsIFpoYW5nIFlhbmZl
aSB3cm90ZToKPiA+PiBGcm9tOiBaaGFuZyBZYW5mZWkgPHpoYW5neWFuZmVpQGNuLmZ1aml0c3Uu
Y29tPgo+ID4+Cj4gPj4gV2hlbiBjb21waWxlIGtleGVjLXRvb2xzIGluIGkzODYsIHdlIGdvdCB0
aGUgZm9sbG93aW5nIHdhcm5pbmdzOgo+ID4+Cj4gPj4ga2V4ZWMva2V4ZWMtZWxmLXJlbC5jOiBJ
biBmdW5jdGlvbiDigJhlbGZfcmVsX3NldF9zeW1ib2zigJk6Cj4gPj4ga2V4ZWMva2V4ZWMtZWxm
LXJlbC5jOjUxNzogd2FybmluZzogZm9ybWF0IOKAmCVsZOKAmSBleHBlY3RzIHR5cGUg4oCYbG9u
ZyBpbnTigJksIGJ1dCBhcmd1bWVudCA0IGhhcyB0eXBlIOKAmHNpemVfdOKAmQo+ID4+IGtleGVj
L2tleGVjLWVsZi1yZWwuYzogSW4gZnVuY3Rpb24g4oCYZWxmX3JlbF9nZXRfc3ltYm9s4oCZOgo+
ID4+IGtleGVjL2tleGVjLWVsZi1yZWwuYzo1NDE6IHdhcm5pbmc6IGZvcm1hdCDigJglbGTigJkg
ZXhwZWN0cyB0eXBlIOKAmGxvbmcgaW504oCZLCBidXQgYXJndW1lbnQgNCBoYXMgdHlwZSDigJhz
aXplX3TigJkKPiA+Pgo+ID4+IFRoaXMgaXMgYmVjYXVzZSB0aGUgdHdvIGZ1bmN0aW9ucyBvdXRw
dXQgYSBzaXplX3QgdmFsdWUgYXMgJWxkCj4gPj4gd2hlbiBpdCBzaG91bGQgYmUgJXpkLCByZXN1
bHRpbmcgaW4gdGhpcyB3YXJuaW5nLgo+ID4gCj4gPiBUaGFua3MsCj4gPiAKPiA+IFRoaXMgY2hh
bmdlIGxvb2tzIGdvb2QgdG8gbWUsIGhvd2V2ZXIsIHRoZSBwYXRjaCBkb2VzCj4gPiBub3QgYXBw
ZWFyIHRvIGFwcGx5IG9uIHRoZSBtYXN0ZXIgYnJhbmNoIG9mIHRoZSBrZXhlYy10b29scyB0cmVl
Lgo+ID4gQ291bGQgeW91IHJlYmFzZSBhbmQgcmVwb3N0IGl0Pwo+IAo+IFJlYWxseT8gTWF5YmUg
SSBtYWRlIHNvbWUgbWlzdGFrZS4gQW55d2F5IEkgd2lsbCByZWdlbmVyYXRlIGl0IGFuZAo+IHJl
c2VuZCBpdCBhZ2Fpbi4KClBlcmhhcHMgSSBtYWRlIGEgbWlzdGFrZSBeKQoKVGhlIGhlYWQgY29t
bWl0IEkgaGF2ZSBpczoKCmNvbW1pdCA5NjlmM2U4YzFjNTM0ZjYzYjg2OTE4M2NjZjI5MmJjYWVm
MGU1NTU4CkF1dGhvcjogUmljaGFyZCBXZWluYmVyZ2VyIDxyaWNoYXJkQG5vZC5hdD4KRGF0ZTog
ICBNb24gQXByIDEgMTM6MjM6MDQgMjAxMyArMDIwMAoKICAgIHB1cmdhdG9yeTogcmVtb3ZlIGFy
Y2gvaTM4Ni90aW1lci5jCiAgICAKICAgIFRoaXMgZmlsZSBpcyBub3doZXJlIHJlZmVyZW5jZWQs
IGxldCdzIGdldCByaWQgb2YgaXQuCiAgICAKICAgIFNpZ25lZC1vZmYtYnk6IFJpY2hhcmQgV2Vp
bmJlcmdlciA8cmljaGFyZEBub2QuYXQ+CiAgICBTaWduZWQtb2ZmLWJ5OiBTaW1vbiBIb3JtYW4g
PGhvcm1zQHZlcmdlLm5ldC5hdT4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fCmtleGVjIG1haWxpbmcgbGlzdAprZXhlY0BsaXN0cy5pbmZyYWRlYWQub3Jn
Cmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8va2V4ZWMK
