Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghJQu-0007Dm-A5
 for kexec@lists.infradead.org; Wed, 09 Jan 2019 19:22:33 +0000
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 x09J8U0V128082
 for <kexec@lists.infradead.org>; Wed, 9 Jan 2019 14:22:31 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2pwkbfb6vj-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <kexec@lists.infradead.org>; Wed, 09 Jan 2019 14:22:30 -0500
Received: from localhost
 by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <zohar@linux.ibm.com>;
 Wed, 9 Jan 2019 19:22:28 -0000
Subject: Re: [RFC PATCH 1/2] integrity, KEYS: add a reference to platform
 keyring
From: Mimi Zohar <zohar@linux.ibm.com>
Date: Wed, 09 Jan 2019 14:21:11 -0500
In-Reply-To: <20190109164824.19708-2-kasong@redhat.com>
References: <20190109164824.19708-1-kasong@redhat.com>
 <20190109164824.19708-2-kasong@redhat.com>
Mime-Version: 1.0
Message-Id: <1547061671.19931.239.camel@linux.ibm.com>
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
To: Kairui Song <kasong@redhat.com>, linux-kernel@vger.kernel.org
Cc: jwboyer@fedoraproject.org, ebiggers@google.com, dyoung@redhat.com, nayna@linux.ibm.com, kexec@lists.infradead.org, jmorris@namei.org, dhowells@redhat.com, keyrings@vger.kernel.org, linux-integrity@vger.kernel.org, dwmw2@infradead.org, bauerman@linux.ibm.com, serge@hallyn.com

T24gVGh1LCAyMDE5LTAxLTEwIGF0IDAwOjQ4ICswODAwLCBLYWlydWkgU29uZyB3cm90ZToKPiBD
dXJyZW50bHkga2V4ZWNfZmlsZV9sb2FkIHdpbGwgdmVyaWZ5IHRoZSBrZXJuZWwgaW1hZ2UgYmVp
bmcgbG9hZGVkCj4gYWdhaW5zdCAuYnVpbHRpbl90cnVzdGVkX2tleXMgb3IgLnNlY29uZGFyeV90
cnVzdGVkX2tleXMsIGJ1dCB0aGUKPiBpbWFnZSBjb3VsZCBiZSBzaWduZWQgd2l0aCB0aGlyZCBw
YXJ0IGtleXMgd2hpY2ggd2lsbCBiZSBwcm92aWRlZCBieQo+IHBsYXRmb3JtIG9yIGZpcm13YXJl
IGFuZCB0aGUga2V5cyB3b24ndCBiZSBhdmFpbGFibGUgaW4ga2V5cmluZ3MgbWVudGlvbmVkCj4g
YWJvdmUuCj4gCj4gQWZ0ZXIgY29tbWl0IGVhOTMxMDJmMzIyNCAoJ2ludGVncml0eTogRGVmaW5l
IGEgdHJ1c3RlZCBwbGF0Zm9ybSBrZXlyaW5nJykKPiBhIC5wbGF0Zm9ybSBrZXlyaW5nIGlzIGlu
dHJvZHVjZWQgdG8gc3RvcmUgdGhlIGtleXMgcHJvdmlkZWQgYnkgcGxhdGZvcm0KPiBvciBmaXJt
d2FyZS4gQW5kIHdpdGggYSBmZXcgZm9sbG93aW5nIGNvbW1pdHMsIG5vdyBrZXlzIHJlcXVpcmVk
IHRvIHZlcmlmeQo+IHRoZSBpbWFnZSBpcyBiZWluZyBpbXBvcnRlZCB0byAucGxhdGZvcm0ga2V5
cmluZywgYnV0IGN1cnJlbnRseSwgb25seQo+IElNQS1hcHByYWlzYWwgY291bGQgdXNlIHRoZSBr
ZXlyaW5nIGFuZCB2ZXJpZnkgdGhlIGltYWdlLgo+IAo+IFRoaXMgcGF0Y2ggZXhwb3NlcyB0aGUg
LnBsYXRmb3JtIGFuZCBtYWtlcyBvdGhlciBjb21wb25lbnRzLCBsaWtlCj4ga2V4ZWNfZmlsZV9s
b2FkLCBjb3VsZCB1c2UgdGhpcyAucGxhdGZvcm0ga2V5cmluZyB0byB2ZXJpZnkgdGhlCj4ga2Vy
bmVsIGltYWdlLgoKVGhlICJwbGF0Zm9ybSIga2V5cmluZyB3YXMgdXBzdHJlYW1lZCBpbiBvcmRl
ciB0byB2ZXJpZnkgdGhlIGtlcm5lbAppbWFnZSBiZWluZyBsb2FkZWQgYnkgdGhlIGtleGVjX2Zp
bGVfbG9hZCBzeXNjYWxsLiDCoFRoZSBpbnRlbnRpb25zIG9mCnRoaXMgcGF0Y2ggZGVzY3JpcHRp
b24gbmVlZHMgdG8gYmUgY2xlYXJlci4KCj4gCj4gU3VnZ2VzdGVkLWJ5OiBNaW1pIFpvaGFyIDx6
b2hhckBsaW51eC5pYm0uY29tPgo+IFNpZ25lZC1vZmYtYnk6IEthaXJ1aSBTb25nIDxrYXNvbmdA
cmVkaGF0LmNvbT4KPiAtLS0KPiAgY2VydHMvc3lzdGVtX2tleXJpbmcuYyAgICAgICAgfCAzICsr
Kwo+ICBpbmNsdWRlL2tleXMvc3lzdGVtX2tleXJpbmcuaCB8IDUgKysrKysKPiAgc2VjdXJpdHkv
aW50ZWdyaXR5L2RpZ3NpZy5jICAgfCA0ICsrKysKPiAgMyBmaWxlcyBjaGFuZ2VkLCAxMiBpbnNl
cnRpb25zKCspCj4gCj4gZGlmZiAtLWdpdCBhL2NlcnRzL3N5c3RlbV9rZXlyaW5nLmMgYi9jZXJ0
cy9zeXN0ZW1fa2V5cmluZy5jCj4gaW5kZXggODE3Mjg3MTc1MjNkLi5hNjFiOTUzOTBiODAgMTAw
NjQ0Cj4gLS0tIGEvY2VydHMvc3lzdGVtX2tleXJpbmcuYwo+ICsrKyBiL2NlcnRzL3N5c3RlbV9r
ZXlyaW5nLmMKPiBAQCAtMjQsNiArMjQsOSBAQCBzdGF0aWMgc3RydWN0IGtleSAqYnVpbHRpbl90
cnVzdGVkX2tleXM7Cj4gICNpZmRlZiBDT05GSUdfU0VDT05EQVJZX1RSVVNURURfS0VZUklORwo+
ICBzdGF0aWMgc3RydWN0IGtleSAqc2Vjb25kYXJ5X3RydXN0ZWRfa2V5czsKPiAgI2VuZGlmCj4g
KyNpZmRlZiBDT05GSUdfSU5URUdSSVRZX1BMQVRGT1JNX0tFWVJJTkcKPiArc3RydWN0IGtleSAq
cGxhdGZvcm1fdHJ1c3RlZF9rZXlzOwoKUGxlYXNlIG1ha2UgaXQgc3RhdGljLgoKTWltaQoKPiAr
I2VuZGlmCgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18K
a2V4ZWMgbWFpbGluZyBsaXN0CmtleGVjQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3Rz
LmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9rZXhlYwo=
