Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mVb4e-00BS3A-RC
 for kexec@lists.infradead.org; Wed, 29 Sep 2021 15:00:46 +0000
Subject: Re: [PATCH v1 2/8] x86/xen: simplify xen_oldmem_pfn_is_ram()
References: <20210928182258.12451-1-david@redhat.com>
 <20210928182258.12451-3-david@redhat.com>
 <4ab2f8c2-c3d5-30b3-a670-a8b38e218b6e@oracle.com>
 <bfe72f46-9a0d-1a87-64bd-4b03999edd1e@redhat.com>
 <e9a230f9-85cb-d4c1-8027-508b7c344d94@redhat.com>
From: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Message-ID: <3b935aa0-6d85-0bcd-100e-15098add3c4c@oracle.com>
Date: Wed, 29 Sep 2021 10:22:07 -0400
In-Reply-To: <e9a230f9-85cb-d4c1-8027-508b7c344d94@redhat.com>
Content-Language: en-US
MIME-Version: 1.0
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
To: David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, Juergen Gross <jgross@suse.com>, Stefano Stabellini <sstabellini@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Dave Young <dyoung@redhat.com>, Baoquan He <bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>, Michal Hocko <mhocko@suse.com>, Oscar Salvador <osalvador@suse.de>, Mike Rapoport <rppt@kernel.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, x86@kernel.org, xen-devel@lists.xenproject.org, virtualization@lists.linux-foundation.org, kexec@lists.infradead.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org

Ck9uIDkvMjkvMjEgNTowMyBBTSwgRGF2aWQgSGlsZGVuYnJhbmQgd3JvdGU6Cj4gT24gMjkuMDku
MjEgMTA6NDUsIERhdmlkIEhpbGRlbmJyYW5kIHdyb3RlOgo+Pj4KPj4gQ2FuIHdlIGdvIG9uZSBz
dGVwIGZ1cnRoZXIgYW5kIGRvCj4+Cj4+Cj4+IEBAIC0yMCwyNCArMjAsMTEgQEAgc3RhdGljIGlu
dCB4ZW5fb2xkbWVtX3Bmbl9pc19yYW0odW5zaWduZWQgbG9uZyBwZm4pCj4+IMKgwqDCoMKgwqDC
oMKgwqDCoCBzdHJ1Y3QgeGVuX2h2bV9nZXRfbWVtX3R5cGUgYSA9IHsKPj4gwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAuZG9taWQgPSBET01JRF9TRUxGLAo+PiDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIC5wZm4gPSBwZm4sCj4+ICvCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIC5tZW1fdHlwZSA9IEhWTU1FTV9yYW1fcncsCj4+IMKgwqDCoMKgwqDCoMKg
wqDCoCB9Owo+PiAtwqDCoMKgwqDCoMKgIGludCByYW07Cj4+IMKgwqAgLcKgwqDCoMKgwqDCoCBp
ZiAoSFlQRVJWSVNPUl9odm1fb3AoSFZNT1BfZ2V0X21lbV90eXBlLCAmYSkpCj4+IC3CoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJldHVybiAtRU5YSU87Cj4+IC0KPj4gLcKgwqDCoMKgwqDC
oCBzd2l0Y2ggKGEubWVtX3R5cGUpIHsKPj4gLcKgwqDCoMKgwqDCoCBjYXNlIEhWTU1FTV9tbWlv
X2RtOgo+PiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByYW0gPSAwOwo+PiAtwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBicmVhazsKPj4gLcKgwqDCoMKgwqDCoCBjYXNlIEhWTU1F
TV9yYW1fcnc6Cj4+IC3CoMKgwqDCoMKgwqAgY2FzZSBIVk1NRU1fcmFtX3JvOgo+PiAtwqDCoMKg
wqDCoMKgIGRlZmF1bHQ6Cj4+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJhbSA9IDE7
Cj4+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGJyZWFrOwo+PiAtwqDCoMKgwqDCoMKg
IH0KPj4gLQo+PiAtwqDCoMKgwqDCoMKgIHJldHVybiByYW07Cj4+ICvCoMKgwqDCoMKgwqAgSFlQ
RVJWSVNPUl9odm1fb3AoSFZNT1BfZ2V0X21lbV90eXBlLCAmYSk7Cj4+ICvCoMKgwqDCoMKgwqAg
cmV0dXJuIGEubWVtX3R5cGUgIT0gSFZNTUVNX21taW9fZG07CgoKSSB3YXMgYWN0dWFsbHkgdGhp
bmtpbmcgb2YgYXNraW5nIHlvdSB0byBhZGQgYW5vdGhlciBwYXRjaCB3aXRoIHByX3dhcm5fb25j
ZSgpIGhlcmUgKGFuZCBwcmludCBlcnJvciBjb2RlIGFzIHdlbGwpLiBUaGlzIGNhbGwgZmFpbGlu
ZyBpcyBpbmRpY2F0aW9uIG9mIHNvbWV0aGluZyBnb2luZyBxdWl0ZSB3cm9uZyBhbmQgaXQgd291
bGQgYmUgZ29vZCB0byBrbm93IGFib3V0IHRoaXMuCgoKPj4gwqDCoCB9Cj4+IMKgwqAgI2VuZGlm
Cj4+Cj4+Cj4+IEFzc3VtaW5nIHRoYXQgaWYgSFlQRVJWSVNPUl9odm1fb3AoKSBmYWlscyB0aGF0
Cj4+IC5tZW1fdHlwZSBpcyBub3Qgc2V0IHRvIEhWTU1FTV9tbWlvX2RtLgoKCkkgZG9uJ3QgdGhp
bmsgd2UgY2FuIGFzc3VtZSB0aGF0IGFyZ3VtZW50IGRlc2NyaWJlZCBhcyBPVVQgaW4gdGhlIEFC
SSB3aWxsIG5vdCBiZSBjbG9iYmVyZWQgaW4gY2FzZSBvZiBlcnJvcgoKCj4+Cj4KPiBPa2F5IHdl
IGNhbid0LCBkdWUgdG8gIl9fbXVzdF9jaGVjayIgLi4uCgoKc28gdGhpcyBpcyBhIGdvb2QgdGhp
bmcgOy0pCgoKLWJvcmlzCgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18Ka2V4ZWMgbWFpbGluZyBsaXN0CmtleGVjQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0
cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9rZXhlYwo=
