Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gjQNa-0000gv-Sg
 for kexec@lists.infradead.org; Tue, 15 Jan 2019 15:11:52 +0000
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 x0FF3uHf141598
 for <kexec@lists.infradead.org>; Tue, 15 Jan 2019 10:11:46 -0500
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2q1g50eq5b-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <kexec@lists.infradead.org>; Tue, 15 Jan 2019 10:11:46 -0500
Received: from localhost
 by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <nayna@linux.vnet.ibm.com>;
 Tue, 15 Jan 2019 15:11:45 -0000
MIME-Version: 1.0
Date: Tue, 15 Jan 2019 10:17:13 -0500
From: nayna <nayna@linux.vnet.ibm.com>
Subject: Re: [RFC PATCH 2/2] kexec, KEYS: Make use of platform keyring for
 signature verify
In-Reply-To: <20190115024243.GA9199@dhcp-128-65.nay.redhat.com>
References: <20190109164824.19708-1-kasong@redhat.com>
 <20190109164824.19708-3-kasong@redhat.com>
 <20190111134303.GA12760@dhcp-128-65.nay.redhat.com>
 <1547223220.19931.471.camel@linux.ibm.com>
 <20190113013958.GA14019@dhcp-128-65.nay.redhat.com>
 <1547482251.4156.127.camel@linux.ibm.com>
 <20190115024243.GA9199@dhcp-128-65.nay.redhat.com>
Message-Id: <3c80c88c90ead96cea9a4f13af41fc5b@linux.vnet.ibm.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Dave Young <dyoung@redhat.com>
Cc: jwboyer@fedoraproject.org, Kairui Song <kasong@redhat.com>, ebiggers@google.com, nayna@linux.ibm.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>, jmorris@namei.org, dhowells@redhat.com, keyrings@vger.kernel.org, linux-integrity@vger.kernel.org, dwmw2@infradead.org, bauerman@linux.ibm.com, serge@hallyn.com

T24gMjAxOS0wMS0xNCAyMTo0MiwgRGF2ZSBZb3VuZyB3cm90ZToKPiBPbiAwMS8xNC8xOSBhdCAx
MToxMGFtLCBNaW1pIFpvaGFyIHdyb3RlOgo+PiBPbiBTdW4sIDIwMTktMDEtMTMgYXQgMDk6Mzkg
KzA4MDAsIERhdmUgWW91bmcgd3JvdGU6Cj4+ID4gSGksCj4+ID4KPj4gPiBPbiAwMS8xMS8xOSBh
dCAxMToxM2FtLCBNaW1pIFpvaGFyIHdyb3RlOgo+PiA+ID4gT24gRnJpLCAyMDE5LTAxLTExIGF0
IDIxOjQzICswODAwLCBEYXZlIFlvdW5nIHdyb3RlOgo+PiA+ID4gW3NuaXBdCj4+ID4gPgo+PiA+
ID4gPiBQZXJzb25hbGx5IEkgd291bGQgbGlrZSB0byBzZWUgcGxhdGZvcm0ga2V5IHNlcGFyYXRl
ZCBmcm9tIGludGVncml0eS4KPj4gPiA+ID4gQnV0IGZvciB0aGUga2V4ZWNfZmlsZSBwYXJ0IEkg
dGhpbmsgaXQgaXMgZ29vZCBhdCBsZWFzdCBpdCB3b3JrcyB3aXRoCj4+ID4gPiA+IHRoaXMgZml4
Lgo+PiA+ID4gPgo+PiA+ID4gPiBBY2tlZC1ieTogRGF2ZSBZb3VuZyA8ZHlvdW5nQHJlZGhhdC5j
b20+Cj4+ID4gPgo+PiA+ID4gVGhlIG9yaWdpbmFsICJwbGF0Zm9ybSIga2V5cmluZyBwYXRjaGVz
IHRoYXQgTmF5bmEgcG9zdGVkIG11bHRpcGxlCj4+ID4gPiB0aW1lcyB3ZXJlIGluIHRoZSBjZXJ0
cyBkaXJlY3RvcnksIGJ1dCBub2JvZHkgY29tbWVudGVkL3Jlc3BvbmRlZC4gwqBTbwo+PiA+ID4g
c2hlIHJld29ya2VkIHRoZSBwYXRjaGVzLCBtb3ZpbmcgdGhlbSB0byB0aGUgaW50ZWdyaXR5IGRp
cmVjdG9yeSBhbmQKPj4gPiA+IHBvc3RlZCB0aGVtIChjYydpbmcgdGhlIGtleGVjIG1haWxpbmcg
bGlzdCkuIMKgSXQncyBhIGJpdCBsYXRlIHRvIGJlCj4+ID4gPiBhc2tpbmcgdG8gbW92ZSBpdCwg
aXNuJ3QgaXQ/Cj4+ID4KPj4gPiBIbW0sIGFwb2xvZ2l6ZSBmb3IgYmVpbmcgbGF0ZSwgIEkgZGlk
IG5vdCBnZXQgY2hhbmNlIHRvIGhhdmUgYSBsb29rIHRoZQo+PiA+IG9sZCBzZXJpZXMuICBTaW5j
ZSB3ZSBoYXZlIHRoZSBuZWVkcyBub3csIGl0IHNob3VsZCBiZSBzdGlsbCBmaW5lCj4+ID4KPj4g
PiBNYXliZSBLYWlydWkgY2FuIGNoZWNrIE5heW5hJ3Mgb2xkIHNlcmllcywgc2VlIGlmIGhlIGNh
biBkbyBzb21ldGhpbmcKPj4gPiBhZ2Fpbj8KPj4gCj4+IFdoZXRoZXIgdGhlIHBsYXRmb3JtIGtl
eXJpbmcgaXMgZGVmaW5lZCBpbiBjZXJ0cy8gb3IgaW4gaW50ZWdyaXR5LyB0aGUKPj4ga2V5cmlu
ZyBpZCBuZWVkcyB0byBiZSBhY2Nlc3NpYmxlIHRvIHRoZSBvdGhlciwgd2l0aG91dCBtYWtpbmcg
dGhlCj4+IGtleXJpbmcgaWQgZ2xvYmFsLiDCoE1vdmluZyB3aGVyZSB0aGUgcGxhdGZvcm0ga2V5
cmluZyBpcyBkZWZpbmVkIGlzCj4+IG5vdCB0aGUgcHJvYmxlbS4KPiAKPiBBZ3JlZWQsIGJ1dCBq
dXN0IGZlZWwga2V4ZWMgZGVwZW5kcyBvbiBJTUEgc291bmRzIG5vdCBnb29kLgoKVGhlIHBsYXRm
b3JtIGtleXJpbmcgaXMgbm90IGRlcGVuZGVudCBvbiBJTUEsIGl0IGlzIGRlcGVuZGVudCBvbiAK
ImludGVncml0eSIgLSBDT05GSUdfSU5URUdSSVRZX0FTWU1NRVRSSUNfS0VZUy4KT3RoZXIgQ09O
RklHUyB3aGljaCBpdCBuZWVkcyBhcmUgQ09ORklHX1NZU1RFTV9CTEFDS0xJU1RfS0VZUklORywg
CkNPTkZJR19FRkkuCgpUaGFua3MgJiBSZWdhcmRzLAogICAgLSBOYXluYQoKCl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmtleGVjIG1haWxpbmcgbGlzdApr
ZXhlY0BsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxt
YW4vbGlzdGluZm8va2V4ZWMK
