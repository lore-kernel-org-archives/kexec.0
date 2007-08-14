Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e4.ny.us.ibm.com ([32.97.182.144])
	by canuck.infradead.org with esmtps (Exim 4.63 #1 (Red Hat Linux))
	id 1IKwOJ-0004LU-Ln
	for kexec@lists.infradead.org; Tue, 14 Aug 2007 09:25:04 -0400
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e4.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id l7EDOpRh006345
	for <kexec@lists.infradead.org>; Tue, 14 Aug 2007 09:24:51 -0400
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v8.4) with ESMTP id
	l7EDOpFS459076
	for <kexec@lists.infradead.org>; Tue, 14 Aug 2007 09:24:51 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l7EDOoAx002596
	for <kexec@lists.infradead.org>; Tue, 14 Aug 2007 09:24:50 -0400
Date: Tue, 14 Aug 2007 18:54:54 +0530
From: Vivek Goyal <vgoyal@in.ibm.com>
Subject: Re: [patch] add kdump_after_notifier
Message-ID: <20070814132454.GA8293@in.ibm.com>
References: <20070802112852.GA7054@in.ibm.com>
	<31687.1186113947@kao2.melbourne.sgi.com>
	<20070805110746.GA12540@in.ibm.com>
	<46C1691E.7090708@ah.jp.nec.com> <20070814083710.GA14538@suse.de>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20070814083710.GA14538@suse.de>
Reply-To: vgoyal@in.ibm.com
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
To: Takenori Nagano <t-nagano@ah.jp.nec.com>, Keith Owens <kaos@sgi.com>, "Eric W. Biederman" <ebiederm@xmission.com>, k-miyoshi@cb.jp.nec.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>

