Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by merlin.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gkIe6-0007YO-KO
 for kexec@lists.infradead.org; Fri, 18 Jan 2019 01:08:34 +0000
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 x0I188Xw128997
 for <kexec@lists.infradead.org>; Thu, 17 Jan 2019 20:08:26 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2q33yk9h5n-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <kexec@lists.infradead.org>; Thu, 17 Jan 2019 20:08:26 -0500
Received: from localhost
 by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <zohar@linux.ibm.com>;
 Fri, 18 Jan 2019 01:08:23 -0000
Subject: Re: [PATCH v3 0/2] let kexec_file_load use platform keyring to
 verify the kernel image
From: Mimi Zohar <zohar@linux.ibm.com>
Date: Thu, 17 Jan 2019 20:08:04 -0500
In-Reply-To: <20190116101654.7288-1-kasong@redhat.com>
References: <20190116101654.7288-1-kasong@redhat.com>
Mime-Version: 1.0
Message-Id: <1547773684.4026.10.camel@linux.ibm.com>
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
To: Kairui Song <kasong@redhat.com>, linux-kernel@vger.kernel.org, Dave Young <dyoung@redhat.com>
Cc: jwboyer@fedoraproject.org, ebiggers@google.com, dyoung@redhat.com, nayna@linux.ibm.com, kexec@lists.infradead.org, jmorris@namei.org, dhowells@redhat.com, keyrings@vger.kernel.org, linux-integrity@vger.kernel.org, dwmw2@infradead.org, bauerman@linux.ibm.com, serge@hallyn.com

