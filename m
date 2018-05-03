Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]
 helo=mx0a-001b2d01.pphosted.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1fELRg-0004kP-RB
 for kexec@lists.infradead.org; Thu, 03 May 2018 21:07:22 +0000
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w43L4Yin041301
 for <kexec@lists.infradead.org>; Thu, 3 May 2018 17:07:08 -0400
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2hr737f1vg-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <kexec@lists.infradead.org>; Thu, 03 May 2018 17:07:07 -0400
Received: from localhost
 by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <zohar@linux.vnet.ibm.com>;
 Thu, 3 May 2018 22:07:06 +0100
Subject: Re: [PATCH 2/3] kexec: call LSM hook for kexec_load syscall
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
Date: Thu, 03 May 2018 17:06:59 -0400
In-Reply-To: <87y3h0pu72.fsf@xmission.com>
References: <1523572911-16363-1-git-send-email-zohar@linux.vnet.ibm.com>
 <1523572911-16363-3-git-send-email-zohar@linux.vnet.ibm.com>
 <87h8nqglpx.fsf@xmission.com>
 <1525275904.5669.308.camel@linux.vnet.ibm.com>
 <87h8nospo5.fsf@xmission.com>
 <6203b1e4-70c3-6d0e-60e0-56c6e8f72ec9@schaufler-ca.com>
 <87y3h0pu72.fsf@xmission.com>
Mime-Version: 1.0
Message-Id: <1525381619.3539.45.camel@linux.vnet.ibm.com>
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
To: "Eric W. Biederman" <ebiederm@xmission.com>, Casey Schaufler <casey@schaufler-ca.com>
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Matthew Garrett <mjg59@google.com>, David Howells <dhowells@redhat.com>, linux-security-module@vger.kernel.org, linux-integrity@vger.kernel.org

