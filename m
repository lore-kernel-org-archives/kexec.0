Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1h3kcq-000114-IG
 for kexec@lists.infradead.org; Tue, 12 Mar 2019 16:51:38 +0000
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x2CGbC38069108
 for <kexec@lists.infradead.org>; Tue, 12 Mar 2019 12:51:33 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2r6f3m6akk-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <kexec@lists.infradead.org>; Tue, 12 Mar 2019 12:51:33 -0400
Received: from localhost
 by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <zohar@linux.ibm.com>;
 Tue, 12 Mar 2019 16:51:31 -0000
Subject: Re: [PATCH v3 5/7] selftests/ima: kexec_file_load syscall test
From: Mimi Zohar <zohar@linux.ibm.com>
Date: Tue, 12 Mar 2019 12:51:14 -0400
In-Reply-To: <20190312121001.GA18510@dhcp-128-65.nay.redhat.com>
References: <1552304473-3966-1-git-send-email-zohar@linux.ibm.com>
 <1552304473-3966-6-git-send-email-zohar@linux.ibm.com>
 <20190312121001.GA18510@dhcp-128-65.nay.redhat.com>
Mime-Version: 1.0
Message-Id: <1552409474.24794.63.camel@linux.ibm.com>
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

T24gVHVlLCAyMDE5LTAzLTEyIGF0IDIwOjEwICswODAwLCBEYXZlIFlvdW5nIHdyb3RlOgo+IEhp
IE1pbWksCj4gT24gMDMvMTEvMTkgYXQgMDc6NDFhbSwgTWltaSBab2hhciB3cm90ZToKPiA+IFRo
ZSBrZXJuZWwgY2FuIGJlIGNvbmZpZ3VyZWQgdG8gdmVyaWZ5IFBFIHNpZ25lZCBrZXJuZWwgaW1h
Z2VzLCBJTUEKPiA+IGtlcm5lbCBpbWFnZSBzaWduYXR1cmVzLCBib3RoIHR5cGVzIG9mIHNpZ25h
dHVyZXMsIG9yIG5vbmUuICBUaGlzIHRlc3QKPiA+IHZlcmlmaWVzIG9ubHkgcHJvcGVybHkgc2ln
bmVkIGtlcm5lbCBpbWFnZXMgYXJlIGxvYWRlZCBpbnRvIG1lbW9yeSwKPiA+IGJhc2VkIG9uIHRo
ZSBrZXJuZWwgY29uZmlndXJhdGlvbiBhbmQgcnVudGltZSBwb2xpY2llcy4KPiAKPiBJIHVuZGVy
c3RhbmQgdGhpcyBpcyBmb3IgSU1BIHRlc3Rpbmcgb25seSwgYnV0IEkgc3RpbGwgd29uZGVyIGlm
IHRoaXMKPiBjYW4gYmUgZXhwYW5kZWQgdG8gY29tbW9uIGtleGVjIHRlc3RzLCBsaWtlCj4gdG9v
bHMvdGVzdGluZy9zZWxmdGVzdHMva2V4ZWMva2V4ZWNfbG9hZC5zaAo+IHRvb2xzL3Rlc3Rpbmcv
c2VsZnRlc3RzL2tleGVjL2tleGVjX2ZpbGVfbG9hZC5zaAo+IAo+IElzIGl0IHBvc3NpYmxlIGZv
ciBpbWEvdGVzdF9rZXhlY19sb2FkLnNoIHRvIGNhbGwgdGhlCj4gLi4va2V4ZWMva2V4ZWNfbG9h
ZC5zaCwgcHJvYmFibHkgYWRkIGV4dHJhIGFyZ3VtZW50IGVnICJpbWEiPwoKVGhlc2Uga2V4ZWMg
dGVzdHMgYXJlIG1lYW50IHRvIGNvb3JkaW5hdGUgYmV0d2VlbiB0aGUgZGlmZmVyZW50Cm1ldGhv
ZHMgb2YgdmVyaWZ5aW5nIHRoZSBrZXhlYyBrZXJuZWwgaW1hZ2Ugc2lnbmF0dXJlcy4gwqBOb3Ro
aW5nIGFib3V0CnRoZW0gaXMgSU1BIHNwZWNpZmljLiDCoE1vdmluZyB0aGVzZSB0ZXN0cyB0bwp0
b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9rZXhlYyBtYWtlcyBzZW5zZS4KCj4gCj4gRnJhbmtseSBJ
IGRpZCBub3QgcmVhZCBhbmQgZm9sbG93dXAgbXVjaCBhYm91dCB0aGUgdGVzdGluZyBjb2RlIGNo
YW5nZXMsCj4gbm90IHN1cmUgaWYgaXQgaXMgZG9hYmxlIG9yIG5vdC4gIFRoZSBjb2RlIHNoYXJp
bmcgdW5kZXIgdGVzdGluZyBmb2xkZXIKPiBzZWVtcyBub3QgdmVyeSBnb29kLiAgRm9yIGV4YW1w
bGUgdGhlIGJhc2ljIGNoZWNrX3Jvb3QgaXMgbmVlZGVkIGJ5Cj4gZGlmZmVyZW50IHBhcnRzLCBi
dXQgYWxsIGhhdmUgaXRzIG93biBpbXBsZW1lbnRhdGlvbi4gIEFueXdheSB0aGlzIGlzCj4gbm90
IHRoZSBkdXR5IG9mIHRoaXMgcGF0Y2ggc2V0Lgo+IEFsc28gdGhlIHNlbGZ0ZXN0cy9saWIvIGlz
IG5vdCBhIGZvbGRlciBmb3Igc2hhcmluZyBjb2RlIGZvciBkaWZmZXJlbnQKPiB0ZXN0cywgaXQg
bG9va3MgYSBzdGFuZGFsb25lIHRlc3QgaW5zdGVhZC4KClNodWFoIHN1Z2dlc3RlZCB1cHN0cmVh
bWluZyB0aGVzZSB0ZXN0cyBmaXJzdCBhbmQgZGVmZXIgaW50cm9kdWNpbmcgYQpjb21tb24gc2V0
IG9mIGZ1bmN0aW9ucyB0byBsYXRlci4KCj4gU28gaWYgc3BsaXQga2V4ZWMgdGVzdHMgdG8gYW5v
dGhlciBmb2xkZXIgaXMgbm90IGRvYWJsZSBwbGVhc2UganVzdAo+IGlnbm9yZSB0aGUgY29tbWVu
dC4KCkxlZnQgaW4gdGhlIHNlbGZ0ZXN0cy9pbWEgaXMgYSBzaW1pbGFyIHRlc3QgZm9yIGtlcm5l
bCBtb2R1bGVzLCB3aGljaAp1c2VzIHRoZSAiY29tbW9uIiBmdW5jdGlvbnMuIMKgU28gZWl0aGVy
IHdlIHdhaXQgdG8gbW92ZSB0aGUga2V4ZWMKdGVzdHMgb3IgYWxsb3cgdGhlbSB0byByZWFjaCBp
bnRvIHRoZSBpbWEgZGlyZWN0b3J5IGFuZCB1c2UgdGhlCmltYV9jb21tb25fbGliIGZ1bmN0aW9u
cy4KCj4gCj4gQlRXLCBkb2VzIENPTkZJR19LRVhFQyogaXMgY2hlY2tlZD8gIGluIGNhc2UgYSBr
ZXJuZWwgd2l0aG91dCBLRVhFQyBvcgo+IEtFWEVDX0ZJTEUgY29tcGlsZWQgaW4gdGhlbiB0aGUg
dGVzdHMgY2FuIGp1c3QgcmV0dXJuIGRpcmVjdGx5LgoKR29vZCBwb2ludC4gwqBOb3cgdGhhdCB0
aGVyZSBpcyBhIGNvbW1vbiBmdW5jdGlvbiBmb3IgcmVhZGluZyB0aGUKS2NvbmZpZywgSSdsbCBh
ZGQgdGhhdCBjaGVjayB0byBib3RoIHRoZSB0ZXN0X2tleGVjX2xvYWQuc2ggYW5kCnRlc3Rfa2V4
ZWNfZmlsZV9sb2FkLnNoIHRlc3RzIHJlc3BlY3RpdmVseS4KCk1pbWkKCgpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwprZXhlYyBtYWlsaW5nIGxpc3QKa2V4
ZWNAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFu
L2xpc3RpbmZvL2tleGVjCg==
