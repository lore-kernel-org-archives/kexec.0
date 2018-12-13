Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]
 helo=mx0a-001b2d01.pphosted.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXEiV-0001lx-Cn
 for kexec@lists.infradead.org; Thu, 13 Dec 2018 00:19:04 +0000
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 wBD0Ip6X147009
 for <kexec@lists.infradead.org>; Wed, 12 Dec 2018 19:18:51 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2pbbt7a362-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <kexec@lists.infradead.org>; Wed, 12 Dec 2018 19:18:30 -0500
Received: from localhost
 by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <zohar@linux.ibm.com>;
 Thu, 13 Dec 2018 00:18:29 -0000
Subject: Re: [PATCH v2 7/7] ima: Support platform keyring for kernel appraisal
From: Mimi Zohar <zohar@linux.ibm.com>
Date: Wed, 12 Dec 2018 19:18:21 -0500
In-Reply-To: <8736r2fw88.fsf@morokweng.localdomain>
References: <20181208202705.18673-1-nayna@linux.ibm.com>
 <20181208202705.18673-8-nayna@linux.ibm.com>
 <8736r2fw88.fsf@morokweng.localdomain>
Mime-Version: 1.0
Message-Id: <1544660301.3956.3.camel@linux.ibm.com>
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
To: Thiago Jung Bauermann <bauerman@linux.ibm.com>, Nayna Jain <nayna@linux.ibm.com>
Cc: linux-efi@vger.kernel.org, mpe@ellerman.id.au, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, dhowells@redhat.com, seth.forshee@canonical.com, linux-security-module@vger.kernel.org, keyrings@vger.kernel.org, ebiederm@xmission.com, jforbes@redhat.com, linux-integrity@vger.kernel.org, vgoyal@redhat.com

T24gV2VkLCAyMDE4LTEyLTEyIGF0IDE2OjE0IC0wMjAwLCBUaGlhZ28gSnVuZyBCYXVlcm1hbm4g
d3JvdGU6CltzbmlwXQoKPiBTdWJqZWN0OiBbUEFUQ0hdIGltYTogT25seSB1c2UgdGhlIHBsYXRm
b3JtIGtleXJpbmcgaWYgaXQncyBlbmFibGVkCj4gCj4gU2lnbmVkLW9mZi1ieTogVGhpYWdvIEp1
bmcgQmF1ZXJtYW5uIDxiYXVlcm1hbkBsaW51eC5pYm0uY29tPgoKR29vZCBjYXRjaCEgwqBUaGFu
a3MuCgpNaW1pCgo+IC0tLQo+ICBzZWN1cml0eS9pbnRlZ3JpdHkvaW1hL2ltYV9hcHByYWlzZS5j
IHwgMyArKy0KPiAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigt
KQo+IAo+IGRpZmYgLS1naXQgYS9zZWN1cml0eS9pbnRlZ3JpdHkvaW1hL2ltYV9hcHByYWlzZS5j
IGIvc2VjdXJpdHkvaW50ZWdyaXR5L2ltYS9pbWFfYXBwcmFpc2UuYwo+IGluZGV4IGU4ZjUyMDQ1
MDg5NS4uZjZhYzQwNWRhYWJiIDEwMDY0NAo+IC0tLSBhL3NlY3VyaXR5L2ludGVncml0eS9pbWEv
aW1hX2FwcHJhaXNlLmMKPiArKysgYi9zZWN1cml0eS9pbnRlZ3JpdHkvaW1hL2ltYV9hcHByYWlz
ZS5jCj4gQEAgLTI5Nyw3ICsyOTcsOCBAQCBpbnQgaW1hX2FwcHJhaXNlX21lYXN1cmVtZW50KGVu
dW0gaW1hX2hvb2tzIGZ1bmMsCj4gIAkJCXN0YXR1cyA9IElOVEVHUklUWV9VTktOT1dOOwo+ICAJ
CQlicmVhazsKPiAgCQl9Cj4gLQkJaWYgKHJjICYmIGZ1bmMgPT0gS0VYRUNfS0VSTkVMX0NIRUNL
KQo+ICsJCWlmIChJU19FTkFCTEVEKENPTkZJR19JTlRFR1JJVFlfUExBVEZPUk1fS0VZUklORykg
JiYgcmMgJiYKPiArCQkgICAgZnVuYyA9PSBLRVhFQ19LRVJORUxfQ0hFQ0spCj4gIAkJCXJjID0g
aW50ZWdyaXR5X2RpZ3NpZ192ZXJpZnkoSU5URUdSSVRZX0tFWVJJTkdfUExBVEZPUk0sCj4gIAkJ
CQkJCSAgICAgKGNvbnN0IGNoYXIgKil4YXR0cl92YWx1ZSwKPiAgCQkJCQkJICAgICB4YXR0cl9s
ZW4sCgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18Ka2V4
ZWMgbWFpbGluZyBsaXN0CmtleGVjQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmlu
ZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9rZXhlYwo=
