Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]
 helo=mx0a-001b2d01.pphosted.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1fOt6i-0002XC-KO
 for kexec@lists.infradead.org; Fri, 01 Jun 2018 23:05:18 +0000
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w51N4B7Z140733
 for <kexec@lists.infradead.org>; Fri, 1 Jun 2018 19:05:05 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2jbaj2aq64-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <kexec@lists.infradead.org>; Fri, 01 Jun 2018 19:05:04 -0400
Received: from localhost
 by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <zohar@linux.vnet.ibm.com>;
 Sat, 2 Jun 2018 00:05:02 +0100
Subject: Re: [PATCH v4 5/8] ima: based on policy require signed firmware
 (sysfs fallback)
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
Date: Fri, 01 Jun 2018 19:04:45 -0400
In-Reply-To: <20180601224617.GU4511@wotan.suse.de>
References: <1527616920-5415-1-git-send-email-zohar@linux.vnet.ibm.com>
 <1527616920-5415-6-git-send-email-zohar@linux.vnet.ibm.com>
 <20180601182107.GO4511@wotan.suse.de>
 <1527892795.13403.26.camel@linux.vnet.ibm.com>
 <20180601224617.GU4511@wotan.suse.de>
Mime-Version: 1.0
Message-Id: <1527894285.13403.43.camel@linux.vnet.ibm.com>
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
To: "Luis R. Rodriguez" <mcgrof@kernel.org>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Matthew Garrett <mjg59@google.com>, David Howells <dhowells@redhat.com>, linux-security-module@vger.kernel.org, Eric Biederman <ebiederm@xmission.com>, linux-integrity@vger.kernel.org, Andres Rodriguez <andresx7@gmail.com>

T24gU2F0LCAyMDE4LTA2LTAyIGF0IDAwOjQ2ICswMjAwLCBMdWlzIFIuIFJvZHJpZ3VleiB3cm90
ZToKPiBPbiBGcmksIEp1biAwMSwgMjAxOCBhdCAwNjozOTo1NVBNIC0wNDAwLCBNaW1pIFpvaGFy
IHdyb3RlOgo+ID4gT24gRnJpLCAyMDE4LTA2LTAxIGF0IDIwOjIxICswMjAwLCBMdWlzIFIuIFJv
ZHJpZ3VleiB3cm90ZToKPiA+ID4gT24gVHVlLCBNYXkgMjksIDIwMTggYXQgMDI6MDE6NTdQTSAt
MDQwMCwgTWltaSBab2hhciB3cm90ZToKPiA+ID4gPiBMdWlzLCBpcyB0aGUgc2VjdXJpdHlfa2Vy
bmVsX3Bvc3RfcmVhZF9maWxlIExTTSBob29rIGluCj4gPiA+ID4gZmlybXdhcmVfbG9hZGluZ19z
dG9yZSgpIHN0aWxsIG5lZWRlZCBhZnRlciB0aGlzIHBhdGNoPyAgU2hvdWxkIGl0IGJlCj4gPiA+
ID4gY2FsbGluZyBzZWN1cml0eV9rZXJuZWxfbG9hZF9kYXRhKCkgaW5zdGVhZD8KPiA+ID4gCj4g
PiA+IFRoYXQncyB1cCB0byBLZWVzIHRvIGRlY2lkZSBhcyBoZSBhZGRlZCB0aGF0IGhvb2ssIGFu
ZCBrbm93cwo+ID4gPiB3aGF0IExTTXMgbWF5IGJlIGRvaW5nIHdpdGggaXQuIEZyb20gbXkgcGVy
c3BlY3RpdmUgaXQgaXMgY29uZnVzaW5nCj4gPiA+IHRvIGhhdmUgdGhhdCBob29rIHRoZXJlIHNv
IEkgdGhpbmsgaXQgY291bGQgYmUgcmVtb3ZlZCBub3cuCj4gPiA+IAo+ID4gPiBLZWVzPwo+ID4g
Cj4gPiBDb21taXTCoDY1OTNkOTIgKCJmaXJtd2FyZV9jbGFzczogcGVyZm9ybSBuZXcgTFNNIGNo
ZWNrcyIpIHJlZmVyZW5jZXMKPiA+IHR3byBtZXRob2RzIG9mIGxvYWRpbmcgZmlybXdhcmUgLcKg
wqBmaWxlc3lzdGVtLWZvdW5kIGZpcm13YXJlIGFuZAo+ID4gZGVtYW5kLWxvYWRlZCBibG9icy4g
wqBJIGFzc3VtZSB0aGlzIGNhbGwgaW4gZmlybXdhcmVfbG9hZGluZ19zdG9yZSgpCj4gPiBpcyB0
aGUgZGVtYW5kLWxvYWRlZCBibG9icy4gwqBEb2VzIHRoYXQgbWV0aG9kIHN0aWxsIGV4aXN0PyDC
oElzIGl0Cj4gPiBzdGlsbCBiZWluZyB1c2VkPwo+IAo+IFllYWggaXRzIHRoZSBzdHVwaWQgc3lz
ZnMgaW50ZXJmYWNlLiBTbyBsaWtlbHkgbG9hZHBpbiBuZWVkcyBwb3J0aW5nCj4gYXMgeW91IElN
QSBhcyB5b3UgZGlkLgoKSW4gdGhpcyBjYXNlLCBpdCBkb2Vzbid0IGxvb2sgbGlrZSB0aGUgY2Fs
bCB0bwpzZWN1cml0eV9rZXJuZWxfcG9zdF9yZWFkX2ZpbGUoKSBzaG91bGQgYmUgY2hhbmdlZCwg
d2hpY2ggbWVhbnMgdGhhdAphbGwgdGhlIExTTXMgYW5kIElNQSBzdGlsbCBuZWVkIHRvIHN1cHBv
cnQgIWZpbGUuCsKgCk1pbWkKCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwprZXhlYyBtYWlsaW5nIGxpc3QKa2V4ZWNAbGlzdHMuaW5mcmFkZWFkLm9yZwpo
dHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2tleGVjCg==
