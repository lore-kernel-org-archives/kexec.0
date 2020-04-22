Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jRAKY-0002Oo-Ut
 for kexec@lists.infradead.org; Wed, 22 Apr 2020 08:02:04 +0000
Date: Wed, 22 Apr 2020 10:01:57 +0200
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH v2] arm: redefine OPT_APPEND and OPT_RAMDISK
Message-ID: <20200422080151.GA32200@vergenet.net>
References: <20200416084441.GA16024@vergenet.net>
 <20200414085224.7069-1-l.stelmach@samsung.com>
 <CGME20200415105859eucas1p2db849d89aa9a338077a01784f73dad52@eucas1p2.samsung.com>
 <20200415105845.22067-1-l.stelmach@samsung.com>
 <dleftjmu76ns60.fsf%l.stelmach@samsung.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <dleftjmu76ns60.fsf%l.stelmach@samsung.com>
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
To: Lukasz Stelmach <l.stelmach@samsung.com>
Cc: kexec@lists.infradead.org

T24gTW9uLCBBcHIgMjAsIDIwMjAgYXQgMDQ6MzM6MTFQTSArMDIwMCwgTHVrYXN6IFN0ZWxtYWNo
IHdyb3RlOgo+ID4gT24gV2VkLCBBcHIgMTUsIDIwMjAgYXQgMTI6NTg6NDVQTSArMDIwMCwgxYF1
a2FzeiBTdGVsbWFjaCB3cm90ZToKPiA+PiBSZWRlZmluZSBPUFRfQVBQRU5EIHRvIGF2b2lkIGNs
YXNoIHdpdGggT1BUX0tFWEVDX1NZU0NBTExfQVVUTy4KPiA+PiBSZWRlZmluZSBPUFRfUkFNRElT
SyB0byBhdm9pZCBzdWNoIHByb2JsZW1zIGluIHRoZSBmdXR1cmUKPiA+Pgo+ID4+IFNpZ25lZC1v
ZmYtYnk6IMWBdWthc3ogU3RlbG1hY2ggPGwuc3RlbG1hY2ggYXQgc2Ftc3VuZy5jb20+Cj4gPgo+
ID4gSSBhbSBzbGlnaHRseSBjb25jZXJuZWQgdGhhdCB0aGlzIHdpbGwgYnJlYWsgdGhpbmdzIGZv
ciB1c2Vycy4KPiA+IEJ1dCBPVE9IIHBlcmhhcHMgd2UgYWxyZWFkeSBicm9rZSB0aGluZ3Mgd2hl
biBhZGRpbmcKPiA+IE9QVF9LRVhFQ19TWVNDQUxMX0FVVE8uCj4gPiBEbyB5b3UgaGF2ZSBhbnkg
dGhvdWdodHMgb24gdGhpcz8KPiAKPiBJIGFtIGF3YXJlIG9mIHRoaXMsIGJ1dCB0aGUgY3VycmVu
dCBhcHBlYXJzIHRvIGJlIGJyb2tlbiBtb3JlLiBXaGVuIEkKPiB3YXMgdXNpbmcgJy1hJyBpdCBk
aWRuJ3Qgd29yayBhcyBhZHZlcnRpc2VkIGluIHRoZSB1c2FnZSBtZXNzYWdlLiBTaG9ydAo+ICph
cmNoKiBvcHRpb25zIGFyZW4ndCBkb2N1bWVudGVkIHRoZXJlLCBzbyBJIHN1cHBvc2UgbW9zdCBw
ZW9wbGUgZGlkbid0Cj4gdXNlIHRoZW0uIEFSTSBpcyB0aGUgb25seSBhcmNoaXRlY3R1cmUgdGhh
dCBzdXBwb3J0cyBzaG9ydCBvcHRpb25zIGJ5Cj4gZGVmaW5pbmcgT1BUXyogYXMgY2hhcmFjdGVy
cy4gSFBQQSBhcHBlYXJzIHRvIGJlIHVzaW5nIHRoZW0gaW4gdGhlCj4gb3B0c3RyaW5nIChjb3Bp
ZWQgZnJvbSBBUk0/KSBidXQgbm90IGluIE9QVF8qLiBXb3VsZCB5b3UgbGlrZSBtZSB0bwo+IGNs
ZWFuIHRoaXMgdXAgdG9vIGluIHYzPwo+IAo+IEluIHN1bW1hcnk6IHVuZG9jdW1lbnRlZCwgb24g
b25lIHBsYXRmb3JtLgo+IAo+IFAuUy4gUGxlYXNlLCBjYyBtZS4gSSBhbSBub3Qgc3Vic2NyaWJl
ZCB0byB0aGUgbGlzdC4KClRoYW5rcyDFgXVrYXN6LAoKSSB0YWtlIHlvdXIgcG9pbnQgd2l0aCBy
ZWdhcmRzIHRvIHRoZXNlIGZlYXR1cmVzIGJlaW5nIHVuZG9jdW1lbnRlZC4KQW5kIEkgdGhpbmsg
dGhlIGV4dHJhIGNsZWFuLXVwIHlvdSBzdWdnZXN0IHNvdW5kcyBnb29kLgpDb3VsZCB5b3UgcG9z
dCBhIHYzIHdpdGggdGhhdCBpbmNsdWRlZD8KCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwprZXhlYyBtYWlsaW5nIGxpc3QKa2V4ZWNAbGlzdHMuaW5mcmFk
ZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2tleGVj
Cg==
