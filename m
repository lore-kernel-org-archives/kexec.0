Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1fELpA-0007OE-RC
 for kexec@lists.infradead.org; Thu, 03 May 2018 21:31:38 +0000
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w43LRw2R001597
 for <kexec@lists.infradead.org>; Thu, 3 May 2018 17:31:25 -0400
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2hr67dsw1e-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <kexec@lists.infradead.org>; Thu, 03 May 2018 17:31:24 -0400
Received: from localhost
 by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <zohar@linux.vnet.ibm.com>;
 Thu, 3 May 2018 22:31:22 +0100
Subject: Re: [PATCH 0/3] kexec: limit kexec_load syscall
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
Date: Thu, 03 May 2018 17:31:15 -0400
In-Reply-To: <87r2mso5up.fsf@xmission.com>
References: <1523572911-16363-1-git-send-email-zohar@linux.vnet.ibm.com>
 <87r2mso5up.fsf@xmission.com>
Mime-Version: 1.0
Message-Id: <1525383075.3539.67.camel@linux.vnet.ibm.com>
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
To: "Eric W. Biederman" <ebiederm@xmission.com>, Kees Cook <keescook@chromium.org>
Cc: kernel-hardening@lists.openwall.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Matthew Garrett <mjg59@google.com>, David Howells <dhowells@redhat.com>, linux-security-module@vger.kernel.org, linux-integrity@vger.kernel.org

