Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mVVDq-00AUaI-AU
 for kexec@lists.infradead.org; Wed, 29 Sep 2021 08:45:51 +0000
Received: by mail-wm1-f72.google.com with SMTP id
 z194-20020a1c7ecb000000b0030b7ccea080so2401463wmc.8
 for <kexec@lists.infradead.org>; Wed, 29 Sep 2021 01:45:47 -0700 (PDT)
Subject: Re: [PATCH v1 2/8] x86/xen: simplify xen_oldmem_pfn_is_ram()
References: <20210928182258.12451-1-david@redhat.com>
 <20210928182258.12451-3-david@redhat.com>
 <4ab2f8c2-c3d5-30b3-a670-a8b38e218b6e@oracle.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <bfe72f46-9a0d-1a87-64bd-4b03999edd1e@redhat.com>
Date: Wed, 29 Sep 2021 10:45:44 +0200
MIME-Version: 1.0
In-Reply-To: <4ab2f8c2-c3d5-30b3-a670-a8b38e218b6e@oracle.com>
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

PiAKPiBIb3cgYWJvdXQKPiAKPiAgwqDCoMKgIHJldHVybiBhLm1lbV90eXBlICE9IEhWTU1FTV9t
bWlvX2RtOwo+IAoKSGEsIGhvdyBjb3VsZCBJIGhhdmUgbWlzc2VkIHRoYXQgOikKCj4gCj4gUmVz
dWx0IHNob3VsZCBiZSBwcm9tb3RlZCB0byBpbnQgYW5kIHRoaXMgaGFzIGFkZGVkIGJlbmVmaXQg
b2Ygbm90IHJlcXVpcmluZyBjaGFuZ2VzIGluIHBhdGNoIDQuCj4gCgpDYW4gd2UgZ28gb25lIHN0
ZXAgZnVydGhlciBhbmQgZG8KCgpAQCAtMjAsMjQgKzIwLDExIEBAIHN0YXRpYyBpbnQgeGVuX29s
ZG1lbV9wZm5faXNfcmFtKHVuc2lnbmVkIGxvbmcgcGZuKQogICAgICAgICBzdHJ1Y3QgeGVuX2h2
bV9nZXRfbWVtX3R5cGUgYSA9IHsKICAgICAgICAgICAgICAgICAuZG9taWQgPSBET01JRF9TRUxG
LAogICAgICAgICAgICAgICAgIC5wZm4gPSBwZm4sCisgICAgICAgICAgICAgICAubWVtX3R5cGUg
PSBIVk1NRU1fcmFtX3J3LAogICAgICAgICB9OwotICAgICAgIGludCByYW07CiAgCi0gICAgICAg
aWYgKEhZUEVSVklTT1JfaHZtX29wKEhWTU9QX2dldF9tZW1fdHlwZSwgJmEpKQotICAgICAgICAg
ICAgICAgcmV0dXJuIC1FTlhJTzsKLQotICAgICAgIHN3aXRjaCAoYS5tZW1fdHlwZSkgewotICAg
ICAgIGNhc2UgSFZNTUVNX21taW9fZG06Ci0gICAgICAgICAgICAgICByYW0gPSAwOwotICAgICAg
ICAgICAgICAgYnJlYWs7Ci0gICAgICAgY2FzZSBIVk1NRU1fcmFtX3J3OgotICAgICAgIGNhc2Ug
SFZNTUVNX3JhbV9ybzoKLSAgICAgICBkZWZhdWx0OgotICAgICAgICAgICAgICAgcmFtID0gMTsK
LSAgICAgICAgICAgICAgIGJyZWFrOwotICAgICAgIH0KLQotICAgICAgIHJldHVybiByYW07Cisg
ICAgICAgSFlQRVJWSVNPUl9odm1fb3AoSFZNT1BfZ2V0X21lbV90eXBlLCAmYSk7CisgICAgICAg
cmV0dXJuIGEubWVtX3R5cGUgIT0gSFZNTUVNX21taW9fZG07CiAgfQogICNlbmRpZgoKCkFzc3Vt
aW5nIHRoYXQgaWYgSFlQRVJWSVNPUl9odm1fb3AoKSBmYWlscyB0aGF0Ci5tZW1fdHlwZSBpcyBu
b3Qgc2V0IHRvIEhWTU1FTV9tbWlvX2RtLgoKLS0gClRoYW5rcywKCkRhdmlkIC8gZGhpbGRlbmIK
CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwprZXhlYyBt
YWlsaW5nIGxpc3QKa2V4ZWNAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFk
ZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2tleGVjCg==
