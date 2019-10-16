Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]
 helo=mx0a-001b2d01.pphosted.com)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iKYMZ-0000dI-FC
 for kexec@lists.infradead.org; Wed, 16 Oct 2019 01:44:33 +0000
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x9G1fhB2101689
 for <kexec@lists.infradead.org>; Tue, 15 Oct 2019 21:44:28 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2vnnwmws6t-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <kexec@lists.infradead.org>; Tue, 15 Oct 2019 21:44:28 -0400
Received: from localhost
 by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <zohar@linux.ibm.com>;
 Wed, 16 Oct 2019 02:44:26 +0100
Subject: Re: [PATCH V4 0/2] Add support for arm64 to carry ima measurement
From: Mimi Zohar <zohar@linux.ibm.com>
Date: Tue, 15 Oct 2019 21:44:16 -0400
In-Reply-To: <0053eb68-0905-4679-c97a-00c5cb6f1abb@arm.com>
References: <20191011003600.22090-1-prsriva@linux.microsoft.com>
 <87d92514-e5e4-a79f-467f-f24a4ed279b6@arm.com>
 <b35b239c-990c-0d5b-0298-8f9e35064e2b@linux.microsoft.com>
 <0053eb68-0905-4679-c97a-00c5cb6f1abb@arm.com>
Mime-Version: 1.0
Message-Id: <1571190256.5250.200.camel@linux.ibm.com>
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
To: James Morse <james.morse@arm.com>, prsriva <prsriva@linux.microsoft.com>, Thiago Jung Bauermann <bauerman@linux.ibm.com>
Cc: mark.rutland@arm.com, jean-philippe@linaro.org, arnd@arndb.de, yamada.masahiro@socionext.com, sboyd@kernel.org, catalin.marinas@arm.com, ard.biesheuvel@linaro.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, takahiro.akashi@linaro.org, duwe@lst.de, bauerman@linux.ibm.com, allison@lohutok.net, linux-integrity@vger.kernel.org, tglx@linutronix.de, linux-arm-kernel@lists.infradead.org

