Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1USG06-0001dS-Ff
 for kexec@lists.infradead.org; Wed, 17 Apr 2013 00:13:27 +0000
Date: Wed, 17 Apr 2013 09:13:16 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH
 RESEND]kexec:i386/kexec-[bzImage|elf-x86]:x86_64/kexec-bzImage64: Use "\0"
 as command line instead of empty command line
Message-ID: <20130417001314.GB21434@verge.net.au>
References: <20130408092325.GA23318@udknight> <51628E04.8010002@cn.fujitsu.com>
 <516D5B8E.6070302@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <516D5B8E.6070302@gmail.com>
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
To: Zhang Yanfei <zhangyanfei.yes@gmail.com>
Cc: tjd21@cl.cam.ac.uk, kexec@lists.infradead.org, Wang YanQing <udknight@gmail.com>, Zhang Yanfei <zhangyanfei@cn.fujitsu.com>, ebiederm@xmission.com, hari@in.ibm.com

T24gVHVlLCBBcHIgMTYsIDIwMTMgYXQgMTA6MDk6MThQTSArMDgwMCwgWmhhbmcgWWFuZmVpIHdy
b3RlOgo+IOS6jiAyMDEz5bm0MDTmnIgwOOaXpSAxNzoyOSwgWmhhbmcgWWFuZmVpIOWGmemBkzoK
PiA+IOS6jiAyMDEz5bm0MDTmnIgwOOaXpSAxNzoyMywgV2FuZyBZYW5RaW5nIOWGmemBkzoKPiA+
PiBUaGlzIHBhdGNoIHByZXZlbnRzIHRoZSBwcm9ibGVtcyB0byBoYXBwZW4gYmVsb3c6Cj4gPj4g
SW4gc2V0dXBfbGludXhfYm9vdGxvYWRlcl9wYXJhbWV0ZXJzX2hpZ2gKPiA+PiAxMjAgICAgICAg
ICBjbWRsaW5lX3B0ciA9ICgoY2hhciAqKXJlYWxfbW9kZSkgKyBjbWRsaW5lX29mZnNldDsKPiA+
PiAxMjEgICAgICAgICBtZW1jcHkoY21kbGluZV9wdHIsIGNtZGxpbmUsIGNtZGxpbmVfbGVuKTsK
PiA+PiAxMjIgICAgICAgICBjbWRsaW5lX3B0cltjbWRsaW5lX2xlbiAtIDFdID0gJ1wwJzsKPiA+
Pgo+ID4+IGlmIGNtZGxpbmVfbGVuID09IDAsIExpbmUgMTIyIHdpbGwgY29ycnVwdCBrZXJuZWwx
NiBidWYganVzdCBiZWZvcmUgdGhlIGNvbW1hbmRsaW5lLgo+ID4+IEFuZCBpbiBkb19iekltYWdl
X2xvYWQsIGZvciBleGFtcGxlLAo+ID4+IDM2OSAgICAgICAgIGNtZGxpbmVfZW5kID0gc2V0dXBf
YmFzZSArIGtlcm4xNl9zaXplX25lZWRlZCArIGNvbW1hbmRfbGluZV9sZW4gLSAxOwo+ID4+IDM3
MCAgICAgICAgIGVsZl9yZWxfc2V0X3N5bWJvbCgmaW5mby0+cmhkciwgImNtZGxpbmVfZW5kIiwg
JmNtZGxpbmVfZW5kLAo+ID4+IDM3MSAgICAgICAgICAgICAgICAgICAgICAgICAgICBzaXplb2Yo
dW5zaWduZWQgbG9uZykpOwo+ID4+IExpbmUgMzY5IHdpbGwgZ28gd3JvbmcsIHRvby4KPiA+Pgo+
ID4+IFNpZ25lZC1vZmYtYnk6IFdhbmcgWWFuUWluZyA8dWRrbmlnaHRAZ21haWwuY29tPgo+ID4+
IC0tLQo+ID4+ICBIaSBaaGFuZyBZYW5mZWksIGNvdWxkIHlvdSBnaXZlIHlvdXIgc2lnbmVkLW9m
Zi1ieSB0bwo+ID4+ICB0aGlzIHBhdGNoPwo+ID4gCj4gPiBZZWFoLgo+ID4gCj4gPiBTaWduZWQt
b2ZmLWJ5OiBaaGFuZyBZYW5mZWkgPHpoYW5neWFuZmVpQGNuLmZ1aml0c3UuY29tPgo+ID4gCj4g
PiBIaSBTaW1vbiwgY291bGQgeW91IHBsZWFzZSB0YWtlIGEgbG9vayBhdCB0aGlzIHRvIHNlZSBp
ZiB0aGUgY2hhbmdlIGlzIHJlYXNvbmFibGU/Cj4gPiBBZnRlciBhbGwsIGlmIG5vIGNvbW1hZGxp
bmUsIHdlIG1ha2UgdGhlIGNvbW1hbmRsaW5lX2xlbiB0byAxLiBJIGRvbid0IGtub3cgaWYKPiA+
IHRoaXMgYmVoYXZpb3VyIGNvdWxkIGJlIGFjY2VwdGVkIGJ5IHlvdS4KPiA+IAo+IAo+IEhpIFNp
bW9uCj4gCj4gV2hhdCBpcyB5b3VyIG9waW5pb24gYWJvdXQgdGhpcyBwYXRjaD8KCkl0IHNlZW1z
IHJlYXNvbmFibGUgdG8gbWUsIEkgaGF2ZSBhcHBsaWVkIGl0LgoKSSBoYXZlIGFkZGVkIHlvdXIg
U2lnbmVkLW9mZi1ieS4gSG93ZXZlciwgZm9yIHJlZmVyZW5jZTogdW5sZXNzIHlvdSBhcmUgdGhl
Cm1haW50YWluZXIgb3Igd2VyZSBpbnZvbHZlZCBpbiB3cml0aW5nIHRoZSBwYXRjaCBJIHRoaW5r
IGFuIEFja2VkLWJ5IG9yClRlc3RlZC1ieSB3b3VsZCBiZSBtb3JlIGFwcHJvcHJpYXRlLgoKX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18Ka2V4ZWMgbWFpbGlu
ZyBsaXN0CmtleGVjQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5v
cmcvbWFpbG1hbi9saXN0aW5mby9rZXhlYwo=
