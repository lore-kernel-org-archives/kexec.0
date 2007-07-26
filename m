Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e34.co.us.ibm.com ([32.97.110.152])
	by canuck.infradead.org with esmtps (Exim 4.63 #1 (Red Hat Linux))
	id 1IE5fo-0006Wk-8D
	for kexec@lists.infradead.org; Thu, 26 Jul 2007 11:54:47 -0400
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e34.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l6QFsaSM002332
	for <kexec@lists.infradead.org>; Thu, 26 Jul 2007 11:54:36 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.4) with ESMTP id
	l6QFsZ6l044974
	for <kexec@lists.infradead.org>; Thu, 26 Jul 2007 09:54:35 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l6QFsYOl005016
	for <kexec@lists.infradead.org>; Thu, 26 Jul 2007 09:54:34 -0600
Date: Thu, 26 Jul 2007 21:24:45 +0530
From: Vivek Goyal <vgoyal@in.ibm.com>
Subject: Re: [patch] add kdump_after_notifier
Message-ID: <20070726155444.GC15969@in.ibm.com>
References: <469F55D0.4050203@ah.jp.nec.com> <20070726140702.GA8949@suse.de>
	<20070726153240.GA15969@in.ibm.com>
	<20070726153440.GA19095@suse.de>
	<20070726154415.GB15969@in.ibm.com>
	<20070726154718.GA25561@suse.de>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20070726154718.GA25561@suse.de>
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
To: Takenori Nagano <t-nagano@ah.jp.nec.com>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, k-miyoshi@cb.jp.nec.com, Andrew Morton <akpm@linux-foundation.org>, Bernhard Walle <bwalle@suse.de>

T24gVGh1LCBKdWwgMjYsIDIwMDcgYXQgMDU6NDc6MThQTSArMDIwMCwgQmVybmhhcmQgV2FsbGUg
d3JvdGU6Cj4gKiBWaXZlayBHb3lhbCA8dmdveWFsQGluLmlibS5jb20+IFsyMDA3LTA3LTI2IDE3
OjQ0XToKPiA+ID4gCj4gPiA+IE9mIGNvdXJzZSwgYnV0IHRoYXQncyB3aHkgdGhlIHBhdGNoIGRv
ZXNuJ3QgY2hhbmdlIHRoaXMgYnkgZGVmYXVsdCBidXQKPiA+ID4gZ2l2ZXMgdGhlIHVzZXIgdGhl
IGNob2ljZS4KPiA+ID4gCj4gPiAKPiA+IFdoYXQgdmFsdWUgd2lsbCBkaXN0cm8gc2V0IGl0IHRv
IGJ5IGRlZmF1bHQ/Cj4gCj4gMC4KPiAKPiA+IENhbiB3ZSBiZSBtb3JlIHNwZWNpZmljIGluIHRl
cm1zIG9mIGZ1bmN0aW9uYWxpdHkgYW5kIGNvZGUgdGhhdCBleGFjdGx5Cj4gPiB3aGF0IHdlIGFy
ZSB0cnlpbmcgdG8gZG8gYWZ0ZXIgcGFuaWM/Cj4gCj4gV2VsbCwgS0RCLCBidXQgbm93IGV2ZXJ5
Ym9keSBhbnN3ZXJzIHdpdGgg4oCcbm90IG1haW5saW5lIC0tIGRvZXNuJ3QKPiBjb3VudOKAnS4K
PiAKClRoYXQncyB0cnVlLiBJdHMgbm90IG1haW5saW5lLiBXZSBoYWQgc2ltaWxhciBkaXNjdXNz
aW9uIGluIHRoZSBwYXN0CmFsc28uIEkgdGhpbmsgd2Ugc2hvdWxkIGFsbG93IG9ubHkgYXVkaXRl
ZCBjb2RlIHRvIGJlIHJ1biBhZnRlciBwYW5pYygpLgpMZWF2aW5nIGl0IG9wZW4gdG8gbW9kdWxl
cyBvciB1bmF1ZGl0ZWQgY29kZSBtYWtlcyB0aGlzIHNvbHV0aW9uCnNvbWV0aGluZyBsaWtlIExL
Q0Qgd2hlcmUgd2hvbGUgbG90IG9mIGNvZGUgdXNlZCB0byBydW4gYWZ0ZXIgdGhlIGNyYXNoLApo
ZW5jZSB3YXMgdW5yZWxpYWJsZS4KCklmIEtEQiBnb2VzIG1haW5saW5lLCB0aGVuIEkgdGhpbmsg
aXQgaXMgbm90IGEgYmFkIGlkZWEgdG8gY2FsbCBkZWJ1Z2dlcgpmaXJzdCAoaWYgaXQgaXMgZW5h
YmxlZCkgYW5kIHRoZW4gb25lIGNhbiB0cmlnZ2VyIGNyYXNoIGR1bXAgZnJvbSBpbnNpZGUKdGhl
IGRlYnVnZ2VyLgoKVGhhbmtzClZpdmVrCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwprZXhlYyBtYWlsaW5nIGxpc3QKa2V4ZWNAbGlzdHMuaW5mcmFkZWFk
Lm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2tleGVjCg==
