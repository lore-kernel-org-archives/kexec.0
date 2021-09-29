Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mVNxD-009Wj6-FT
 for kexec@lists.infradead.org; Wed, 29 Sep 2021 01:00:12 +0000
Subject: Re: [PATCH v1 2/8] x86/xen: simplify xen_oldmem_pfn_is_ram()
References: <20210928182258.12451-1-david@redhat.com>
 <20210928182258.12451-3-david@redhat.com>
From: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Message-ID: <4ab2f8c2-c3d5-30b3-a670-a8b38e218b6e@oracle.com>
Date: Tue, 28 Sep 2021 20:59:36 -0400
In-Reply-To: <20210928182258.12451-3-david@redhat.com>
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

Ck9uIDkvMjgvMjEgMjoyMiBQTSwgRGF2aWQgSGlsZGVuYnJhbmQgd3JvdGU6Cj4gTGV0J3Mgc2lt
cGxpZnkgcmV0dXJuIGhhbmRsaW5nLgo+Cj4gU2lnbmVkLW9mZi1ieTogRGF2aWQgSGlsZGVuYnJh
bmQgPGRhdmlkQHJlZGhhdC5jb20+Cj4gLS0tCj4gIGFyY2gveDg2L3hlbi9tbXVfaHZtLmMgfCAx
MSArKy0tLS0tLS0tLQo+ICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCA5IGRlbGV0
aW9ucygtKQo+Cj4gZGlmZiAtLWdpdCBhL2FyY2gveDg2L3hlbi9tbXVfaHZtLmMgYi9hcmNoL3g4
Ni94ZW4vbW11X2h2bS5jCj4gaW5kZXggYjI0MmQxZjRiNDI2Li5lYjYxNjIyZGY3NWIgMTAwNjQ0
Cj4gLS0tIGEvYXJjaC94ODYveGVuL21tdV9odm0uYwo+ICsrKyBiL2FyY2gveDg2L3hlbi9tbXVf
aHZtLmMKPiBAQCAtMjEsMjMgKzIxLDE2IEBAIHN0YXRpYyBpbnQgeGVuX29sZG1lbV9wZm5faXNf
cmFtKHVuc2lnbmVkIGxvbmcgcGZuKQo+ICAJCS5kb21pZCA9IERPTUlEX1NFTEYsCj4gIAkJLnBm
biA9IHBmbiwKPiAgCX07Cj4gLQlpbnQgcmFtOwo+ICAKPiAgCWlmIChIWVBFUlZJU09SX2h2bV9v
cChIVk1PUF9nZXRfbWVtX3R5cGUsICZhKSkKPiAgCQlyZXR1cm4gLUVOWElPOwo+ICAKPiAgCXN3
aXRjaCAoYS5tZW1fdHlwZSkgewo+ICAJY2FzZSBIVk1NRU1fbW1pb19kbToKPiAtCQlyYW0gPSAw
Owo+IC0JCWJyZWFrOwo+IC0JY2FzZSBIVk1NRU1fcmFtX3J3Ogo+IC0JY2FzZSBIVk1NRU1fcmFt
X3JvOgo+ICsJCXJldHVybiAwOwo+ICAJZGVmYXVsdDoKPiAtCQlyYW0gPSAxOwo+IC0JCWJyZWFr
Owo+ICsJCXJldHVybiAxOwo+ICAJfQo+IC0KPiAtCXJldHVybiByYW07Cj4gIH0KPiAgI2VuZGlm
Cj4gIAoKCkhvdyBhYm91dAoKwqDCoMKgIHJldHVybiBhLm1lbV90eXBlICE9IEhWTU1FTV9tbWlv
X2RtOwoKClJlc3VsdCBzaG91bGQgYmUgcHJvbW90ZWQgdG8gaW50IGFuZCB0aGlzIGhhcyBhZGRl
ZCBiZW5lZml0IG9mIG5vdCByZXF1aXJpbmcgY2hhbmdlcyBpbiBwYXRjaCA0LgoKCi1ib3JpcwoK
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmtleGVjIG1h
aWxpbmcgbGlzdAprZXhlY0BsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRl
YWQub3JnL21haWxtYW4vbGlzdGluZm8va2V4ZWMK
