Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e06smtp16.uk.ibm.com ([195.75.94.112])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Y8Pdr-0005EU-64
 for kexec@lists.infradead.org; Tue, 06 Jan 2015 08:37:32 +0000
Received: from /spool/local
 by e06smtp16.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <ldufour@linux.vnet.ibm.com>;
 Tue, 6 Jan 2015 08:37:07 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com
 (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
 by d06dlp01.portsmouth.uk.ibm.com (Postfix) with ESMTP id 74BE017D8043
 for <kexec@lists.infradead.org>; Tue,  6 Jan 2015 08:37:39 +0000 (GMT)
Received: from d06av09.portsmouth.uk.ibm.com (d06av09.portsmouth.uk.ibm.com
 [9.149.37.250])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t068b4Hw34668732
 for <kexec@lists.infradead.org>; Tue, 6 Jan 2015 08:37:04 GMT
Received: from d06av09.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av09.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t068b4UH017783
 for <kexec@lists.infradead.org>; Tue, 6 Jan 2015 01:37:04 -0700
Message-ID: <54AB9EAF.2020004@linux.vnet.ibm.com>
Date: Tue, 06 Jan 2015 09:37:03 +0100
From: Laurent Dufour <ldufour@linux.vnet.ibm.com>
MIME-Version: 1.0
Subject: Re: some questions about elf_ppc64_load
References: <OF9C6CA8A8.9D7923CD-ON48257DC5.0023F61F-48257DC5.0024E800@zte.com.cn>
In-Reply-To: <OF9C6CA8A8.9D7923CD-ON48257DC5.0023F61F-48257DC5.0024E800@zte.com.cn>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="gbk"
Content-Transfer-Encoding: base64
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: liu.song11@zte.com.cn
Cc: kexec@lists.infradead.org

T24gMDYvMDEvMjAxNSAwNzo0NCwgbGl1LnNvbmcxMUB6dGUuY29tLmNuIHdyb3RlOgo+IAo+IGhp
IGFsbKOsCj4gCj4gSSB1c2Uga2V4ZWMtdG9vbHMtMi4wLjggZm9yIHBwYzY0LCBpbiBmdWN0aW9u
IGVsZl9wcGM2NF9sb2FkIHByb21wdCAiQ2FuJ3QgdXNlIHJhbWRpc2sgd2l0aCBkZXZpY2UgdHJl
ZSBibG9iIGlucHV0Ii4KPiAKPiBJIGRvbid0IGtub3cgd2h5IGhlcmUgcmFtZGlzayBjYW4ndCB0
b2dldGhlciB3aXRoIGR0YixhbmQgbmVlZCBzb21lIGhlbHAuCgpUaGUgZGV2aWNlIHRyZWUgaXMg
YWxzbyBzcGVjaWZ5aW5nIGluaXRyZCAoc2VlIGtleGVjL2ZzMmR0LmMgcHV0bm9kZSksCnNvIHRo
ZXJlIGlzIDIgaW5pdHJkIHNwZWNpZnkgaW4gdGhhdCBjYXNlLiBUaGUgY29kZSBpcyBhIGJpdCBy
b3VnaCBoZXJlLApidXQgSSBndWVzcyB0aGlzIGlzIGJlY2F1c2UgdGhlcmUgaXMgbm90IHlldCBh
IHZhbGlkIHVzZSBjYXNlLgoKPiBJIGFsc28gaGF2ZSBzb21lIHF1ZXN0aW9ucywgd2hlbiBJIGp1
c3QgLi9rZXhlIC1sIHZtbGludXggdGhlbiAuL2tleGVjIC1lLCB3aWxsIGp1bXAgdG8gc2Vjb25k
IGtlcm5lbCBzdWNlc3NmdWxseSwKPiAKPiBidXQgd2l0aG91dCB1c2VmdWwgZHRiLCB0aGVuIGRl
dmljZSBjYW4ndCBpbml0IGNvcnJlY3QuIEJ1dCwgd2hlbiBJIGlucHV0IC4va2V4ZWMgLWwgdm1s
aW51eCAtLWR0Yj1teS5kdGIgLCB0aGVuCj4gCj4gLi9rZXhlYyAtZSwgdGhlIGtlcm5lbCBjb3Vs
ZG4ndCB3b3JrIGFuZCBjcmFzaCBpbiBoZWFkXzY0LlMsIHRoaXMgcHJvYmxlbSBhbHNvIG1ha2Ug
bWUgY29uZnVzZWQuCgpJdCdzIGhhcmQgdG8gc3RhdGUgd2l0aCBubyBtb3JlIGRldGFpbHMuIEkg
Z3Vlc3MgdGhlIGRldmljZSB0cmVlIGJsb2IKeW91J3JlIHVzaW5nIGlzIG5vdCB2YWxpZCwgb3Ig
Y29udGFpbiBiYWQgZGF0YS4KCkNoZWVycywKTGF1cmVudC4KCj4gVGhhbmtzCj4gUmVnYXJkcwo+
IC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
Cj4gWlRFIEluZm9ybWF0aW9uIFNlY3VyaXR5IE5vdGljZTogVGhlIGluZm9ybWF0aW9uIGNvbnRh
aW5lZCBpbiB0aGlzIG1haWwgKGFuZCBhbnkgYXR0YWNobWVudCB0cmFuc21pdHRlZCBoZXJld2l0
aCkgaXMgcHJpdmlsZWdlZCBhbmQgY29uZmlkZW50aWFsIGFuZCBpcyBpbnRlbmRlZCBmb3IgdGhl
IGV4Y2x1c2l2ZSB1c2Ugb2YgdGhlIGFkZHJlc3NlZShzKS4gIElmIHlvdSBhcmUgbm90IGFuIGlu
dGVuZGVkIHJlY2lwaWVudCwgYW55IGRpc2Nsb3N1cmUsIHJlcHJvZHVjdGlvbiwgZGlzdHJpYnV0
aW9uIG9yIG90aGVyIGRpc3NlbWluYXRpb24gb3IgdXNlIG9mIHRoZSBpbmZvcm1hdGlvbiBjb250
YWluZWQgaXMgc3RyaWN0bHkgcHJvaGliaXRlZC4gIElmIHlvdSBoYXZlIHJlY2VpdmVkIHRoaXMg
bWFpbCBpbiBlcnJvciwgcGxlYXNlIGRlbGV0ZSBpdCBhbmQgbm90aWZ5IHVzIGltbWVkaWF0ZWx5
Lgo+IF9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCj4ga2V4
ZWMgbWFpbGluZyBsaXN0Cj4ga2V4ZWNAbGlzdHMuaW5mcmFkZWFkLm9yZwo+IGh0dHA6Ly9saXN0
cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8va2V4ZWMKPiAKCgpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwprZXhlYyBtYWlsaW5nIGxpc3QKa2V4
ZWNAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFu
L2xpc3RpbmZvL2tleGVjCg==
