Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gW40D-00086X-Tb
 for kexec@lists.infradead.org; Sun, 09 Dec 2018 18:40:31 +0000
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 wB9Id9qa039554
 for <kexec@lists.infradead.org>; Sun, 9 Dec 2018 13:40:17 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2p8v24mg11-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <kexec@lists.infradead.org>; Sun, 09 Dec 2018 13:40:17 -0500
Received: from localhost
 by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <zohar@linux.ibm.com>;
 Sun, 9 Dec 2018 18:40:15 -0000
Subject: Re: [PATCH v2 0/7] add platform/firmware keys support for kernel
 verification by IMA
From: Mimi Zohar <zohar@linux.ibm.com>
Date: Sun, 09 Dec 2018 13:39:56 -0500
In-Reply-To: <20181208202705.18673-1-nayna@linux.ibm.com>
References: <20181208202705.18673-1-nayna@linux.ibm.com>
Mime-Version: 1.0
Message-Id: <1544380796.3794.6.camel@linux.ibm.com>
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
To: Nayna Jain <nayna@linux.ibm.com>, linux-integrity@vger.kernel.org
Cc: linux-efi@vger.kernel.org, mpe@ellerman.id.au, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, dhowells@redhat.com, seth.forshee@canonical.com, linux-security-module@vger.kernel.org, keyrings@vger.kernel.org, ebiederm@xmission.com, jforbes@redhat.com, vgoyal@redhat.com

SGkgTmF5bmEsCgpPbiBTdW4sIDIwMTgtMTItMDkgYXQgMDE6NTYgKzA1MzAsIE5heW5hIEphaW4g
d3JvdGU6Cj4gT24gc2VjdXJlIGJvb3QgZW5hYmxlZCBzeXN0ZW1zLCBhIHZlcmlmaWVkIGtlcm5l
bCBtYXkgbmVlZCB0byBrZXhlYwo+IGFkZGl0aW9uYWwga2VybmVscy4gRm9yIGV4YW1wbGUsIGl0
IG1heSBiZSB1c2VkIGFzIGEgYm9vdGxvYWRlciBuZWVkaW5nCj4gdG8ga2V4ZWMgYSB0YXJnZXQg
a2VybmVsIG9yIGl0IG1heSBuZWVkIHRvIGtleGVjIGEgY3Jhc2hkdW1wIGtlcm5lbC4KPiBJbiBz
dWNoIGNhc2VzLCBpdCBtYXkgd2FudCB0byB2ZXJpZnkgdGhlIHNpZ25hdHVyZSBvZiB0aGUgbmV4
dCBrZXJuZWwKPiBpbWFnZS4KPiAKPiBJdCBpcyBwb3NzaWJsZSB0aGF0IHRoZSBuZXcga2VybmVs
IGltYWdlIGlzIHNpZ25lZCB3aXRoIHRoaXJkIHBhcnR5IGtleXMKPiB3aGljaCBhcmUgc3RvcmVk
IGFzIHBsYXRmb3JtIG9yIGZpcm13YXJlIGtleXMgaW4gdGhlICdkYicgdmFyaWFibGUuIFRoZQo+
IGtlcm5lbCwgaG93ZXZlciwgY2FuIG5vdCBkaXJlY3RseSB2ZXJpZnkgdGhlc2UgcGxhdGZvcm0g
a2V5cywgYW5kIGFuCj4gYWRtaW5pc3RyYXRvciBtYXkgdGhlcmVmb3JlIG5vdCB3YW50IHRvIHRy
dXN0IHRoZW0gZm9yIGFyYml0cmFyeSB1c2FnZS4KPiBJbiBvcmRlciB0byBkaWZmZXJlbnRpYXRl
IHBsYXRmb3JtIGtleXMgZnJvbSBvdGhlciBrZXlzIGFuZCBwcm92aWRlIHRoZQo+IG5lY2Vzc2Fy
eSBzZXBhcmF0aW9uIG9mIHRydXN0IHRoZSBrZXJuZWwgbmVlZHMgYW4gYWRkaXRpb25hbCBrZXly
aW5nIHRvCj4gc3RvcmUgcGxhdGZvcm0vZmlybXdhcmUga2V5cy4KPiAKPiBUaGUgc2VjdXJlIGJv
b3Qga2V5IGRhdGFiYXNlIGlzIGV4cGVjdGVkIHRvIHN0b3JlIHRoZSBrZXlzIGFzIEVGSQo+IFNp
Z25hdHVyZSBMaXN0KEVTTCkuIFRoZSBwYXRjaCBzZXQgdXNlcyBEYXZpZCBIb3dlbGxzIGFuZCBK
b3NoIEJveWVyJ3MKPiBwYXRjaCB0byBhY2Nlc3MgYW5kIHBhcnNlIHRoZSBFU0wgdG8gZXh0cmFj
dCB0aGUgY2VydGlmaWNhdGVzIGFuZCBsb2FkCj4gdGhlbSBvbnRvIHRoZSBwbGF0Zm9ybSBrZXly
aW5nLgo+IAo+IFRoZSBsYXN0IHBhdGNoIGluIHRoaXMgcGF0Y2ggc2V0IGFkZHMgc3VwcG9ydCBm
b3IgSU1BLWFwcHJhaXNhbCB0bwo+IHZlcmlmeSB0aGUga2V4ZWMnZWQga2VybmVsIGltYWdlIGJh
c2VkIG9uIGtleXMgc3RvcmVkIGluIHRoZSBwbGF0Zm9ybQo+IGtleXJpbmcuCgpUaGFua3MhIMKg
VGhpcyBwYXRjaCBzZXQgaXMgbm93IGluIHRoZSAjbmV4dC1pbnRlZ3JpdHkgYnJhbmNoLgoKaHR0
cHM6Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9naXQvem9oYXIvbGludXgt
aW50ZWdyaXR5LmdpdC8KCk1pbWkKCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXwprZXhlYyBtYWlsaW5nIGxpc3QKa2V4ZWNAbGlzdHMuaW5mcmFkZWFkLm9y
ZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2tleGVjCg==
