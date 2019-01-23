Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]
 helo=mx0a-001b2d01.pphosted.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmNNt-0007rC-Nf
 for kexec@lists.infradead.org; Wed, 23 Jan 2019 18:36:24 +0000
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x0NIYNuQ100334
 for <kexec@lists.infradead.org>; Wed, 23 Jan 2019 13:36:19 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2q6vxjsvck-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <kexec@lists.infradead.org>; Wed, 23 Jan 2019 13:36:19 -0500
Received: from localhost
 by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <zohar@linux.ibm.com>;
 Wed, 23 Jan 2019 18:36:17 -0000
Subject: Re: [PATCH v5 0/2] let kexec_file_load use platform keyring to
 verify the kernel image
From: Mimi Zohar <zohar@linux.ibm.com>
Date: Wed, 23 Jan 2019 13:36:00 -0500
In-Reply-To: <20190121095929.26915-1-kasong@redhat.com>
References: <20190121095929.26915-1-kasong@redhat.com>
Mime-Version: 1.0
Message-Id: <1548268560.3971.2.camel@linux.ibm.com>
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

T24gTW9uLCAyMDE5LTAxLTIxIGF0IDE3OjU5ICswODAwLCBLYWlydWkgU29uZyB3cm90ZToKPiBU
aGlzIHBhdGNoIHNlcmllcyBhZGRzIGEgLnBsYXRmb3JtX3RydXN0ZWRfa2V5cyBpbiBzeXN0ZW1f
a2V5cmluZyBhcyB0aGUKPiByZWZlcmVuY2UgdG8gLnBsYXRmb3JtIGtleXJpbmcgaW4gaW50ZWdy
aXR5IHN1YnN5c3RlbSwgd2hlbiBwbGF0Zm9ybQo+IGtleXJpbmcgaXMgYmVpbmcgaW5pdGlhbGl6
ZWQgaXQgd2lsbCBiZSB1cGRhdGVkLCBzbyBpdCB3aWxsIGJlCj4gYWNjZXNzYWJsZSBmb3IgdmVy
aWZ5aW5nIFBFIHNpZ25lZCBrZXJuZWwgaW1hZ2UuCgpUaGVyZSB3ZXJlIHNvbWXCoHNjcmlwdHMv
Y2hlY2twYXRjaC5wbCBlcnJvcnMvd2FybmluZ3MgZW1pdHRlZCBvbiB0aGVzZQpwYXRjaGVzLiDC
oEkndmUgZml4ZWQgdGhlbSwgYnV0IGluIHRoZSBmdXR1cmUgcGxlYXNlIGZvbGxvdyB0aGUKZ3Vp
ZGVsaW5lcyBpbiBEb2N1bWVudGF0aW9uL3Byb2Nlc3Mvc3VibWl0dGluZy1wYXRjaGVzLnJzdC4K
ClRoZXNlIHBhdGNoZXMgYXJlIG5vdyBxdWV1ZWQgaW4gdGhlIG5leHQtaW50ZWdyaXR5IGJyYW5j
aCBvZgpodHRwczovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dpdC96b2hh
ci9saW51eC1pbnRlZ3JpdHkuZ2l0CgpNaW1pCgoKX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18Ka2V4ZWMgbWFpbGluZyBsaXN0CmtleGVjQGxpc3RzLmluZnJh
ZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9rZXhl
Ywo=
