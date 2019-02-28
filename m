Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gzNG9-0002PZ-I5
 for kexec@lists.infradead.org; Thu, 28 Feb 2019 15:06:11 +0000
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x1SExeRt140497
 for <kexec@lists.infradead.org>; Thu, 28 Feb 2019 10:06:02 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2qxfs4xyx7-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <kexec@lists.infradead.org>; Thu, 28 Feb 2019 10:06:01 -0500
Received: from localhost
 by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <zohar@linux.ibm.com>;
 Thu, 28 Feb 2019 15:05:59 -0000
Subject: Re: [PATCH 2/3] scripts/ima: define a set of common functions
From: Mimi Zohar <zohar@linux.ibm.com>
Date: Thu, 28 Feb 2019 10:05:43 -0500
In-Reply-To: <20190228134146.GA7528@dhcp-128-65.nay.redhat.com>
References: <1548960936-7800-1-git-send-email-zohar@linux.ibm.com>
 <1548960936-7800-3-git-send-email-zohar@linux.ibm.com>
 <20190228134146.GA7528@dhcp-128-65.nay.redhat.com>
Mime-Version: 1.0
Message-Id: <1551366343.10911.173.camel@linux.ibm.com>
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
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org, David Howells <dhowells@redhat.com>, linux-security-module@vger.kernel.org, Eric Biederman <ebiederm@xmission.com>, linux-integrity@vger.kernel.org

SGkgRGF2ZSwKCk9uIFRodSwgMjAxOS0wMi0yOCBhdCAyMTo0MSArMDgwMCwgRGF2ZSBZb3VuZyB3
cm90ZToKPiBIaSBNaW1pLAo+ICAKPiBTb3JyeSBmb3IganVtcGluZyBpbiBsYXRlLCBqdXN0IG5v
dGljZWQgdGhpcyBrZXhlYyBzZWxmdGVzdHMsIEkgdGhpbmsgd2UKPiBhbHNvIG5lZWQgYSBrZXhl
YyBsb2FkIHRlc3Qgbm90IG9ubHkgZm9yIGltYSwgYnV0IGZvciBnZW5lcmFsIGtleGVjCgpUaGUg
SU1BIGtzZWxmdGVzdCB0ZXN0cyBhcmUgZm9yIHRoZSBjb29yZGluYXRpb24gYmV0d2VlbiB0aGUg
ZGlmZmVyZW50Cm1ldGhvZHMgb2YgdmVyaWZ5aW5nIGZpbGUgc2lnbmF0dXJlcy4gwqBJbiBwYXJ0
aWN1bGFyLCBmb3IgdGhlIGtleGVjCmtlcm5lbCBpbWFnZSBhbmQga2VybmVsIG1vZHVsZSBzaWdu
YXR1cmVzLgoKVGhlIGluaXRpYWwgSU1BIGtzZWxmdGVzdCBqdXN0IHZlcmlmaWVzIHRoYXQgaW4g
YW4gZW52aXJvbm1lbnQKcmVxdWlyaW5nIHNpZ25lZCBrZXhlYyBrZXJuZWwgaW1hZ2VzLCB0aGUg
a2V4ZWNfbG9hZCBzeXNjYWxsIGZhaWxzLsKgCgpUaGlzIHdlZWsgSSBwb3N0ZWQgYWRkaXRpb25h
bCBJTUEga3NlbGZ0ZXN0c1sxXVsyXSwgaW5jbHVkaW5nIG9uZSBmb3IKdGhlIGtleGVjX2ZpbGVf
bG9hZCBzeXNjYWxsLiDCoEkgd291bGQgcmVhbGx5IGFwcHJlY2lhdGUgdGhlc2UKa3NlbGZ0ZXN0
cyBiZWluZyByZXZpZXdlZC9hY2tlZC4KCk1pbWkKClsxXSBTdWJqZWN0OiBbUEFUQ0ggdjIgMC81
XSBzZWxmdGVzdHMvaW1hOiBhZGQga2V4ZWMgYW5kIGtlcm5lbCBtb2R1bGUgdGVzdHMKWzJdIFBh
dGNoZXMgYXZhaWxhYmxlIGZyb20gdGhlICJuZXh0LXF1ZXVlZC10ZXN0aW5nIiBicmFuY2gKaHR0
cHM6Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9naXQvem9oYXIvbGludXgt
aW50ZWdyaXR5LmdpdC8KCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwprZXhlYyBtYWlsaW5nIGxpc3QKa2V4ZWNAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRw
Oi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2tleGVjCg==
