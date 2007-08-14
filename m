Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from ns.suse.de ([195.135.220.2] helo=mx1.suse.de)
	by canuck.infradead.org with esmtps (Exim 4.63 #1 (Red Hat Linux))
	id 1IKrtr-0001cb-Dc
	for kexec@lists.infradead.org; Tue, 14 Aug 2007 04:37:20 -0400
Date: Tue, 14 Aug 2007 10:37:10 +0200
From: Bernhard Walle <bwalle@suse.de>
Subject: Re: [patch] add kdump_after_notifier
Message-ID: <20070814083710.GA14538@suse.de>
References: <20070802112852.GA7054@in.ibm.com>
	<31687.1186113947@kao2.melbourne.sgi.com>
	<20070805110746.GA12540@in.ibm.com>
	<46C1691E.7090708@ah.jp.nec.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <46C1691E.7090708@ah.jp.nec.com>
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
OjM0XToKPiBWaXZlayBHb3lhbCB3cm90ZToKPiA+IE9uIEZyaSwgQXVnIDAzLCAyMDA3IGF0IDAy
OjA1OjQ3UE0gKzEwMDAsIEtlaXRoIE93ZW5zIHdyb3RlOgo+ID4gCj4gPiAKPiA+IFRvIHN1bSB1
cCwgY291cGxlIG9mIG9wdGlvbnMgY29tZSB0byBtaW5kLgo+ID4gCj4gPiAtIFJlZ2lzdGVyIGFs
bCB0aGUgUkFTIHRvb2xzIG9uIGRpZSBub3RpZmllciBhbmQgcGFuaWMKPiA+ICAgbm90aWZpZXIg
bGlzdHMgd2l0aCBmYWlybHkgaGlnaCBwcmlvcml0eS4gRXhwb3J0IGxpc3QKPiA+ICAgb2YgUkFT
IHRvb2xzIHRvIHVzZXIgc3BhY2UgYW5kIGFsbG93IHVzZXJzIHRvIGRlY2lkZSB0aGUKPiA+ICAg
b3JkZXIgb2YgZXhlY3V0aW9uIGFuZCBwcmlvcml0eSBvZiBSQVMgdG9vbHMuCj4gPiAKPiA+IC0g
Q3JlYXRlIGEgc2VwYXJhdGUgUkFTIHRvb2wgbm90aWZpZXIgbGlzdCAocmFzX3Rvb2xfbm90aWZl
cl9saXN0KS4KPiA+ICAgQWxsIHRoZSBSQVMgdG9vbHMgcmVnaXN0ZXIgb24gdGhpcyBsaXN0LiBU
aGlzIGxpc3QgZ2V0cyBwcmlvcml0eQo+ID4gICBvdmVyIGRpZSBvciBwYW5pYyBub3RpZmllciBs
aXN0LiBVc2VyIGRlY2lkZXMgdGhlIG9kZXIgb2YgZXhlY3V0aW9uCj4gPiAgIG9mIFJBUyB0b29s
cy4gCj4gPiAKPiA+ICAgSGVyZSBhc3N1bXB0aW9uIGlzIHRoYXQgYWJvdmUgbGlzdCB3aWxsIG5v
dCBiZSBleHBvcnRlZCB0byBtb2R1bGVzLgo+ID4gICBBbGwgdGhlIFJBUyB0b29scyB3aWxsIGJl
IGluIGtlcm5lbCBhbmQgdGhleSBhbHdheXMgZ2V0IGEgcHJpb3JpdHkKPiA+ICAgdG8gaW5zcGVj
dCBhbiBldmVudC4KPiA+IAo+ID4gV2hhdCBkbyBvdGhlcnMgdGhpbms/Cj4gCj4gVmVyeSBnb29k
IGlkZWEuIEJ1dCB0aGVyZSBpcyBhIHByb2JsZW0gaG93IHRvIGdpdmUgZGVmYXVsdCBwcmlvcml0
eSB0byBSQVMgdG9vbHMuCj4gCj4gSG93IGFib3V0IHByaW9yaXR5IGNoYW5nZWFibGUgbm90aWZp
ZXJfbGlzdD8gVXNlciBjYW4gY2hhbmdlIGxpc3Qgb3JkZXIKPiBkeW5hbWljYWxseSBpZiB0aGV5
IHdhbnQuIE9mIGNvdXJzZSwgd2UgaGF2ZSB0byBnaXZlIGhpZ2hlc3QgcHJpb3JpdHkgdG8ga2R1
bXAKPiBieSBkZWZhdWx0LiBJdCBpcyB2ZXJ5IHVzZWZ1bCBmb3IgdXNlcnMgd2hvIHdhbnQgdG8g
dXNlIHNvbWUgUkFTIHRvb2xzLgoKSSB0aGluayB0aGF0IHdhcyB0aGUgaWRlYSBvZiB0aGUgZmly
c3Qg4oCcLeKAnSAo4oCcZXhwb3J0IGxpc3Qgb2YgUkFTIHRvb2xzCnRvIHVzZXIgc3BhY2XigJ0p
LgoKClRoYW5rcywKICAgQmVybmhhcmQKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fCmtleGVjIG1haWxpbmcgbGlzdAprZXhlY0BsaXN0cy5pbmZyYWRlYWQu
b3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8va2V4ZWMK
