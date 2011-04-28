Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
	by canuck.infradead.org with esmtp (Exim 4.72 #1 (Red Hat Linux))
	id 1QFZPV-0003rB-6H
	for kexec@lists.infradead.org; Thu, 28 Apr 2011 22:10:09 +0000
Date: Thu, 28 Apr 2011 18:10:05 -0400
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [Patch] kexec: remove duplicated backup_src_start field from
	struct crash_elf_info
Message-ID: <20110428221005.GC7883@redhat.com>
References: <1303875207-9273-1-git-send-email-amwang@redhat.com>
	<20110427150151.GB7790@redhat.com> <4DB91DFC.4060708@redhat.com>
	<20110428131539.GA7883@redhat.com>
	<20110428220515.GI3610@verge.net.au>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20110428220515.GI3610@verge.net.au>
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Simon Horman <horms@verge.net.au>
Cc: kexec@lists.infradead.org, Cong Wang <amwang@redhat.com>

T24gRnJpLCBBcHIgMjksIDIwMTEgYXQgMDc6MDU6MTZBTSArMDkwMCwgU2ltb24gSG9ybWFuIHdy
b3RlOgo+IE9uIFRodSwgQXByIDI4LCAyMDExIGF0IDA5OjE1OjM5QU0gLTA0MDAsIFZpdmVrIEdv
eWFsIHdyb3RlOgo+ID4gT24gVGh1LCBBcHIgMjgsIDIwMTEgYXQgMDM6NTc6NDhQTSArMDgwMCwg
Q29uZyBXYW5nIHdyb3RlOgo+ID4gPiDkuo4gMjAxMeW5tDA05pyIMjfml6UgMjM6MDEsIFZpdmVr
IEdveWFsIOWGmemBkzoKPiA+ID4gPkFtZXJpZ28sCj4gPiA+ID4KPiA+ID4gPk5vdyB3aG8gd2ls
bCBkbyBmb2xsb3dpbmcgaW5pdGlhbGl6YXRpb24gZm9yIHBwYz8KPiA+ID4gPgo+ID4gPiA+aW5m
by0+YmFja3VwX3NyY19zdGFydCA9IEJBQ0tVUF9TUkNfU1RBUlQ7Cj4gPiA+ID5pbmZvLT5iYWNr
dXBfc3ogPSBCQUNLVVBfU1JDX0VORCAtIEJBQ0tVUF9TUkNfU1RBUlQgKyAxOwo+ID4gPiA+Cj4g
PiA+ID5JIHRoaW5rIEkgaGF2ZSBjb25jZXJuIGZvciBtaXBzIHRvby4KPiA+ID4gCj4gPiA+IFJp
Z2h0LCB3ZSBuZWVkIHRvIGluaXRpYWxpemUgdGhlbSBpbiBsb2FkX2NyYXNoZHVtcF9zZWdtZW50
cygpLgo+ID4gPiAKPiA+ID4gSG93IGFib3V0IHRoZSBhdHRhY2hlZCBwYXRjaD8gSXQgaXMgdW50
ZXN0ZWQuCj4gPiA+IAo+ID4gCj4gPiA+IFNpZ25lZC1vZmYtYnk6IFdBTkcgQ29uZyA8YW13YW5n
QHJlZGhhdC5jb20+Cj4gPiAKPiA+IE9rLCB0aGlzIG9uZSBsb29rcyBiZXR0ZXIuCj4gCj4gVml2
ZWssIGNhbiBJIHRha2UgdGhhdCBhcyBhbiBBY2tlZC1ieT8KClNpbW9uLCB5ZXMgcGxlYXNlLgoK
QWNrZWQtYnk6IFZpdmVrIEdveWFsIDx2Z295YWxAcmVkaGF0LmNvbT4KClZpdmVrCgpfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwprZXhlYyBtYWlsaW5nIGxp
c3QKa2V4ZWNAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9t
YWlsbWFuL2xpc3RpbmZvL2tleGVjCg==