T24gVGh1LCAyMDE4LTA1LTAzIGF0IDExOjQyIC0wNTAwLCBFcmljIFcuIEJpZWRlcm1hbiB3cm90
ZToKPiBDYXNleSBTY2hhdWZsZXIgPGNhc2V5QHNjaGF1Zmxlci1jYS5jb20+IHdyaXRlczoKPiAK
PiA+IE9uIDUvMy8yMDE4IDg6NTEgQU0sIEVyaWMgVy4gQmllZGVybWFuIHdyb3RlOgo+ID4+IE1p
bWkgWm9oYXIgPHpvaGFyQGxpbnV4LnZuZXQuaWJtLmNvbT4gd3JpdGVzOgo+ID4+Cj4gPj4+IE9u
IFdlZCwgMjAxOC0wNS0wMiBhdCAwOTo0NSAtMDUwMCwgRXJpYyBXLiBCaWVkZXJtYW4gd3JvdGU6
Cj4gPj4+PiBNaW1pIFpvaGFyIDx6b2hhckBsaW51eC52bmV0LmlibS5jb20+IHdyaXRlczoKPiA+
Pj4+Cj4gPj4+Pj4gQWxsb3cgTFNNcyBhbmQgSU1BIHRvIGRpZmZlcmVudGlhdGUgYmV0d2VlbiB0
aGUga2V4ZWNfbG9hZCBhbmQKPiA+Pj4+PiBrZXhlY19maWxlX2xvYWQgc3lzY2FsbHMgYnkgYWRk
aW5nIGFuICJ1bm5lY2Vzc2FyeSIgY2FsbCB0bwo+ID4+Pj4+IHNlY3VyaXR5X2tlcm5lbF9yZWFk
X2ZpbGUoKSBpbiBrZXhlY19sb2FkLiAgVGhpcyB3b3VsZCBiZSBzaW1pbGFyIHRvIHRoZQo+ID4+
Pj4+IGV4aXN0aW5nIGluaXRfbW9kdWxlIHN5c2NhbGwgY2FsbGluZyBzZWN1cml0eV9rZXJuZWxf
cmVhZF9maWxlKCkuCj4gPj4+PiBHaXZlbiB0aGUgcmVhc29uYWJsZSBkZXNpcmUgdG8gbG9hZCBh
IHBvbGljeSB0aGF0IGVuc3VyZXMgZXZlcnl0aGluZwo+ID4+Pj4gaGFzIGEgc2lnbmF0dXJlIEkg
ZG9uJ3QgaGF2ZSBmdW5kYW1lbnRhbCBvYmplY3Rpb25zLgo+ID4+Pj4KPiA+Pj4+IHNlY3VyaXR5
X2tlcm5lbF9yZWFkX2ZpbGUgYXMgYSBob29rIHNlZW1zIGFuIG9kZCBjaG9pY2UuICBBdCB0aGUg
dmVyeQo+ID4+Pj4gbGVhc3QgaXQgaGFzIGEgYmFkIG5hbWUgYmVjYXVzZSB0aGVyZSBpcyBubyBm
aWxlIHJlYWRpbmcgZ29pbmcgb24gaGVyZS4KPiA+Pj4+Cj4gPj4+PiBJIGFtIGNvbmNlcm5lZCB0
aGF0IEkgZG9uJ3Qgc2VlIENPTkZJR19LRVhFQ19WRVJJRllfU0lHIGJlaW5nIHRlc3RlZAo+ID4+
Pj4gYW55d2hlcmUuICBXaGljaCBtZWFucyBJIGNvdWxkIGhhdmUgYSBrZXJuZWwgY29tcGlsZWQg
d2l0aG91dCB0aGF0IGFuZCBJCj4gPj4+PiB3b3VsZCBiZSBhbGxvd2VkIHRvIHVzZSBrZXhlY19m
aWxlX2xvYWQgd2l0aG91dCBzaWduYXR1cmUgY2hlY2tpbmcuCj4gPj4+PiBXaGlsZSBrZXhlY19s
b2FkIHdvdWxkIGJlIGRlbmllZC4KPiA+Pj4+Cj4gPj4+PiBBbSBJIG1pc3Npbmcgc29tZXRoaW5n
IGhlcmU/Cj4gPj4+IFRoZSBrZXhlY19maWxlX2xvYWQoKSBjYWxscyBrZXJuZWxfcmVhZF9maWxl
X2Zyb21fZmQoKSwgd2hpY2ggaW4gdHVybgo+ID4+PiBjYWxscyBzZWN1cml0eV9rZXJuZWxfcmVh
ZF9maWxlKCkuIMKgU28ga2V4ZWNfZmlsZV9sb2FkIGFuZCBrZXhlY19sb2FkCj4gPj4+IHN5c2Nh
bGwgd291bGQgYmUgdXNpbmcgdGhlIHNhbWUgbWV0aG9kIGZvciBlbmZvcmNpbmcgc2lnbmF0dXJl
Cj4gPj4+IHZlcmlmaWNhdGlvbi4KPiA+PiBIYXZpbmcgbG9va2VkIGF0IHlvdXIgcGF0Y2hlcyBh
bmQgdGhlIGtlcm5lbCBhIGxpdHRsZSBtb3JlIEkgdGhpbmsKPiA+PiB0aGlzIHNob3VsZCBiZSBh
IHNlcGFyYXRlIHNlY3VyaXR5IGhvb2sgdGhhdCBkb2VzIG5vdCB0YWtlIGEgZmlsZQo+ID4+IHBh
cmFtZXRlci4KPiA+Pgo+ID4+IFJpZ2h0IG5vdyBldmVyeSBvdGhlciBzZWN1cml0eSBtb2R1bGUg
YXNzdW1lcyAhZmlsZSBpcyBpbml0X21vZHVsZS4KPiA+PiBTbyBJIHRoaW5rIHRoaXMgY2hhbmdl
IGhhcyB0aGUgcG90ZW50aWFsIHRvIGNvbmZ1c2Ugb3RoZXIgc2VjdXJpdHkKPiA+PiBtb2R1bGVz
LCB3aXRoIHRoZSByZXN1bHQgb2YgdW5pbnRlbmRlZCBwb2xpY3kgYmVpbmcgYXBwbGllZC4KPiA+
Pgo+ID4+IFNvIGp1c3QgZm9yIGdvb2Qgc2VjdXJpdHkgbW9kdWxlIGh5Z2VpbmUgSSB0aGluayB0
aGlzIG5lZWRzIGEgZGVkaWNhdGVkCj4gPj4ga2V4ZWNfbG9hZCBzZWN1cml0eSBob29rLgo+ID4K
PiA+IEkgd291bGQgcmF0aGVyIHNlZSB0aGUgZXhpc3RpbmcgbW9kdWxlcyB1cGRhdGVkIHRoYW4g
YSBuZXcKPiA+IGhvb2sgYWRkZWQuIFRvbyBtYW55IGhvb2tzIHNwb2lsIHRoZSBicm90aC4gVHdv
IGhvb2tzIHdpdGgKPiA+IHRyaXZpYWwgZGlmZmVyZW5jZXMganVzdCBhZGQgdG8gdGhlIGNsdXR0
ZXIgYW5kIG1ha2UgaXQgaGFyZGVyCj4gPiBmb3Igbm9uLWxzbSBkZXZlbG9wZXJzIHRvIGZpZ3Vy
ZSBvdXQgd2hhdCB0byB1c2UgaW4gdGhlaXIKPiA+IGNvZGUuCj4gCj4gVGhlc2UgYXJlIG5vdCBu
b24tdHJpdmlhbCBkaWZmZXJlbmNlcy4gIFRoZXJlIGlzIGFic29sdXRlbHkgbm90aGluZwo+IGZp
bGUgcmVsYXRlZCBhYm91dCBrZXhlY19sb2FkLiAgTm9yIGZvciBpbml0X21vZHVsZSBmb3IgdGhh
dCBtYXR0ZXIuCj4gCj4gSWYgc29tZXRoaW5nIGlzIGNhbGxlZCBzZWN1cml0eV9rZXJuZWxfcmVh
ZF9maWxlIEkgdGhpbmsgaXQgaXMgd2hvbGx5Cj4gYXBwcm9wcmlhdGUgZm9yIGNvZGUgdGhhdCBw
cm9jZXNzZXMgc3VjaCBhIGhvb2sgdG8gYXNzdW1lIGZpbGUgaXMKPiBub24tTlVMTC4KPiAKPiBX
aGVuIHlvdSBoYXZlIHRvIGRhbmNlIGEgamlnICh3aGljaCBpcyB3aGF0IEkgc2VlIHRoZSBzZWN1
cml0eSBtb2R1bGVzCj4gZG9pbmcpIHRvIGZpZ3VyZSBvdXQgd2hvIGlzIGNhbGxpbmcgYSBsc20g
aG9vayBmb3Igd2hhdCBwdXJwb3NlIEkgdGhpbmsKPiBpdCBpcyBhIG1haW50ZW5hbmNlIHByb2Js
ZW0gd2FpdGluZyB0byBoYXBwZW4gYW5kIHRoYXQgdGhlIGhvb2sgaXMgYmFkbHkKPiBkZXNpZ25l
ZC4KPiAKPiBBdCB0aGlzIHBvaW50IEkgZG9uJ3QgY2FyZSB3aGF0IHRoZSBsc20ncyBkbyB3aXRo
IHRoZSBob29rcyBidXQgdGhlCj4gaG9va3MgbmVlZCB0byBtYWtlIHNlbnNlIGZvciBwZW9wbGUg
b3V0c2lkZSBvZiB0aGUgbHNtJ3MgYW5kIHNvbWV0aGluZwo+IGFib3V0IHJlYWRpbmcgYSBmaWxl
IGluIGEgc3lzY2FsbCB0aGF0IGRvZXNuJ3QgcmVhZCBmaWxlcyBpcyBjb21wbGV0ZQo+IGFuZCB1
dHRlciBub25zZW5zZS4KClN1cmUsIHdlIGNhbiBkZWZpbmUgYSB3cmFwcGVyIGFyb3VuZCB0aGUg
c2VjdXJpdHlfa2VybmVsX3JlYWRfZmlsZSgpCmhvb2ssIGNhbGxpbmcgaXQgc2VjdXJpdHlfbm9u
LWZkX3N5c2NhbGwoKSBvciBldmVuCnNlY3VyaXR5X29sZF9zeXNjYWxsKCkuCgpNaW1pCgoKX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18Ka2V4ZWMgbWFpbGlu
ZyBsaXN0CmtleGVjQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5v
cmcvbWFpbG1hbi9saXN0aW5mby9rZXhlYwo=