W0NjJ2luZyBLZWVzIGFuZCBrZXJuZWwtaGFyZGVuaW5nXQoKT24gVGh1LCAyMDE4LTA1LTAzIGF0
IDE1OjEzIC0wNTAwLCBFcmljIFcuIEJpZWRlcm1hbiB3cm90ZToKPiBNaW1pIFpvaGFyIDx6b2hh
ckBsaW51eC52bmV0LmlibS5jb20+IHdyaXRlczoKPiAKPiA+IEluIGVudmlyb25tZW50cyB0aGF0
IHJlcXVpcmUgdGhlIGtleGVjIGtlcm5lbCBpbWFnZSB0byBiZSBzaWduZWQsIHByZXZlbnQKPiA+
IHVzaW5nIHRoZSBrZXhlY19sb2FkIHN5c2NhbGwuICBJbiBvcmRlciBmb3IgTFNNcyBhbmQgSU1B
IHRvIGRpZmZlcmVudGlhdGUKPiA+IGJldHdlZW4ga2V4ZWNfbG9hZCBhbmQga2V4ZWNfZmlsZV9s
b2FkIHN5c2NhbGxzLCB0aGlzIHBhdGNoIHNldCBhZGRzIGEKPiA+IGNhbGwgdG8gc2VjdXJpdHlf
a2VybmVsX3JlYWRfZmlsZSgpIGluIGtleGVjX2xvYWRfY2hlY2soKS4KPiAKPiBIYXZpbmcgdGhv
dWdodCBhYm91dCBpdCBzb21lIG1vcmUgdGhpcyBqdXN0aWZpY2F0aW9uIGZvciB0aGVzZSBjaGFu
Z2VzCj4gZG9lcyBub3Qgd29yay4gIFRoZSBmdW5jdGlvbmFsaXR5IG9mIGtleGVjX2xvYWQgaXMg
YWxyZWFkeSByb290LW9ubHkuCj4gU28gaW4gZW52aXJvbm1lbnRzIHRoYXQgcmVxdWlyZSB0aGUg
a2VybmVsIGltYWdlIHRvIGJlIHNpZ25lZCBqdXN0IGRvbid0Cj4gdXNlIGtleGVjX2xvYWQuICBQ
b3NzaWJseSBldmVuIGNvbXBpbGUga2V4ZWNfbG9hZCBvdXQgdG8gc2F2ZSBzcGFjZQo+IGJlY2F1
c2UgeW91IHdpbGwgbmV2ZXIgbmVlZCBpdC4gIFlvdSBkb24ndCBuZWVkIGEgbmV3IHNlY3VyaXR5
IGhvb2sgdG8KPiBkbyBhbnkgb2YgdGhhdC4gIFVzZXJzcGFjZSBpcyBhIHZlcnkgZmluZSBtZWNo
YW5pc20gZm9yIGJlaW5nIHRoZQo+IGluc3RydW1lbnQgb2YgcG9saWN5LgoKVHJ1ZSwgZm9yIHRo
b3NlIGJ1aWxkaW5nIHRoZWlyIG93biBrZXJuZWwsIHRoZXkgY2FuIGRpc2FibGUgdGhlIG9sZApz
eXNjYWxscy4gwqBUaGUgY29uY2VybiBpcyBub3QgZm9yIHRob3NlIGJ1aWxkaW5nIHRoZWlyIG93
biBrZXJuZWxzLApidXQgZm9yIHRob3NlIHVzaW5nIHN0b2NrIGtlcm5lbHMuIMKgCgpCeSBhZGRp
bmcgYW4gTFNNIGhvb2sgaGVyZSBpbiB0aGUga2V4ZWNfbG9hZCBzeXNjYWxsLCBhcyBvcHBvc2Vk
IHRvIGFuCklNQSBzcGVjaWZpYyBob29rLCBvdGhlciBMU01zIGNhbiBwaWdneSBiYWNrIG9uIHRv
cCBvZiBpdC4gwqBDdXJyZW50bHksCmJvdGggbG9hZF9waW4gYW5kIFNFTGludXggYXJlIGdhdGlu
ZyB0aGUga2VybmVsIG1vZHVsZSBzeXNjYWxscyBiYXNlZApvbiBzZWN1cml0eV9rZXJuZWxfcmVh
ZF9maWxlLgoKSWYgdGhlcmUgd2FzIGEgc2ltaWxhciBvcHRpb24gZm9yIHRoZSBrZXJuZWwgaW1h
Z2UsIEknbSBwcmV0dHkgc3VyZQpvdGhlciBMU01zIHdvdWxkIHVzZSBpdC4KCkZyb20gYW4gSU1B
IHBlcnNwZWN0aXZlLCB0aGVyZSBuZWVkcyB0byBiZSBzb21lIG1ldGhvZCBmb3Igb25seQphbGxv
d2luZyBzaWduZWQgY29kZSB0byBiZSBsb2FkZWQsIGV4ZWN1dGVkLCBldGMuIC0ga2VybmVsIG1v
ZHVsZXMsCmtlcm5lbCBpbWFnZS9pbml0cmFtZnMsIGZpcm13YXJlLCBwb2xpY2llcy4KCj4gSWYg
eW91IGRvbid0IHRydXN0IHVzZXJzcGFjZSB0aGF0IG5lZWRzIHRvIGJlIHNwZWxsZWQgb3V0IHZl
cnkgY2xlYXJseS4KPiBZb3UgbmVlZCB0byB0YWxrIGFib3V0IHdoYXQgeW91ciB0aHJlYXQgbW9k
ZWxzIGFyZS4KPiAKPiBJZiB0aGUgb25seSBqdXN0aWZpY2F0aW9uIGlzIHNvIHRoYXQgdGhhdCB3
ZSBjYW4ndCBib290IHdpbmRvd3MgaWYKPiBzb21lb25lIGhhY2tzIGludG8gdXNlcnNwYWNlIGl0
IGhhcyBteSBuYWNrIGJlY2F1c2UgdGhhdCBpcyBhbm90aGVyIGtpbmQKPiBvZiBjb21wbGV0ZSBu
b24tc2Vuc2UuCgpUaGUgdXNlY2FzZSBpcyB0aGUgYWJpbGl0eSB0byBnYXRlIHRoZSBrZXhlY19s
b2FkIHVzYWdlIGluIHN0b2NrCmtlcm5lbHMuCgo+IAo+IEdpdmVuIHRoYXQgeW91IGFyZSBub3Qg
dHJ1c3RpbmcgdXNlcnNwYWNlIHRoaXMgY2hhbmdlc2V0IGFsc28gcHJvYmFibHkKPiBuZWVkcyB0
byBoYXZlIHRoZSBrZXJuZWwtaGFyZGVuaW5nIGxpc3QgY2MnZC4gIEJlY2F1c2UgdGhlIG9ubHkg
cG9zc2libGUKPiBqdXN0aWZpY2F0aW9uIEkgY2FuIGltYWdpbmUgZm9yIHNvbWV0aGluZyBsaWtl
IHRoaXMgaXMga2VybmVsLWhhcmRlbmluZy4KClN1cmUsIENjJ2luZyBsaW51eC1oYXJkZW5pbmcg
YW5kIEtlZXMuCgpNaW1pCgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18Ka2V4ZWMgbWFpbGluZyBsaXN0CmtleGVjQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0
cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9rZXhlYwo=
