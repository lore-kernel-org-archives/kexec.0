Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from cantor.suse.de ([195.135.220.2] helo=mx1.suse.de)
	by canuck.infradead.org with esmtps (Exim 4.63 #1 (Red Hat Linux))
	id 1IKs9W-0001mu-Jp
	for kexec@lists.infradead.org; Tue, 14 Aug 2007 04:53:28 -0400
Date: Tue, 14 Aug 2007 10:53:24 +0200
From: Bernhard Walle <bwalle@suse.de>
Subject: Re: [patch] add kdump_after_notifier
Message-ID: <20070814085324.GB19512@suse.de>
References: <20070802112852.GA7054@in.ibm.com>
	<31687.1186113947@kao2.melbourne.sgi.com>
	<20070805110746.GA12540@in.ibm.com>
	<46C1691E.7090708@ah.jp.nec.com>
	<20070814083710.GA14538@suse.de> <46C16C7B.603@ah.jp.nec.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <46C16C7B.603@ah.jp.nec.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org+dwmw2=infradead.org@lists.infradead.org
To: Takenori Nagano <t-nagano@ah.jp.nec.com>
Cc: Keith Owens <kaos@sgi.com>, k-miyoshi@cb.jp.nec.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, vgoyal@in.ibm.com, "Eric W. Biederman" <ebiederm@xmission.com>, Andrew Morton <akpm@linux-foundation.org>

KiBUYWtlbm9yaSBOYWdhbm8gPHQtbmFnYW5vQGFoLmpwLm5lYy5jb20+IFsyMDA3LTA4LTE0IDEw
OjQ4XToKPiBCZXJuaGFyZCBXYWxsZSB3cm90ZToKPiA+ICogVGFrZW5vcmkgTmFnYW5vIDx0LW5h
Z2Fub0BhaC5qcC5uZWMuY29tPiBbMjAwNy0wOC0xNCAxMDozNF06Cj4gPj4gVml2ZWsgR295YWwg
d3JvdGU6Cj4gPj4+IE9uIEZyaSwgQXVnIDAzLCAyMDA3IGF0IDAyOjA1OjQ3UE0gKzEwMDAsIEtl
aXRoIE93ZW5zIHdyb3RlOgo+ID4+Pgo+ID4+Pgo+ID4+PiBUbyBzdW0gdXAsIGNvdXBsZSBvZiBv
cHRpb25zIGNvbWUgdG8gbWluZC4KPiA+Pj4KPiA+Pj4gLSBSZWdpc3RlciBhbGwgdGhlIFJBUyB0
b29scyBvbiBkaWUgbm90aWZpZXIgYW5kIHBhbmljCj4gPj4+ICAgbm90aWZpZXIgbGlzdHMgd2l0
aCBmYWlybHkgaGlnaCBwcmlvcml0eS4gRXhwb3J0IGxpc3QKPiA+Pj4gICBvZiBSQVMgdG9vbHMg
dG8gdXNlciBzcGFjZSBhbmQgYWxsb3cgdXNlcnMgdG8gZGVjaWRlIHRoZQo+ID4+PiAgIG9yZGVy
IG9mIGV4ZWN1dGlvbiBhbmQgcHJpb3JpdHkgb2YgUkFTIHRvb2xzLgo+ID4+Pgo+ID4+PiAtIENy
ZWF0ZSBhIHNlcGFyYXRlIFJBUyB0b29sIG5vdGlmaWVyIGxpc3QgKHJhc190b29sX25vdGlmZXJf
bGlzdCkuCj4gPj4+ICAgQWxsIHRoZSBSQVMgdG9vbHMgcmVnaXN0ZXIgb24gdGhpcyBsaXN0LiBU
aGlzIGxpc3QgZ2V0cyBwcmlvcml0eQo+ID4+PiAgIG92ZXIgZGllIG9yIHBhbmljIG5vdGlmaWVy
IGxpc3QuIFVzZXIgZGVjaWRlcyB0aGUgb2RlciBvZiBleGVjdXRpb24KPiA+Pj4gICBvZiBSQVMg
dG9vbHMuIAo+ID4+Pgo+ID4+PiAgIEhlcmUgYXNzdW1wdGlvbiBpcyB0aGF0IGFib3ZlIGxpc3Qg
d2lsbCBub3QgYmUgZXhwb3J0ZWQgdG8gbW9kdWxlcy4KPiA+Pj4gICBBbGwgdGhlIFJBUyB0b29s
cyB3aWxsIGJlIGluIGtlcm5lbCBhbmQgdGhleSBhbHdheXMgZ2V0IGEgcHJpb3JpdHkKPiA+Pj4g
ICB0byBpbnNwZWN0IGFuIGV2ZW50Lgo+ID4+Pgo+ID4+PiBXaGF0IGRvIG90aGVycyB0aGluaz8K
PiA+PiBWZXJ5IGdvb2QgaWRlYS4gQnV0IHRoZXJlIGlzIGEgcHJvYmxlbSBob3cgdG8gZ2l2ZSBk
ZWZhdWx0IHByaW9yaXR5IHRvIFJBUyB0b29scy4KPiA+Pgo+ID4+IEhvdyBhYm91dCBwcmlvcml0
eSBjaGFuZ2VhYmxlIG5vdGlmaWVyX2xpc3Q/IFVzZXIgY2FuIGNoYW5nZSBsaXN0IG9yZGVyCj4g
Pj4gZHluYW1pY2FsbHkgaWYgdGhleSB3YW50LiBPZiBjb3Vyc2UsIHdlIGhhdmUgdG8gZ2l2ZSBo
aWdoZXN0IHByaW9yaXR5IHRvIGtkdW1wCj4gPj4gYnkgZGVmYXVsdC4gSXQgaXMgdmVyeSB1c2Vm
dWwgZm9yIHVzZXJzIHdobyB3YW50IHRvIHVzZSBzb21lIFJBUyB0b29scy4KPiA+IAo+ID4gSSB0
aGluayB0aGF0IHdhcyB0aGUgaWRlYSBvZiB0aGUgZmlyc3Qg4oCcLeKAnSAo4oCcZXhwb3J0IGxp
c3Qgb2YgUkFTIHRvb2xzCj4gPiB0byB1c2VyIHNwYWNl4oCdKS4KPiAKPiBBaCwgc29ycnkuCj4g
Cj4gSSB0aGluayBmaXJzdCBpZGVhIGlzIHZlcnkgZ29vZC4gSG93IGV4cG9ydCB0aGUgbGlzdD8g
KHN5c2ZzPyBwcm9jZnM/KQoKSSB0aGluayBzeXNmcyB3b3VsZCBiZSBhIGdvb2Qgc29sdXRpb24s
IGUuZy4gYXNzaWduaW5nIGVhY2ggUkFTIHRvb2wgYQpwcmlvcml0eSBmcm9tIDAgdG8gMTAwIG9y
IHNvbWV0aGluZyBsaWtlIHRoaXMuCgoKVGhhbmtzLAogICBCZXJuaGFyZAoKX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18Ka2V4ZWMgbWFpbGluZyBsaXN0Cmtl
eGVjQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1h
bi9saXN0aW5mby9rZXhlYwo=