T24gV2VkLCAyMDE5LTAxLTE2IGF0IDE4OjE2ICswODAwLCBLYWlydWkgU29uZyB3cm90ZToKPiBU
aGlzIHBhdGNoIHNlcmllcyBhZGRzIGEgLnBsYXRmb3JtX3RydXN0ZWRfa2V5cyBpbiBzeXN0ZW1f
a2V5cmluZyBhcyB0aGUKPiByZWZlcmVuY2UgdG8gLnBsYXRmb3JtIGtleXJpbmcgaW4gaW50ZWdy
aXR5IHN1YnN5c3RlbSwgd2hlbiBwbGF0Zm9ybQo+IGtleXJpbmcgaXMgYmVpbmcgaW5pdGlhbGl6
ZWQgaXQgd2lsbCBiZSB1cGRhdGVkLiBTbyBvdGhlciBjb21wb25lbnQgY291bGQKPiB1c2UgdGhp
cyBrZXlyaW5nIGFzIHdlbGwuCgpSZW1vdmUgIm90aGVyIGNvbXBvbmVudCBjb3VsZCB1c2UgLi4u
Ii4KPiAKPiBUaGlzIHBhdGNoIHNlcmllcyBhbHNvIGxldCBrZXhlY19maWxlX2xvYWQgdXNlIHBs
YXRmb3JtIGtleXJpbmcgYXMgZmFsbAo+IGJhY2sgaWYgaXQgZmFpbGVkIHRvIHZlcmlmeSB0aGUg
aW1hZ2UgYWdhaW5zdCBzZWNvbmRhcnkga2V5cmluZywgbWFrZSBpdAo+IHBvc3NpYmxlIHRvIGxv
YWQga2VybmVsIHNpZ25lZCBieSB0aGlyZCBwYXJ0IGtleSBpZiB0aGlyZCBwYXJ0eSBrZXkgaXMK
PiBpbXBvcnRlZCBpbiB0aGUgZmlybXdhcmUuCgpUaGlzIGlzIHRoZSBvbmx5IHJlYXNvbiBmb3Ig
dGhlc2UgcGF0Y2hlcy4gwqBQbGVhc2UgcmVtb3ZlICJhbHNvIi4KCj4gCj4gQWZ0ZXIgdGhpcyBw
YXRjaCBrZXhlY19maWxlX2xvYWQgd2lsbCBiZSBhYmxlIHRvIHZlcmlmeSBhIHNpZ25lZCBQRQo+
IGJ6SW1hZ2UgdXNpbmcga2V5cyBpbiBwbGF0Zm9ybSBrZXlyaW5nLgo+IAo+IFRlc3RlZCBpbiBh
IFZNIHdpdGggbG9jYWxseSBzaWduZWQga2VybmVsIHdpdGggcGVzaWduIGFuZCBpbXBvcnRlZCB0
aGUKPiBjZXJ0IHRvIEVGSSdzIE1va0xpc3QgdmFyaWFibGUuCgpJdCdzIHRha2VuIHNvIGxvbmcg
Zm9yIG1lIHRvIHJldmlldy90ZXN0IHRoaXMgcGF0Y2ggc2V0IGR1ZSB0byBhCnJlZ3Jlc3Npb24g
aW4gc2FuaXR5X2NoZWNrX3NlZ21lbnRfbGlzdCgpLCBpbnRyb2R1Y2VkIHNvbWV3aGVyZQpiZXR3
ZWVuIDQuMjAgYW5kIDUuMC4wLXJjMS4gwqBUaGUgc2dlbWVudCBvdmVybGFwIHRlc3QgLSAiaWYg
KChtZW5kID4KcHN0YXJ0KSAmJiAobXN0YXJ0IDwgcGVuZCkpIiAtIGZhaWxzLCByZXR1cm5pbmcg
YSAtRUlOVkFMLgoKSXMgYW55b25lIGVsc2Ugc2VlaW5nIHRoaXM/CgpNaW1pCgoKPiAKPiBLYWly
dWkgU29uZyAoMik6Cj4gICBpbnRlZ3JpdHksIEtFWVM6IGFkZCBhIHJlZmVyZW5jZSB0byBwbGF0
Zm9ybSBrZXlyaW5nCj4gICBrZXhlYywgS0VZUzogTWFrZSB1c2Ugb2YgcGxhdGZvcm0ga2V5cmlu
ZyBmb3Igc2lnbmF0dXJlIHZlcmlmeQo+IAo+IFVwZGF0ZSBmcm9tIFYyOgo+ICAgLSBVc2UgSVNf
RU5BQkxFRCBpbiBrZXhlY19maWxlX2xvYWQgdG8ganVkZ2UgaWYgcGxhdGZvcm1fdHJ1c3RlZF9r
ZXlzCj4gICAgIHNob3VsZCBiZSB1c2VkIGZvciB2ZXJpZnlpbmcgaW1hZ2UgYXMgc3VnZ2VzdGVk
IGJ5IE1pbWkgWm9oYXIKPiAKPiBVcGRhdGUgZnJvbSBWMToKPiAgIC0gTWFrZSBwbGF0Zm9ybV90
cnVzdGVkX2tleXMgc3RhdGljLCBhbmQgdXBkYXRlIGNvbW1pdCBtZXNzYWdlIGFzIHN1Z2dlc3Rl
ZAo+ICAgICBieSBNaW1pIFpvaGFyCj4gICAtIEFsd2F5cyBjaGVjayBpZiBwbGF0Zm9ybSBrZXly
aW5nIGlzIGluaXRpYWxpemVkIGJlZm9yZSB1c2UgaXQKPiAKPiBLYWlydWkgU29uZyAoMik6Cj4g
ICBpbnRlZ3JpdHksIEtFWVM6IGFkZCBhIHJlZmVyZW5jZSB0byBwbGF0Zm9ybSBrZXlyaW5nCj4g
ICBrZXhlYywgS0VZUzogTWFrZSB1c2Ugb2YgcGxhdGZvcm0ga2V5cmluZyBmb3Igc2lnbmF0dXJl
IHZlcmlmeQo+IAo+ICBhcmNoL3g4Ni9rZXJuZWwva2V4ZWMtYnppbWFnZTY0LmMgfCAxMyArKysr
KysrKysrLS0tCj4gIGNlcnRzL3N5c3RlbV9rZXlyaW5nLmMgICAgICAgICAgICB8IDIyICsrKysr
KysrKysrKysrKysrKysrKy0KPiAgaW5jbHVkZS9rZXlzL3N5c3RlbV9rZXlyaW5nLmggICAgIHwg
IDUgKysrKysKPiAgaW5jbHVkZS9saW51eC92ZXJpZmljYXRpb24uaCAgICAgIHwgIDEgKwo+ICBz
ZWN1cml0eS9pbnRlZ3JpdHkvZGlnc2lnLmMgICAgICAgfCAgNiArKysrKysKPiAgNSBmaWxlcyBj
aGFuZ2VkLCA0MyBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygtKQo+IAoKCl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmtleGVjIG1haWxpbmcgbGlzdApr
ZXhlY0BsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxt
YW4vbGlzdGluZm8va2V4ZWMK
