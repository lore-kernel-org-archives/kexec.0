Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghEWa-0002pD-CF
 for kexec@lists.infradead.org; Wed, 09 Jan 2019 14:08:07 +0000
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 x09E4O83045198
 for <kexec@lists.infradead.org>; Wed, 9 Jan 2019 09:07:58 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2pwj7u0r9f-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <kexec@lists.infradead.org>; Wed, 09 Jan 2019 09:07:57 -0500
Received: from localhost
 by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <zohar@linux.ibm.com>;
 Wed, 9 Jan 2019 14:07:55 -0000
Subject: Re: [RFC PATCH 1/1] KEYS, integrity: Link .platform keyring to
 .secondary_trusted_keys
From: Mimi Zohar <zohar@linux.ibm.com>
Date: Wed, 09 Jan 2019 09:07:36 -0500
In-Reply-To: <20190109013356.GA2610@dhcp-128-65.nay.redhat.com>
References: <20190108081247.2266-1-kasong@redhat.com>
 <20190108081247.2266-2-kasong@redhat.com>
 <1546960680.19931.114.camel@linux.ibm.com>
 <20190109013356.GA2610@dhcp-128-65.nay.redhat.com>
Mime-Version: 1.0
Message-Id: <1547042856.19931.229.camel@linux.ibm.com>
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
Cc: jwboyer@fedoraproject.org, Kairui Song <kasong@redhat.com>, ebiggers@google.com, nayna@linux.ibm.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, jmorris@namei.org, dhowells@redhat.com, linux-security-module <linux-security-module@vger.kernel.org>, keyrings@vger.kernel.org, linux-integrity <linux-integrity@vger.kernel.org>, dwmw2@infradead.org, bauerman@linux.ibm.com, serge@hallyn.com

