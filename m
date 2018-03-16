Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx2.suse.de ([195.135.220.15])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ewngq-0004Sj-Jg
 for kexec@lists.infradead.org; Fri, 16 Mar 2018 11:38:30 +0000
Date: Fri, 16 Mar 2018 12:38:13 +0100
From: Michal =?UTF-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>
Subject: Re: [PATCH v4 2/5] kexec: do not special-case the -s option
Message-ID: <20180316123813.2dc20e10@naga.suse.cz>
In-Reply-To: <20180316112024.juwn7bhoccwwprv6@verge.net.au>
References: <20180302091706.GA15374@dhcp-128-65.nay.redhat.com>
 <28358b37c1174572ff6051ec430d750969efa9eb.1520342150.git.msuchanek@suse.de>
 <20180315103830.txngzqrwj63qq53p@verge.net.au>
 <20180315121318.3d5ffc46@kitsune.suse.cz>
 <20180316112024.juwn7bhoccwwprv6@verge.net.au>
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
Cc: Petr Tesarik <ptesarik@suse.cz>, Dave Young <dyoung@redhat.com>, kexec@lists.infradead.org, Tony Jones <tonyj@suse.com>

T24gRnJpLCAxNiBNYXIgMjAxOCAxMjoyMDoyNSArMDEwMApTaW1vbiBIb3JtYW4gPGhvcm1zQHZl
cmdlLm5ldC5hdT4gd3JvdGU6Cgo+IE9uIFRodSwgTWFyIDE1LCAyMDE4IGF0IDEyOjEzOjE4UE0g
KzAxMDAsIE1pY2hhbCBTdWNow6FuZWsgd3JvdGU6Cj4gPiBPbiBUaHUsIDE1IE1hciAyMDE4IDEx
OjM4OjMwICswMTAwCj4gPiBTaW1vbiBIb3JtYW4gPGhvcm1zQHZlcmdlLm5ldC5hdT4gd3JvdGU6
Cgo+ID4gPiAKPiA+ID4gCj4gPiA+ICAgICAgICAgaWYgKGRvX2xvYWQgJiYgKGtleGVjX2ZsYWdz
ICYgS0VYRUNfT05fQ1JBU0gpICYmCj4gPiA+ICAgICAgICAgICAgICFpc19jcmFzaGtlcm5lbF9t
ZW1fcmVzZXJ2ZWQoKSkgewo+ID4gPiAgICAgICAgICAgICAgICAgZGllKCJNZW1vcnkgZm9yIGNy
YXNoa2VybmVsIGlzIG5vdCByZXNlcnZlZFxuIgo+ID4gPiAgICAgICAgICAgICAgICAgICAgICJQ
bGVhc2UgcmVzZXJ2ZSBtZW1vcnkgYnkgcGFzc2luZyIKPiA+ID4gICAgICAgICAgICAgICAgICAg
ICAiXCJjcmFzaGtlcm5lbD1YQFlcIiBwYXJhbWV0ZXIgdG8ga2VybmVsXG4iCj4gPiA+ICAgICAg
ICAgICAgICAgICAgICAgIlRoZW4gdHJ5IHRvIGxvYWRpbmcga2R1bXAga2VybmVsXG4iKTsKPiA+
ID4gICAgICAgICB9ICAKPiA+IAo+ID4gRG8geW91IG5vdCBuZWVkIG1lbW9yeSBmb3Iga2V4ZWMg
LXM/IFRoaXMgbG9va3MgYnJva2VuIHRvIHN0YXJ0Cj4gPiB3aXRoLiAgCj4gCj4gQ291bGQgeW91
IHByb3Bvc2UgYSBmaXg/IEkgcmVhbGlzZSB5b3VyIHBhdGNoc2V0IG1heSBub3QgaW50cm9kdWNl
Cj4gdGhpcyBwcm9ibGVtLiBCdXQgaXQgc2VlbXMgdG8gbWUgdGhhdCBpdCBtYWtlcyB0aGluZ3Mg
c2xpZ2h0bHkgd29yc2UKPiBvciBhdCB0aGUgdmVyeSBsZWFzdCBwZXJwZXR1YXRlcyB0aGUgbm90
aW9uIHRoYXQgdGhlIGFib3ZlIGlzIGNvcnJlY3QuCgpZZXMsIGl0IG1ha2VzIHNlbnNlIHRvIGZp
eCB0aGUgY29uZGl0aW9uLgoKPiAKPiA+ID4gCS4uLgo+ID4gPiAKPiA+ID4gICAgICAgICBpZiAo
KHJlc3VsdCA9PSAwKSAmJiBkb19sb2FkX2p1bXBfYmFja19oZWxwZXIpIHsgIAo+ID4gCj4gPiBB
bmQgeWVzLCB0aGlzIHNob3VsZCBub3QgYmUgYWxsb3dlZCB3aXRoIC1zICAKPiAKPiBJcyB0aGUg
c2ltcGxlIGZpeCBoZXJlIGZvciB5b3VyIHBhdGNoIHRvIGFkZCBhbiBleHRyYSBjb25kaXRpb24K
PiB0byB0aGUgaWYgc3RhdGVtZW50IGFib3ZlPwoKVGhpcyBpcyBub3Qgc3VwcG9ydGVkIHdpdGgg
LXMgYnV0IG5vdGhpbmcgcHJldmVudHMgc2V0dGluZyB0aGUgZmxhZy4gU28KYSB0ZXN0IGZvciBr
ZXhlY19sb2FkIHNob3VsZCBiZSBhZGRlZCBJIGd1ZXNzLgoKVGhhbmtzCgpNaWNoYWwKCgpfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwprZXhlYyBtYWlsaW5n
IGxpc3QKa2V4ZWNAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9y
Zy9tYWlsbWFuL2xpc3RpbmZvL2tleGVjCg==
