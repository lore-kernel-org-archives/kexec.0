Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1h8WLZ-0000P6-FJ
 for kexec@lists.infradead.org; Mon, 25 Mar 2019 20:37:33 +0000
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x2PKXPm2127662
 for <kexec@lists.infradead.org>; Mon, 25 Mar 2019 16:37:25 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2rf41fdjq7-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <kexec@lists.infradead.org>; Mon, 25 Mar 2019 16:37:25 -0400
Received: from localhost
 by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <zohar@linux.ibm.com>;
 Mon, 25 Mar 2019 20:37:22 -0000
Subject: Re: [PATCH v4a 1/2] selftests/kexec: make tests independent of IMA
 being enabled
From: Mimi Zohar <zohar@linux.ibm.com>
Date: Mon, 25 Mar 2019 16:37:16 -0400
In-Reply-To: <20190325080935.GA12497@dhcp-128-65.nay.redhat.com>
References: <1553283351-6310-1-git-send-email-zohar@linux.ibm.com>
 <20190325080935.GA12497@dhcp-128-65.nay.redhat.com>
Mime-Version: 1.0
Message-Id: <1553546236.5561.7.camel@linux.ibm.com>
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
To: Dave Young <dyoung@redhat.com>
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Matthew Garrett <mjg59@google.com>, Petr Vorel <pvorel@suse.cz>, linux-kselftest@vger.kernel.org, linux-integrity@vger.kernel.org

T24gTW9uLCAyMDE5LTAzLTI1IGF0IDE2OjA5ICswODAwLCBEYXZlIFlvdW5nIHdyb3RlOgo+IEhp
IE1pbWkKPiBPbiAwMy8yMi8xOSBhdCAwMzozNXBtLCBNaW1pIFpvaGFyIHdyb3RlOgo+ID4gVmVy
aWZ5IElNQSBpcyBlbmFibGVkIGJlZm9yZSBmYWlsaW5nIHRlc3RzIG9yIGVtaXR0aW5nIGlycmVs
ZXZhbnQKPiA+IG1lc3NhZ2VzLiAgQWxzbywgZG9uJ3Qgc2tpcCB0aGUgdGVzdCBpZiBzaWduYXR1
cmVzIGFyZSBub3QgcmVxdWlyZWQuCj4gPiAKPiA+IFN1Z2dlc3RlZC1ieTogRGF2ZSBZb3VuZyA8
ZHlvdW5nQHJlZGhhdC5jb20+Cj4gPiBTaWduZWQtb2ZmLWJ5OiBNaW1pIFpvaGFyIDx6b2hhckBs
aW51eC5pYm0uY29tPgo+ID4gLS0tCj4gPiBEYXZlLCBpZiB0aGlzIHBhdGNoIHJlc29sdmVzIHRo
ZSBvdXRzdGFuZGluZyBpc3N1ZXMsIEkgY2FuIGZvbGQgdGhlc2UKPiA+IGNoYW5nZXMgaW50byB0
aGUgb3JpZ2luYWwgcGF0Y2hlcy4gKFJlbWluZGVyLCB0aGVzZSBwYXRjaGVzIHdpbGwgbmVlZCB0
bwo+ID4gYmUgdXBkYXRlZCB0byBzdXBwb3J0IHRoZSAibG9ja2Rvd24iIHBhdGNoIHNldC4pCj4g
Cj4gVGhleSBsb29rcyBnb29kIHRvIG1lLCB0aGFua3MgZm9yIHRoZSB1cGRhdGUKCkkndmUgZm9s
ZGVkIHRoZSBrZXhlY19maWxlX2xvYWQgY2hhbmdlcyBpbnRvIHRoZSBrZXhlY19maWxlX2xvYWQg
dGVzdC4KwqBUaGUgcmVtYWluaW5nIGtleGVjX2xvYWQgY2hhbmdlIGlzIGxlZnQgYXMgYSBzZXBh
cmF0ZSBwYXRjaCwgc2luY2UgaXQKaXMgZGVwZW5kZW50IG9uIHRoZSBpa2NvbmZpZyBjaGFuZ2Uu
Cgo+IEZlZWwgZnJlZSB0byBhZGQgbXkgcmV2aWV3ZWQtYnksIEkgZGlkIHNvbWUgdGVzdHMgYWx0
aG91Z2ggbm90IGNvdmVyIGFsbAo+IGltYSBjYXNlcy4KClRoYW5rcyEgwqBJcyB0aGlzIG1lYW50
IGFzIGEgZ2VuZXJhbCAicmV2aWV3ZWQtYnkiIGZvciBhbGwgb2YgdGhlCnBhdGNoZXMgb3IganVz
dCB0aGlzIHNwZWNpZmljIG9uZT8KCk1pbWkKCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwprZXhlYyBtYWlsaW5nIGxpc3QKa2V4ZWNAbGlzdHMuaW5mcmFk
ZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2tleGVj
Cg==