T24gV2VkLCAyMDE5LTAxLTA5IGF0IDA5OjMzICswODAwLCBEYXZlIFlvdW5nIHdyb3RlOgo+IEND
IGtleGVjIGxpc3QKPiBPbiAwMS8wOC8xOSBhdCAxMDoxOGFtLCBNaW1pIFpvaGFyIHdyb3RlOgo+
ID4gW0NjJ2luZyB0aGUgTFNNIGFuZCBpbnRlZ3JpdHkgbWFpbGluZyBsaXN0c10KPiA+IAo+ID4g
UmVwZWF0aW5nIG15IGNvbW1lbnQgb24gUEFUQ0ggMC8xIGhlcmUgd2l0aCB0aGUgZXhwYW5kZWQg
c2V0IG9mCj4gPiBtYWlsaW5nIGxpc3RzLgo+ID4gCj4gPiBUaGUgYnVpbHRpbiBhbmQgc2Vjb25k
YXJ5IGtleXJpbmdzIGhhdmUgYSBzaWduYXR1cmUgY2hhbmdlIG9mIHRydXN0Cj4gPiByb290ZWQg
aW4gdGhlIHNpZ25lZCBrZXJuZWwgaW1hZ2UuwqDCoEFkZGluZyB0aGUgcHJlLWJvb3Qga2V5cyB0
byB0aGUKPiA+IHNlY29uZGFyeSBrZXlyaW5nIGJyZWFrcyB0aGF0IHNpZ25hdHVyZSBjaGFpbiBv
ZiB0cnVzdC4KPiA+IAo+ID4gUGxlYXNlIGRvIE5PVCBhZGQgdGhlIHByZS1ib290ICJwbGF0Zm9y
bSIga2V5cyB0byB0aGUgc2Vjb25kYXJ5Cj4gPiBrZXlyaW5nLgo+IAo+IElmIHdlIHJlZ2FyZCBr
ZXhlYyBhcyBhIGJvb3Rsb2FkZXIsIGl0IHNvdW5kcyBuYXR1cmFsIHRvIHVzZSB0aGUKPiBwbGF0
Zm9ybSBrZXkgdG8gdmVyaWZ5IHRoZSBzaWduYXR1cmUgd2l0aCBrZXhlY19maWxlX2xvYWQgc3lz
Y2FsbC4KPiAKPiBJdCB3aWxsIGJlIGhhcmQgZm9yIHVzZXIgdG8gbWFudWFsbHkgc2lnbiBhIGtl
cm5lbCBhbmQgaW1wb3J0IHRoZSBrZXkKPiB0aGVuIHRvIHJldXNlIGtleGVjX2ZpbGVfbG9hZC4K
ClRoaXMgaXMgcmVhbGx5IGEgZ2VuZXJpYyB0b3BpYywgbm90IGxpbWl0ZWQgdG8ga2V4ZWMsIHdo
aWNoIHNob3VsZCBiZQpkaXNjdXNzZWQuIMKgTGV0J3MgZGVmZXIgdGhpcyBkaXNjdXNzaW9uIGZv
ciBub3cuCgo+IAo+IEkgdGhpbmsgd2UgZG8gbm90IGNhcmUgaWYgcGxhdGZvcm0ga2V5IGNhbiBi
ZSBhZGRlZCB0byBzZWNvbmRhcnkgb3Igbm90LAo+IGFueSBzdWdnZXN0aW9ucyBob3cgY2FuIGtl
eGVjX2ZpbGUgdG8gdXNlIHRoZSBwbGF0Zm9ybSBrZXk/CgpJIGFzc3VtZSB0aGUgcHJvYmxlbSBp
cyBhY2Nlc3NpbmcgdGhlIGtleXJpbmcgaWQuCgpJbnN0ZWFkIG9mIGRlZmluaW5nIGEgZnVuY3Rp
b24gdG8gcmV0dXJuIHRoZSBrZXlyaW5nIGlkLCBhcyBiZWxvdywKZGVmaW5lIGEgZnVuY3Rpb24g
dGhhdCBzZXRzIGEgdmFyaWFibGUgd2l0aCB0aGUga2V5cmluZyBpZC4KwqBwbGF0Zm9ybV9rZXly
aW5nX2luaXQoKSB3b3VsZCBjYWxsIHRoYXQgZnVuY3Rpb24gdG8gc2V0IHRoZSB2YXJpYWJsZS4K
ClNpbWlsYXIgdG8gYnVpbHRpbl90cnVzdGVkX2tleXMgYW5kIHNlY29uZGFyeV90cnVzdGVkX2tl
eXMsIGRlZmluZSBhCnZhcmlhYmxlIG5hbWVkIHBsYXRmb3JtX3RydXN0ZWRfa2V5cy4KCltzbmlw
XQoKPiA+ID4gZGlmZiAtLWdpdCBhL3NlY3VyaXR5L2ludGVncml0eS9kaWdzaWcuYyBiL3NlY3Vy
aXR5L2ludGVncml0eS9kaWdzaWcuYwo+ID4gPiBpbmRleCBmNDVkNmVkZWNmOTkuLjM5Nzc1OGQ0
ZjEyZCAxMDA2NDQKPiA+ID4gLS0tIGEvc2VjdXJpdHkvaW50ZWdyaXR5L2RpZ3NpZy5jCj4gPiA+
ICsrKyBiL3NlY3VyaXR5L2ludGVncml0eS9kaWdzaWcuYwo+ID4gPiBAQCAtMTc2LDMgKzE3Niwx
MCBAQCBpbnQgX19pbml0IGludGVncml0eV9sb2FkX2NlcnQoY29uc3QgdW5zaWduZWQgaW50IGlk
LCBjb25zdCBjaGFyICpzb3VyY2UsCj4gPiA+ICAJcHJfaW5mbygiTG9hZGluZyBYLjUwOSBjZXJ0
aWZpY2F0ZTogJXNcbiIsIHNvdXJjZSk7Cj4gPiA+ICAJcmV0dXJuIGludGVncml0eV9hZGRfa2V5
KGlkLCBkYXRhLCBsZW4sIHBlcm0pOwo+ID4gPiAgfQo+ID4gPiArCj4gPiA+ICsjaWZkZWYgQ09O
RklHX0lOVEVHUklUWV9QTEFURk9STV9LRVlSSU5HCj4gPiA+ICtzdHJ1Y3Qga2V5KiBfX2luaXQg
aW50ZWdyaXR5X2dldF9wbGF0Zm9ybV9rZXlyaW5nKHZvaWQpCj4gPiA+ICt7Cj4gPiA+ICsJcmV0
dXJuIGtleXJpbmdbSU5URUdSSVRZX0tFWVJJTkdfUExBVEZPUk1dOwo+ID4gPiArfQo+ID4gPiAr
I2VuZGlmCgpNaW1pCgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18Ka2V4ZWMgbWFpbGluZyBsaXN0CmtleGVjQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDov
L2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9rZXhlYwo=