SGkgSmFtZXMsCgpPbiBUdWUsIDIwMTktMTAtMTUgYXQgMTg6MzkgKzAxMDAsIEphbWVzIE1vcnNl
IHdyb3RlOgo+IElmIFNlY3VyZUJvb3QgaXNuJ3QgcmVsZXZhbnQsIEknbSBjb25mdXNlZCBhcyB0
byB3aHkga2V4ZWNfZmlsZV9sb2FkKCkgaXMuCj4gCj4gSSB0aG91Z2h0IGtleGVjX2ZpbGVfbG9h
ZCgpIG9ubHkgZXhpc3RlZCBiZWNhdXNlIFNlY3VyZUJvb3Qgc3lzdGVtcyBuZWVkIHRvIHZhbGlk
YXRlIHRoZQo+IG5ldyBPUyBpbWFnZXMncyBzaWduYXR1cmUgYmVmb3JlIGxvYWRpbmcgaXQsIGFu
ZCB3ZSBjYW4ndCB0cnVzdCB1c2VyLXNwYWNlIGNhbGxpbmcgS2V4ZWMKPiB0byBkbyB0aGlzLgo+
IAo+IElmIHRoZXJlIGlzIG5vIHNlY3VyZSBib290LCB3aHkgZG9lcyB0aGlzIHRoaW5nIG9ubHkg
d29yayB3aXRoIGtleGVjX2ZpbGVfbG9hZCgpPwo+IChnb29kIG5ld3MhIFdpdGggdGhlIFVFRkkg
bWVtcmVzZXZlIHRhYmxlLCBpdCBzaG91bGQgd29yayB0cmFuc3BhcmVudGx5IHdpdGggcmVndWxh
ciBrZXhlYwo+IHRvbykKCkknbSBzbyBzb3JyeSBmb3IgdGhlIGNvbmZ1c2lvbi4gwqBJTUEgd2Fz
IG9yaWdpbmFsbHkgbGltaXRlZCB0bwpleHRlbmRpbmcgdHJ1c3RlZCBib290IGNvbmNlcHRzIHRv
IHRoZSBPUy4gwqBBcyBvZiBMaW51eCAzLjEwLCBJTUEKYWRkZWQgc3VwcG9ydCBmb3IgZXh0ZW5k
aW5nIHNlY3VyZSBib290IGNvbmNlcHRzIGFuZCBhdWRpdGluZyBmaWxlCmhhc2hlcyAoY29tbWl0
IGU3YzU2OGUwZmQwY2YpLgoKVHJ1ZSwga2V4ZWNfZmlsZV9sb2FkIGlzIHJlcXVpcmVkIGZvciB2
ZXJpZnlpbmcgdGhlIGtleGVjIGtlcm5lbAppbWFnZSwgYnV0IGl0IGlzIGFsc28gcmVxdWlyZWQg
Zm9yIG1lYXN1cmluZyB0aGUga2V4ZWMga2VybmVsIGltYWdlIGFzCndlbGwuCgpBZnRlciByZWFk
aW5nIHRoZSBrZXJuZWwgaW1hZ2UgaW50byBtZW1vcnkgKGtlcm5lbF9yZWFkX2ZpbGVfZnJvbV9m
ZCksCnRoZSBoYXNoIGlzIGNhbGN1bGF0ZWQgYW5kIHRoZW4gYWRkZWQgdG8gdGhlIElNQSBtZWFz
dXJlbWVudCBsaXN0IGFuZAp1c2VkIHRvIGV4dGVuZCB0aGUgVFBNLiDCoEFsbCBvZiB0aGlzIGlz
IGJhc2VkIG9uIHRoZSBJTUEgcG9saWN5LAppbmNsdWRpbmcgdGhlIFRQTSBQQ1IuCgo+IAo+ID4g
SSBhbSBub3Qgc3VyZSBpZiBpIGFkZHJlc3NlZCBhbGwgeW91ciBjb25jZXJucywgcGxlYXNlIGxl
dCBtZSBrbm93Cj4gPiBpZiBpIG1pc3NlZCBhbnl0aGluZy4gVG8gbWUgbW9zdCBjb25jZXJucyBs
b29rIHRvIGJlIHRvd2FyZHMgdGhlIGtleGVjIGNhc2UgYW5kIGRlcGVuZGVuY3kKPiA+IG9uIGhh
cmR3YXJlKEFDUEkvVFBNKSBkdXJpbmcgYm9vdCBhbmQgZWFybHkgYm9vdCBzZXJ2aWNlcywgd2hl
cmUgYXMgY2FycnlpbmcgdGhlIGxvZ3MgaXMKPiA+IG9ubHkgZHVyaW5nIHRoZSBrZXhlY19maWxl
X2xvYWQgc3lzIGNhbGwgYW5kIGRvZXMgbm90IGludGVyZmVyZSB3aXRoIHRoYXQgY29kZSBwYXRo
Lgo+ID4gSU1BIGRvY3VtZW50YXRpb246IGh0dHBzOi8vc291cmNlZm9yZ2UubmV0L3AvbGludXgt
aW1hL3dpa2kvSG9tZS8KPiAKPiBTdXBwb3J0aW5nIEFDUEkgaW4gdGhlIHNhbWUgd2F5IGlzIHNv
bWV0aGluZyB3ZSBuZWVkIHRvIGRvIGZyb20gZGF5IG9uZS4ga2V4ZWNfZmlsZV9sb2FkKCkKPiBh
bHJlYWR5IGRvZXMgdGhpcy4gSSdtIG5vdCBzdXJlICJvbmx5IGtleGVjX2ZpbGVfbG9hZCgpIiBp
cyBhIGp1c3RpZmlhYmxlIHJlc3RyaWN0aW9uLi4uCgpUaGUgVFBNIFBDUnMgYXJlIG5vdCByZXNl
dCBvbiBhIHNvZnQgcmVib290LiDCoEFzIGEgcmVzdWx0LCBpbiBvcmRlciB0bwp2YWxpZGF0ZSB0
aGUgSU1BIG1lYXN1cmVtZW50IGxpc3QgYWdhaW5zdCB0aGUgVFBNIFBDUnMsIHRoZSBJTUEKbWVh
c3VyZW1lbnQgbGlzdCBpcyBzYXZlZCBvbiBrZXhlYyBsb2FkLCByZXN0b3JlZCBvbiBib290LCBh
bmQgdGhlbgp0aGUgbWVtb3J5IGFsbG9jYXRlZCBmb3IgY2FycnlpbmcgdGhlIG1lYXN1cmVtZW50
IGxpc3QgYWNyb3NzIGtleGVjIGlzCmZyZWVkLgoKV2hlcmUvaG93IHRvIHNhdmUgdGhlIElNQSBt
ZWFzdXJlbWVudCBsaXN0IGlzIGFyY2hpdGVjdHVyZSBkZXBlbmRlbnQuCsKgVGhpYWdvIEJhdWVy
bWFubiBpbXBsZW1lbnRlZCBhbGxvY2F0aW5nIGFuZCBmcmVlaW5nIHRoZSBtZWFzdXJlbWVudAps
aXN0IG1lbW9yeSBmb3IgUG93ZXIuCgpNaW1pCgoKX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18Ka2V4ZWMgbWFpbGluZyBsaXN0CmtleGVjQGxpc3RzLmluZnJh
ZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9rZXhl
Ywo=
