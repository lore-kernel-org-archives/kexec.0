Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]
 helo=mx0a-001b2d01.pphosted.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1fOsii-0007ks-E2
 for kexec@lists.infradead.org; Fri, 01 Jun 2018 22:40:30 +0000
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w51Md8PK052030
 for <kexec@lists.infradead.org>; Fri, 1 Jun 2018 18:40:15 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2jb9nj43ce-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <kexec@lists.infradead.org>; Fri, 01 Jun 2018 18:40:15 -0400
Received: from localhost
 by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <zohar@linux.vnet.ibm.com>;
 Fri, 1 Jun 2018 23:40:13 +0100
Subject: Re: [PATCH v4 5/8] ima: based on policy require signed firmware
 (sysfs fallback)
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
Date: Fri, 01 Jun 2018 18:39:55 -0400
In-Reply-To: <20180601182107.GO4511@wotan.suse.de>
References: <1527616920-5415-1-git-send-email-zohar@linux.vnet.ibm.com>
 <1527616920-5415-6-git-send-email-zohar@linux.vnet.ibm.com>
 <20180601182107.GO4511@wotan.suse.de>
Mime-Version: 1.0
Message-Id: <1527892795.13403.26.camel@linux.vnet.ibm.com>
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

T24gRnJpLCAyMDE4LTA2LTAxIGF0IDIwOjIxICswMjAwLCBMdWlzIFIuIFJvZHJpZ3VleiB3cm90
ZToKPiBPbiBUdWUsIE1heSAyOSwgMjAxOCBhdCAwMjowMTo1N1BNIC0wNDAwLCBNaW1pIFpvaGFy
IHdyb3RlOgo+ID4gTHVpcywgaXMgdGhlIHNlY3VyaXR5X2tlcm5lbF9wb3N0X3JlYWRfZmlsZSBM
U00gaG9vayBpbgo+ID4gZmlybXdhcmVfbG9hZGluZ19zdG9yZSgpIHN0aWxsIG5lZWRlZCBhZnRl
ciB0aGlzIHBhdGNoPyAgU2hvdWxkIGl0IGJlCj4gPiBjYWxsaW5nIHNlY3VyaXR5X2tlcm5lbF9s
b2FkX2RhdGEoKSBpbnN0ZWFkPwo+IAo+IFRoYXQncyB1cCB0byBLZWVzIHRvIGRlY2lkZSBhcyBo
ZSBhZGRlZCB0aGF0IGhvb2ssIGFuZCBrbm93cwo+IHdoYXQgTFNNcyBtYXkgYmUgZG9pbmcgd2l0
aCBpdC4gRnJvbSBteSBwZXJzcGVjdGl2ZSBpdCBpcyBjb25mdXNpbmcKPiB0byBoYXZlIHRoYXQg
aG9vayB0aGVyZSBzbyBJIHRoaW5rIGl0IGNvdWxkIGJlIHJlbW92ZWQgbm93Lgo+IAo+IEtlZXM/
CgpDb21taXTCoDY1OTNkOTIgKCJmaXJtd2FyZV9jbGFzczogcGVyZm9ybSBuZXcgTFNNIGNoZWNr
cyIpIHJlZmVyZW5jZXMKdHdvIG1ldGhvZHMgb2YgbG9hZGluZyBmaXJtd2FyZSAtwqDCoGZpbGVz
eXN0ZW0tZm91bmQgZmlybXdhcmUgYW5kCmRlbWFuZC1sb2FkZWQgYmxvYnMuIMKgSSBhc3N1bWUg
dGhpcyBjYWxsIGluIGZpcm13YXJlX2xvYWRpbmdfc3RvcmUoKQppcyB0aGUgZGVtYW5kLWxvYWRl
ZCBibG9icy4gwqBEb2VzIHRoYXQgbWV0aG9kIHN0aWxsIGV4aXN0PyDCoElzIGl0CnN0aWxsIGJl
aW5nIHVzZWQ/Cgo+IAo+ICAgTHVpcwo+IAo+ID4gCj4gPiAtLS0KPiA+IAo+ID4gV2l0aCBhbiBJ
TUEgcG9saWN5IHJlcXVpcmluZyBzaWduZWQgZmlybXdhcmUsIHRoaXMgcGF0Y2ggcHJldmVudHMK
PiA+IHRoZSBzeXNmcyBmYWxsYmFjayBtZXRob2Qgb2YgbG9hZGluZyBmaXJtd2FyZS4KPiA+IAo+
ID4gU2lnbmVkLW9mZi1ieTogTWltaSBab2hhciA8em9oYXJAbGludXgudm5ldC5pYm0uY29tPgo+
ID4gQ2M6IEx1aXMgUi4gUm9kcmlndWV6IDxtY2dyb2ZAc3VzZS5jb20+Cj4gPiBDYzogRGF2aWQg
SG93ZWxscyA8ZGhvd2VsbHNAcmVkaGF0LmNvbT4KPiA+IENjOiBNYXR0aGV3IEdhcnJldHQgPG1q
ZzU5QGdvb2dsZS5jb20+Cj4gPiAtLS0KPiA+ICBzZWN1cml0eS9pbnRlZ3JpdHkvaW1hL2ltYV9t
YWluLmMgfCAxMCArKysrKysrKystCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDkgaW5zZXJ0aW9ucygr
KSwgMSBkZWxldGlvbigtKQo+ID4gCj4gPiBkaWZmIC0tZ2l0IGEvc2VjdXJpdHkvaW50ZWdyaXR5
L2ltYS9pbWFfbWFpbi5jIGIvc2VjdXJpdHkvaW50ZWdyaXR5L2ltYS9pbWFfbWFpbi5jCj4gPiBp
bmRleCBhNTY1ZDQ2MDg0YzIuLjRhODdmNzgwOThjOCAxMDA2NDQKPiA+IC0tLSBhL3NlY3VyaXR5
L2ludGVncml0eS9pbWEvaW1hX21haW4uYwo+ID4gKysrIGIvc2VjdXJpdHkvaW50ZWdyaXR5L2lt
YS9pbWFfbWFpbi5jCj4gPiBAQCAtNDc1LDggKzQ3NSwxMCBAQCBpbnQgaW1hX3Bvc3RfcmVhZF9m
aWxlKHN0cnVjdCBmaWxlICpmaWxlLCB2b2lkICpidWYsIGxvZmZfdCBzaXplLAo+ID4gIAo+ID4g
IAlpZiAoIWZpbGUgJiYgcmVhZF9pZCA9PSBSRUFESU5HX0ZJUk1XQVJFKSB7Cj4gPiAgCQlpZiAo
KGltYV9hcHByYWlzZSAmIElNQV9BUFBSQUlTRV9GSVJNV0FSRSkgJiYKPiA+IC0JCSAgICAoaW1h
X2FwcHJhaXNlICYgSU1BX0FQUFJBSVNFX0VORk9SQ0UpKQo+ID4gKwkJICAgIChpbWFfYXBwcmFp
c2UgJiBJTUFfQVBQUkFJU0VfRU5GT1JDRSkpIHsKPiA+ICsJCQlwcl9lcnIoIlByZXZlbnQgZmly
bXdhcmUgbG9hZGluZ19zdG9yZS5cbiIpOwo+ID4gIAkJCXJldHVybiAtRUFDQ0VTOwkvKiBJTlRF
R1JJVFlfVU5LTk9XTiAqLwo+ID4gKwkJfQo+ID4gIAkJcmV0dXJuIDA7Cj4gPiAgCX0KPiA+ICAK
PiA+IEBAIC01MjAsNiArNTIyLDEyIEBAIGludCBpbWFfbG9hZF9kYXRhKGVudW0ga2VybmVsX2xv
YWRfZGF0YV9pZCBpZCkKPiA+ICAJCQlwcl9lcnIoImltcG9zc2libGUgdG8gYXBwcmFpc2UgYSBr
ZXJuZWwgaW1hZ2Ugd2l0aG91dCBhIGZpbGUgZGVzY3JpcHRvcjsgdHJ5IHVzaW5nIGtleGVjX2Zp
bGVfbG9hZCBzeXNjYWxsLlxuIik7Cj4gPiAgCQkJcmV0dXJuIC1FQUNDRVM7CS8qIElOVEVHUklU
WV9VTktOT1dOICovCj4gPiAgCQl9Cj4gPiArCQlicmVhazsKPiA+ICsJY2FzZSBMT0FESU5HX0ZJ
Uk1XQVJFOgo+ID4gKwkJaWYgKGltYV9hcHByYWlzZSAmIElNQV9BUFBSQUlTRV9GSVJNV0FSRSkg
ewo+ID4gKwkJCXByX2VycigiUHJldmVudCBmaXJtd2FyZSBzeXNmcyBmYWxsYmFjayBsb2FkaW5n
LlxuIik7Cj4gPiArCQkJcmV0dXJuIC1FQUNDRVM7CS8qIElOVEVHUklUWV9VTktOT1dOICovCj4g
PiArCQl9Cj4gPiAgCWRlZmF1bHQ6Cj4gPiAgCQlicmVhazsKPiA+ICAJfQo+ID4gLS0gCj4gPiAy
LjcuNQo+ID4gCj4gPiAKPiAKCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwprZXhlYyBtYWlsaW5nIGxpc3QKa2V4ZWNAbGlzdHMuaW5mcmFkZWFkLm9yZwpo
dHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2tleGVjCg==
