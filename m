Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mVbB0-00BUkM-UK
 for kexec@lists.infradead.org; Wed, 29 Sep 2021 15:07:21 +0000
Received: by mail-wm1-f71.google.com with SMTP id
 b139-20020a1c8091000000b002fb33c467c8so1355062wmd.5
 for <kexec@lists.infradead.org>; Wed, 29 Sep 2021 08:07:13 -0700 (PDT)
Subject: Re: [PATCH v1 2/8] x86/xen: simplify xen_oldmem_pfn_is_ram()
References: <20210928182258.12451-1-david@redhat.com>
 <20210928182258.12451-3-david@redhat.com>
 <4ab2f8c2-c3d5-30b3-a670-a8b38e218b6e@oracle.com>
 <bfe72f46-9a0d-1a87-64bd-4b03999edd1e@redhat.com>
 <e9a230f9-85cb-d4c1-8027-508b7c344d94@redhat.com>
 <3b935aa0-6d85-0bcd-100e-15098add3c4c@oracle.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <e6ace8c8-8a2d-9bf7-e65b-91d0037c4d08@redhat.com>
Date: Wed, 29 Sep 2021 17:07:10 +0200
MIME-Version: 1.0
In-Reply-To: <3b935aa0-6d85-0bcd-100e-15098add3c4c@oracle.com>
Content-Language: en-US
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
To: Boris Ostrovsky <boris.ostrovsky@oracle.com>, linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, Juergen Gross <jgross@suse.com>, Stefano Stabellini <sstabellini@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Dave Young <dyoung@redhat.com>, Baoquan He <bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>, Michal Hocko <mhocko@suse.com>, Oscar Salvador <osalvador@suse.de>, Mike Rapoport <rppt@kernel.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, x86@kernel.org, xen-devel@lists.xenproject.org, virtualization@lists.linux-foundation.org, kexec@lists.infradead.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org

T24gMjkuMDkuMjEgMTY6MjIsIEJvcmlzIE9zdHJvdnNreSB3cm90ZToKPiAKPiBPbiA5LzI5LzIx
IDU6MDMgQU0sIERhdmlkIEhpbGRlbmJyYW5kIHdyb3RlOgo+PiBPbiAyOS4wOS4yMSAxMDo0NSwg
RGF2aWQgSGlsZGVuYnJhbmQgd3JvdGU6Cj4+Pj4KPj4+IENhbiB3ZSBnbyBvbmUgc3RlcCBmdXJ0
aGVyIGFuZCBkbwo+Pj4KPj4+Cj4+PiBAQCAtMjAsMjQgKzIwLDExIEBAIHN0YXRpYyBpbnQgeGVu
X29sZG1lbV9wZm5faXNfcmFtKHVuc2lnbmVkIGxvbmcgcGZuKQo+Pj4gIMKgwqDCoMKgwqDCoMKg
wqDCoCBzdHJ1Y3QgeGVuX2h2bV9nZXRfbWVtX3R5cGUgYSA9IHsKPj4+ICDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIC5kb21pZCA9IERPTUlEX1NFTEYsCj4+PiAgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAucGZuID0gcGZuLAo+Pj4gK8KgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgLm1lbV90eXBlID0gSFZNTUVNX3JhbV9ydywKPj4+ICDCoMKgwqDCoMKg
wqDCoMKgwqAgfTsKPj4+IC3CoMKgwqDCoMKgwqAgaW50IHJhbTsKPj4+ICDCoMKgIC3CoMKgwqDC
oMKgwqAgaWYgKEhZUEVSVklTT1JfaHZtX29wKEhWTU9QX2dldF9tZW1fdHlwZSwgJmEpKQo+Pj4g
LcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuIC1FTlhJTzsKPj4+IC0KPj4+IC3C
oMKgwqDCoMKgwqAgc3dpdGNoIChhLm1lbV90eXBlKSB7Cj4+PiAtwqDCoMKgwqDCoMKgIGNhc2Ug
SFZNTUVNX21taW9fZG06Cj4+PiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByYW0gPSAw
Owo+Pj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgYnJlYWs7Cj4+PiAtwqDCoMKgwqDC
oMKgIGNhc2UgSFZNTUVNX3JhbV9ydzoKPj4+IC3CoMKgwqDCoMKgwqAgY2FzZSBIVk1NRU1fcmFt
X3JvOgo+Pj4gLcKgwqDCoMKgwqDCoCBkZWZhdWx0Ogo+Pj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgcmFtID0gMTsKPj4+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGJyZWFr
Owo+Pj4gLcKgwqDCoMKgwqDCoCB9Cj4+PiAtCj4+PiAtwqDCoMKgwqDCoMKgIHJldHVybiByYW07
Cj4+PiArwqDCoMKgwqDCoMKgIEhZUEVSVklTT1JfaHZtX29wKEhWTU9QX2dldF9tZW1fdHlwZSwg
JmEpOwo+Pj4gK8KgwqDCoMKgwqDCoCByZXR1cm4gYS5tZW1fdHlwZSAhPSBIVk1NRU1fbW1pb19k
bTsKPiAKPiAKPiBJIHdhcyBhY3R1YWxseSB0aGlua2luZyBvZiBhc2tpbmcgeW91IHRvIGFkZCBh
bm90aGVyIHBhdGNoIHdpdGggcHJfd2Fybl9vbmNlKCkgaGVyZSAoYW5kIHByaW50IGVycm9yIGNv
ZGUgYXMgd2VsbCkuIFRoaXMgY2FsbCBmYWlsaW5nIGlzIGluZGljYXRpb24gb2Ygc29tZXRoaW5n
IGdvaW5nIHF1aXRlIHdyb25nIGFuZCBpdCB3b3VsZCBiZSBnb29kIHRvIGtub3cgYWJvdXQgdGhp
cy4KCldpbGwgaW5jbHVkZSBhIHBhdGNoIGluIHYyLCB0aGFua3MhCgoKLS0gClRoYW5rcywKCkRh
dmlkIC8gZGhpbGRlbmIKCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwprZXhlYyBtYWlsaW5nIGxpc3QKa2V4ZWNAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRw
Oi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2tleGVjCg==