T24gVHVlLCBBdWcgMTQsIDIwMDcgYXQgMTA6Mzc6MTBBTSArMDIwMCwgQmVybmhhcmQgV2FsbGUg
d3JvdGU6Cj4gKiBUYWtlbm9yaSBOYWdhbm8gPHQtbmFnYW5vQGFoLmpwLm5lYy5jb20+IFsyMDA3
LTA4LTE0IDEwOjM0XToKPiA+IFZpdmVrIEdveWFsIHdyb3RlOgo+ID4gPiBPbiBGcmksIEF1ZyAw
MywgMjAwNyBhdCAwMjowNTo0N1BNICsxMDAwLCBLZWl0aCBPd2VucyB3cm90ZToKPiA+ID4gCj4g
PiA+IAo+ID4gPiBUbyBzdW0gdXAsIGNvdXBsZSBvZiBvcHRpb25zIGNvbWUgdG8gbWluZC4KPiA+
ID4gCj4gPiA+IC0gUmVnaXN0ZXIgYWxsIHRoZSBSQVMgdG9vbHMgb24gZGllIG5vdGlmaWVyIGFu
ZCBwYW5pYwo+ID4gPiAgIG5vdGlmaWVyIGxpc3RzIHdpdGggZmFpcmx5IGhpZ2ggcHJpb3JpdHku
IEV4cG9ydCBsaXN0Cj4gPiA+ICAgb2YgUkFTIHRvb2xzIHRvIHVzZXIgc3BhY2UgYW5kIGFsbG93
IHVzZXJzIHRvIGRlY2lkZSB0aGUKPiA+ID4gICBvcmRlciBvZiBleGVjdXRpb24gYW5kIHByaW9y
aXR5IG9mIFJBUyB0b29scy4KPiA+ID4gCj4gPiA+IC0gQ3JlYXRlIGEgc2VwYXJhdGUgUkFTIHRv
b2wgbm90aWZpZXIgbGlzdCAocmFzX3Rvb2xfbm90aWZlcl9saXN0KS4KPiA+ID4gICBBbGwgdGhl
IFJBUyB0b29scyByZWdpc3RlciBvbiB0aGlzIGxpc3QuIFRoaXMgbGlzdCBnZXRzIHByaW9yaXR5
Cj4gPiA+ICAgb3ZlciBkaWUgb3IgcGFuaWMgbm90aWZpZXIgbGlzdC4gVXNlciBkZWNpZGVzIHRo
ZSBvZGVyIG9mIGV4ZWN1dGlvbgo+ID4gPiAgIG9mIFJBUyB0b29scy4gCj4gPiA+IAo+ID4gPiAg
IEhlcmUgYXNzdW1wdGlvbiBpcyB0aGF0IGFib3ZlIGxpc3Qgd2lsbCBub3QgYmUgZXhwb3J0ZWQg
dG8gbW9kdWxlcy4KPiA+ID4gICBBbGwgdGhlIFJBUyB0b29scyB3aWxsIGJlIGluIGtlcm5lbCBh
bmQgdGhleSBhbHdheXMgZ2V0IGEgcHJpb3JpdHkKPiA+ID4gICB0byBpbnNwZWN0IGFuIGV2ZW50
Lgo+ID4gPiAKPiA+ID4gV2hhdCBkbyBvdGhlcnMgdGhpbms/Cj4gPiAKPiA+IFZlcnkgZ29vZCBp
ZGVhLiBCdXQgdGhlcmUgaXMgYSBwcm9ibGVtIGhvdyB0byBnaXZlIGRlZmF1bHQgcHJpb3JpdHkg
dG8gUkFTIHRvb2xzLgo+ID4gCj4gPiBIb3cgYWJvdXQgcHJpb3JpdHkgY2hhbmdlYWJsZSBub3Rp
Zmllcl9saXN0PyBVc2VyIGNhbiBjaGFuZ2UgbGlzdCBvcmRlcgo+ID4gZHluYW1pY2FsbHkgaWYg
dGhleSB3YW50LiBPZiBjb3Vyc2UsIHdlIGhhdmUgdG8gZ2l2ZSBoaWdoZXN0IHByaW9yaXR5IHRv
IGtkdW1wCj4gPiBieSBkZWZhdWx0LiBJdCBpcyB2ZXJ5IHVzZWZ1bCBmb3IgdXNlcnMgd2hvIHdh
bnQgdG8gdXNlIHNvbWUgUkFTIHRvb2xzLgo+IAo+IEkgdGhpbmsgdGhhdCB3YXMgdGhlIGlkZWEg
b2YgdGhlIGZpcnN0IOKAnC3igJ0gKOKAnGV4cG9ydCBsaXN0IG9mIFJBUyB0b29scwo+IHRvIHVz
ZXIgc3BhY2XigJ0pLgo+IAoKU28gZm9yIHRoZSB0aW1lIGJlaW5nIEkgdGhpbmsgd2UgY2FuIHB1
dCBSQVMgdG9vbHMgb24gZGllIG5vdGlmaWVyIGxpc3QKYW5kIGlmIGl0IHJ1bnMgaW50byBpc3N1
ZXMgd2UgY2FuIGFsd2F5cyB0aGluayBvZiBjcmVhdGluZyBhIHNlcGFyYXRlIGxpc3QuCgpGZXcg
dGhpbmdzIGNvbWUgdG8gbWluZC4KCi0gV2h5IHRoZXJlIGlzIGEgc2VwYXJhdGUgcGFuaWNfbm90
aWZpZXJfbGlzdD8gQ2FuJ3QgaXQgYmUgbWVyZ2VkIHdpdGgKICBkaWVfY2hhaW4/IGRpZV92YWwg
YWxyZWFkeSBnb3Qgb25lIG9mIHRoZSBldmVudCB0eXBlIGFzIFBBTklDLiBJZiB0aGVyZQogIGFy
ZSBubyBzcGVjaWZpYyByZWFzb25zIHRoZW4gd2Ugc2hvdWxkIG1lcmdlIHRoZSB0d28gbGlzdHMu
IFJlZ2lzdGVyaW5nCiAgUkFTIHRvb2xzIG9uIGEgc2luZ2xlIGxpc3QgaXMgZWFzaWVyLgotIE1v
ZGlmeSBLZHVtcCB0byByZWdpc3RlciBvbiBkaWVfY2hhaW4gbGlzdC4gCi0gTW9kaWZ5IEtkYiB0
byByZWdpc3RlciBvbiBkaWVfY2hhaW4gbGlzdC4KLSBFeHBvcnQgYWxsIHRoZSByZWdpc3RlcmVk
IG1lbWJlcnMgb2YgZGllX2NoYWluIHRocm91Z2ggc3lzZnMgYWxvbmcgd2l0aAogIHRoZWlyIHBy
aW9yaXRpZXMuIFByaW9yaXRpZXMgc2hvdWxkIGJlIG1vZGlmaWFibGUuIE1vc3QgbGlrZWx5IG9u
ZSAKICBzaGFsbCBoYXZlIHRvIGludHJvZHVjZSBhZGRpdGlvbmFsIGZpZWxkIGluIHN0cnVjdCBu
b3RpZmllcl9ibG9jay4gVGhpcwogIGZpZWxkIHdpbGwgYmUgYSBzdHJpbmcgYXMgYW4gaWRlbnRp
ZmllciBvZiB0aGUgdXNlciByZWdpc3RlcmQuIGUuZwogICJLZHVtcCIsICJLZGIiIGV0Yy4KCk5v
dyB1c2VyIHdpbGwgYmUgYWJsZSB0byB2aWV3IGFsbCB0aGUgZGllX2NoYWluIHVzZXJzIHRocm91
Z2ggc3lzZnMgYW5kCmJlIGFibGUgdG8gbW9kaWZ5IHRoZSBvcmRlciBpbiB3aGljaCB0aGVzZSBz
aG91bGQgcnVuIGJ5IG1vZGlmeWluZyB0aGVpcgpwcmlvcml0eS4gSGVuY2UgYWxsIHRoZSBSQVMg
dG9vbHMgY2FuIGNvLWV4aXN0LgoKQW55IHRob3VnaHRzPwoKVGhhbmtzClZpdmVrCgoKCgo+IAo+
IFRoYW5rcywKPiAgICBCZXJuaGFyZAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18Ka2V4ZWMgbWFpbGluZyBsaXN0CmtleGVjQGxpc3RzLmluZnJhZGVhZC5v
cmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9rZXhlYwo=
