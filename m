Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mVVUi-00AYJE-T3
 for kexec@lists.infradead.org; Wed, 29 Sep 2021 09:03:18 +0000
Received: by mail-wr1-f70.google.com with SMTP id
 a10-20020a5d508a000000b00160723ce588so379536wrt.23
 for <kexec@lists.infradead.org>; Wed, 29 Sep 2021 02:03:11 -0700 (PDT)
Subject: Re: [PATCH v1 2/8] x86/xen: simplify xen_oldmem_pfn_is_ram()
From: David Hildenbrand <david@redhat.com>
References: <20210928182258.12451-1-david@redhat.com>
 <20210928182258.12451-3-david@redhat.com>
 <4ab2f8c2-c3d5-30b3-a670-a8b38e218b6e@oracle.com>
 <bfe72f46-9a0d-1a87-64bd-4b03999edd1e@redhat.com>
Message-ID: <e9a230f9-85cb-d4c1-8027-508b7c344d94@redhat.com>
Date: Wed, 29 Sep 2021 11:03:09 +0200
MIME-Version: 1.0
In-Reply-To: <bfe72f46-9a0d-1a87-64bd-4b03999edd1e@redhat.com>
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

T24gMjkuMDkuMjEgMTA6NDUsIERhdmlkIEhpbGRlbmJyYW5kIHdyb3RlOgo+Pgo+PiBIb3cgYWJv
dXQKPj4KPj4gICDCoMKgwqAgcmV0dXJuIGEubWVtX3R5cGUgIT0gSFZNTUVNX21taW9fZG07Cj4+
Cj4gCj4gSGEsIGhvdyBjb3VsZCBJIGhhdmUgbWlzc2VkIHRoYXQgOikKPiAKPj4KPj4gUmVzdWx0
IHNob3VsZCBiZSBwcm9tb3RlZCB0byBpbnQgYW5kIHRoaXMgaGFzIGFkZGVkIGJlbmVmaXQgb2Yg
bm90IHJlcXVpcmluZyBjaGFuZ2VzIGluIHBhdGNoIDQuCj4+Cj4gCj4gQ2FuIHdlIGdvIG9uZSBz
dGVwIGZ1cnRoZXIgYW5kIGRvCj4gCj4gCj4gQEAgLTIwLDI0ICsyMCwxMSBAQCBzdGF0aWMgaW50
IHhlbl9vbGRtZW1fcGZuX2lzX3JhbSh1bnNpZ25lZCBsb25nIHBmbikKPiAgICAgICAgICAgc3Ry
dWN0IHhlbl9odm1fZ2V0X21lbV90eXBlIGEgPSB7Cj4gICAgICAgICAgICAgICAgICAgLmRvbWlk
ID0gRE9NSURfU0VMRiwKPiAgICAgICAgICAgICAgICAgICAucGZuID0gcGZuLAo+ICsgICAgICAg
ICAgICAgICAubWVtX3R5cGUgPSBIVk1NRU1fcmFtX3J3LAo+ICAgICAgICAgICB9Owo+IC0gICAg
ICAgaW50IHJhbTsKPiAgICAKPiAtICAgICAgIGlmIChIWVBFUlZJU09SX2h2bV9vcChIVk1PUF9n
ZXRfbWVtX3R5cGUsICZhKSkKPiAtICAgICAgICAgICAgICAgcmV0dXJuIC1FTlhJTzsKPiAtCj4g
LSAgICAgICBzd2l0Y2ggKGEubWVtX3R5cGUpIHsKPiAtICAgICAgIGNhc2UgSFZNTUVNX21taW9f
ZG06Cj4gLSAgICAgICAgICAgICAgIHJhbSA9IDA7Cj4gLSAgICAgICAgICAgICAgIGJyZWFrOwo+
IC0gICAgICAgY2FzZSBIVk1NRU1fcmFtX3J3Ogo+IC0gICAgICAgY2FzZSBIVk1NRU1fcmFtX3Jv
Ogo+IC0gICAgICAgZGVmYXVsdDoKPiAtICAgICAgICAgICAgICAgcmFtID0gMTsKPiAtICAgICAg
ICAgICAgICAgYnJlYWs7Cj4gLSAgICAgICB9Cj4gLQo+IC0gICAgICAgcmV0dXJuIHJhbTsKPiAr
ICAgICAgIEhZUEVSVklTT1JfaHZtX29wKEhWTU9QX2dldF9tZW1fdHlwZSwgJmEpOwo+ICsgICAg
ICAgcmV0dXJuIGEubWVtX3R5cGUgIT0gSFZNTUVNX21taW9fZG07Cj4gICAgfQo+ICAgICNlbmRp
Zgo+IAo+IAo+IEFzc3VtaW5nIHRoYXQgaWYgSFlQRVJWSVNPUl9odm1fb3AoKSBmYWlscyB0aGF0
Cj4gLm1lbV90eXBlIGlzIG5vdCBzZXQgdG8gSFZNTUVNX21taW9fZG0uCj4gCgpPa2F5IHdlIGNh
bid0LCBkdWUgdG8gIl9fbXVzdF9jaGVjayIgLi4uCgotLSAKVGhhbmtzLAoKRGF2aWQgLyBkaGls
ZGVuYgoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmtl
eGVjIG1haWxpbmcgbGlzdAprZXhlY0BsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5p
bmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8va2V4ZWMK
