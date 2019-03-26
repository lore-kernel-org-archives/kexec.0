Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]
 helo=mx0a-001b2d01.pphosted.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1h8mZi-0004D2-6R
 for kexec@lists.infradead.org; Tue, 26 Mar 2019 13:57:11 +0000
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x2QDsIQc108459
 for <kexec@lists.infradead.org>; Tue, 26 Mar 2019 09:57:08 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2rfmc83gvc-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <kexec@lists.infradead.org>; Tue, 26 Mar 2019 09:57:07 -0400
Received: from localhost
 by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <zohar@linux.ibm.com>;
 Tue, 26 Mar 2019 13:57:05 -0000
Subject: Re: [PATCH v4a 1/2] selftests/kexec: make tests independent of IMA
 being enabled
From: Mimi Zohar <zohar@linux.ibm.com>
Date: Tue, 26 Mar 2019 09:56:50 -0400
In-Reply-To: <20190326074942.GA19708@dhcp-128-65.nay.redhat.com>
References: <1553283351-6310-1-git-send-email-zohar@linux.ibm.com>
 <20190325080935.GA12497@dhcp-128-65.nay.redhat.com>
 <1553546236.5561.7.camel@linux.ibm.com>
 <20190326074942.GA19708@dhcp-128-65.nay.redhat.com>
Mime-Version: 1.0
Message-Id: <1553608610.3960.37.camel@linux.ibm.com>
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

T24gVHVlLCAyMDE5LTAzLTI2IGF0IDE1OjQ5ICswODAwLCBEYXZlIFlvdW5nIHdyb3RlOgo+IE9u
IDAzLzI1LzE5IGF0IDA0OjM3cG0sIE1pbWkgWm9oYXIgd3JvdGU6Cj4gPiBPbiBNb24sIDIwMTkt
MDMtMjUgYXQgMTY6MDkgKzA4MDAsIERhdmUgWW91bmcgd3JvdGU6Cj4gPiA+IEhpIE1pbWkKPiA+
ID4gT24gMDMvMjIvMTkgYXQgMDM6MzVwbSwgTWltaSBab2hhciB3cm90ZToKPiA+ID4gPiBWZXJp
ZnkgSU1BIGlzIGVuYWJsZWQgYmVmb3JlIGZhaWxpbmcgdGVzdHMgb3IgZW1pdHRpbmcgaXJyZWxl
dmFudAo+ID4gPiA+IG1lc3NhZ2VzLiAgQWxzbywgZG9uJ3Qgc2tpcCB0aGUgdGVzdCBpZiBzaWdu
YXR1cmVzIGFyZSBub3QgcmVxdWlyZWQuCj4gPiA+ID4gCj4gPiA+ID4gU3VnZ2VzdGVkLWJ5OiBE
YXZlIFlvdW5nIDxkeW91bmdAcmVkaGF0LmNvbT4KPiA+ID4gPiBTaWduZWQtb2ZmLWJ5OiBNaW1p
IFpvaGFyIDx6b2hhckBsaW51eC5pYm0uY29tPgo+ID4gPiA+IC0tLQo+ID4gPiA+IERhdmUsIGlm
IHRoaXMgcGF0Y2ggcmVzb2x2ZXMgdGhlIG91dHN0YW5kaW5nIGlzc3VlcywgSSBjYW4gZm9sZCB0
aGVzZQo+ID4gPiA+IGNoYW5nZXMgaW50byB0aGUgb3JpZ2luYWwgcGF0Y2hlcy4gKFJlbWluZGVy
LCB0aGVzZSBwYXRjaGVzIHdpbGwgbmVlZCB0bwo+ID4gPiA+IGJlIHVwZGF0ZWQgdG8gc3VwcG9y
dCB0aGUgImxvY2tkb3duIiBwYXRjaCBzZXQuKQo+ID4gPiAKPiA+ID4gVGhleSBsb29rcyBnb29k
IHRvIG1lLCB0aGFua3MgZm9yIHRoZSB1cGRhdGUKPiA+IAo+ID4gSSd2ZSBmb2xkZWQgdGhlIGtl
eGVjX2ZpbGVfbG9hZCBjaGFuZ2VzIGludG8gdGhlIGtleGVjX2ZpbGVfbG9hZCB0ZXN0Lgo+ID4g
wqBUaGUgcmVtYWluaW5nIGtleGVjX2xvYWQgY2hhbmdlIGlzIGxlZnQgYXMgYSBzZXBhcmF0ZSBw
YXRjaCwgc2luY2UgaXQKPiA+IGlzIGRlcGVuZGVudCBvbiB0aGUgaWtjb25maWcgY2hhbmdlLgo+
ID4gCj4gPiA+IEZlZWwgZnJlZSB0byBhZGQgbXkgcmV2aWV3ZWQtYnksIEkgZGlkIHNvbWUgdGVz
dHMgYWx0aG91Z2ggbm90IGNvdmVyIGFsbAo+ID4gPiBpbWEgY2FzZXMuCj4gPiAKPiA+IFRoYW5r
cyEgwqBJcyB0aGlzIG1lYW50IGFzIGEgZ2VuZXJhbCAicmV2aWV3ZWQtYnkiIGZvciBhbGwgb2Yg
dGhlCj4gPiBwYXRjaGVzIG9yIGp1c3QgdGhpcyBzcGVjaWZpYyBvbmU/Cj4gCj4gVGhhbmsgeW91
IGZvciB0YWtpbmcgdGhpcyBhcyBhIHNlcGFyYXRlIGtleGVjIHRlc3RzLCBJIHRoaW5rIGl0IGNh
bgo+IGJlIHVzZWQgZm9yIHRoZXNlIGRlbHRhIGZpeGVzCgpPaywgSSBqdXN0IHJlLXBvc3RlZCB0
aGUgcGF0Y2hlcywgZm9sZGluZyBwYXJ0IG9mIHRoaXMgcGF0Y2ggaW50byB0aGUKa2V4ZWNfZmls
ZV9sb2FkIHRlc3QuIMKgSSd2ZSBhZGRlZCB5b3VyIFJldmlld2VkLWJ5IG9uIHRoZSByZW1haW5p
bmcKcGF0Y2guCgo+IAo+IEkgcmVhZCBhbGwgdGhlIHBhdGNoZXMgYW5kIHJldmlld2VkIHRoZSBr
ZXhlYyBzdHVmZiwgYnV0IEkgZG8gbm90Cj4gdW5kZXJzdGFuZCBhbGwgdGhlIElNQSBsb2dpYyB5
ZXQgYWx0aG91Z2ggSSBkaWQgc29tZSBzaW1wbGUgaW1hCj4gdGVzdHMuCgpJIHVuZGVyc3RhbmQu
IMKgVGhlcmUgYXJlIG1hbnkgZGlmZmVyZW50IGFzcGVjdHMgdG8gdGhlIGludGVncml0eQpzdWJz
eXN0ZW0uIMKgSSdtIGhhcHB5IHRvIGFuc3dlciBhbnkgcXVlc3Rpb25zIHlvdSBoYXZlLgoKTWlt
aQoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmtleGVj
IG1haWxpbmcgbGlzdAprZXhlY0BsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZy
YWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8va2V4ZWMK
