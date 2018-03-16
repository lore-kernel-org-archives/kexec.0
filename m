Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ewnpY-0000AD-DR
 for kexec@lists.infradead.org; Fri, 16 Mar 2018 11:47:31 +0000
Date: Fri, 16 Mar 2018 12:47:14 +0100
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH v4 2/5] kexec: do not special-case the -s option
Message-ID: <20180316114714.4tmf4gr3d6boowi5@verge.net.au>
References: <20180302091706.GA15374@dhcp-128-65.nay.redhat.com>
 <28358b37c1174572ff6051ec430d750969efa9eb.1520342150.git.msuchanek@suse.de>
 <20180315103830.txngzqrwj63qq53p@verge.net.au>
 <20180315121318.3d5ffc46@kitsune.suse.cz>
 <20180316112024.juwn7bhoccwwprv6@verge.net.au>
 <20180316123813.2dc20e10@naga.suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20180316123813.2dc20e10@naga.suse.cz>
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
Cc: Petr Tesarik <ptesarik@suse.cz>, Dave Young <dyoung@redhat.com>, kexec@lists.infradead.org, Tony Jones <tonyj@suse.com>

T24gRnJpLCBNYXIgMTYsIDIwMTggYXQgMTI6Mzg6MTNQTSArMDEwMCwgTWljaGFsIFN1Y2jDoW5l
ayB3cm90ZToKPiBPbiBGcmksIDE2IE1hciAyMDE4IDEyOjIwOjI1ICswMTAwCj4gU2ltb24gSG9y
bWFuIDxob3Jtc0B2ZXJnZS5uZXQuYXU+IHdyb3RlOgo+IAo+ID4gT24gVGh1LCBNYXIgMTUsIDIw
MTggYXQgMTI6MTM6MThQTSArMDEwMCwgTWljaGFsIFN1Y2jDoW5layB3cm90ZToKPiA+ID4gT24g
VGh1LCAxNSBNYXIgMjAxOCAxMTozODozMCArMDEwMAo+ID4gPiBTaW1vbiBIb3JtYW4gPGhvcm1z
QHZlcmdlLm5ldC5hdT4gd3JvdGU6Cj4gCj4gPiA+ID4gCj4gPiA+ID4gCj4gPiA+ID4gICAgICAg
ICBpZiAoZG9fbG9hZCAmJiAoa2V4ZWNfZmxhZ3MgJiBLRVhFQ19PTl9DUkFTSCkgJiYKPiA+ID4g
PiAgICAgICAgICAgICAhaXNfY3Jhc2hrZXJuZWxfbWVtX3Jlc2VydmVkKCkpIHsKPiA+ID4gPiAg
ICAgICAgICAgICAgICAgZGllKCJNZW1vcnkgZm9yIGNyYXNoa2VybmVsIGlzIG5vdCByZXNlcnZl
ZFxuIgo+ID4gPiA+ICAgICAgICAgICAgICAgICAgICAgIlBsZWFzZSByZXNlcnZlIG1lbW9yeSBi
eSBwYXNzaW5nIgo+ID4gPiA+ICAgICAgICAgICAgICAgICAgICAgIlwiY3Jhc2hrZXJuZWw9WEBZ
XCIgcGFyYW1ldGVyIHRvIGtlcm5lbFxuIgo+ID4gPiA+ICAgICAgICAgICAgICAgICAgICAgIlRo
ZW4gdHJ5IHRvIGxvYWRpbmcga2R1bXAga2VybmVsXG4iKTsKPiA+ID4gPiAgICAgICAgIH0gIAo+
ID4gPiAKPiA+ID4gRG8geW91IG5vdCBuZWVkIG1lbW9yeSBmb3Iga2V4ZWMgLXM/IFRoaXMgbG9v
a3MgYnJva2VuIHRvIHN0YXJ0Cj4gPiA+IHdpdGguICAKPiA+IAo+ID4gQ291bGQgeW91IHByb3Bv
c2UgYSBmaXg/IEkgcmVhbGlzZSB5b3VyIHBhdGNoc2V0IG1heSBub3QgaW50cm9kdWNlCj4gPiB0
aGlzIHByb2JsZW0uIEJ1dCBpdCBzZWVtcyB0byBtZSB0aGF0IGl0IG1ha2VzIHRoaW5ncyBzbGln
aHRseSB3b3JzZQo+ID4gb3IgYXQgdGhlIHZlcnkgbGVhc3QgcGVycGV0dWF0ZXMgdGhlIG5vdGlv
biB0aGF0IHRoZSBhYm92ZSBpcyBjb3JyZWN0Lgo+IAo+IFllcywgaXQgbWFrZXMgc2Vuc2UgdG8g
Zml4IHRoZSBjb25kaXRpb24uCgpUaGFua3MuCgo+ID4gPiA+IAkuLi4KPiA+ID4gPiAKPiA+ID4g
PiAgICAgICAgIGlmICgocmVzdWx0ID09IDApICYmIGRvX2xvYWRfanVtcF9iYWNrX2hlbHBlcikg
eyAgCj4gPiA+IAo+ID4gPiBBbmQgeWVzLCB0aGlzIHNob3VsZCBub3QgYmUgYWxsb3dlZCB3aXRo
IC1zICAKPiA+IAo+ID4gSXMgdGhlIHNpbXBsZSBmaXggaGVyZSBmb3IgeW91ciBwYXRjaCB0byBh
ZGQgYW4gZXh0cmEgY29uZGl0aW9uCj4gPiB0byB0aGUgaWYgc3RhdGVtZW50IGFib3ZlPwo+IAo+
IFRoaXMgaXMgbm90IHN1cHBvcnRlZCB3aXRoIC1zIGJ1dCBub3RoaW5nIHByZXZlbnRzIHNldHRp
bmcgdGhlIGZsYWcuIFNvCj4gYSB0ZXN0IGZvciBrZXhlY19sb2FkIHNob3VsZCBiZSBhZGRlZCBJ
IGd1ZXNzLgoKVGhhdCBpcyB3aGF0IEkgd2FzIHRoaW5raW5nIHRvby4KCl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmtleGVjIG1haWxpbmcgbGlzdAprZXhl
Y0BsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4v
bGlzdGluZm8va2V4ZWMK
