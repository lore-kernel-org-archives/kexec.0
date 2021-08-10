Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mga02.intel.com ([134.134.136.20])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mDY3h-004q9q-8a
 for kexec@lists.infradead.org; Tue, 10 Aug 2021 20:09:10 +0000
Subject: Re: [PATCH 07/11] treewide: Replace the use of mem_encrypt_active()
 with prot_guest_has()
References: <cover.1627424773.git.thomas.lendacky@amd.com>
 <029791b24c6412f9427cfe6ec598156c64395964.1627424774.git.thomas.lendacky@amd.com>
 <166f30d8-9abb-02de-70d8-6e97f44f85df@linux.intel.com>
 <4b885c52-f70a-147e-86bd-c71a8f4ef564@amd.com>
From: "Kuppuswamy, Sathyanarayanan"
 <sathyanarayanan.kuppuswamy@linux.intel.com>
Message-ID: <4f9effcb-055b-51ee-6722-c9f0cc1d8acf@linux.intel.com>
Date: Tue, 10 Aug 2021 13:09:02 -0700
MIME-Version: 1.0
In-Reply-To: <4b885c52-f70a-147e-86bd-c71a8f4ef564@amd.com>
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
To: Tom Lendacky <thomas.lendacky@amd.com>, linux-kernel@vger.kernel.org, x86@kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, iommu@lists.linux-foundation.org, kvm@vger.kernel.org, linux-efi@vger.kernel.org, platform-driver-x86@vger.kernel.org, linux-graphics-maintainer@vmware.com, amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, kexec@lists.infradead.org, linux-fsdevel@vger.kernel.org
Cc: Borislav Petkov <bp@alien8.de>, Brijesh Singh <brijesh.singh@amd.com>, Joerg Roedel <joro@8bytes.org>, Andi Kleen <ak@linux.intel.com>, Tianyu Lan <Tianyu.Lan@microsoft.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, Will Deacon <will@kernel.org>, Dave Young <dyoung@redhat.com>, Baoquan He <bhe@redhat.com>, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>

CgpPbiA4LzEwLzIxIDEyOjQ4IFBNLCBUb20gTGVuZGFja3kgd3JvdGU6Cj4gT24gOC8xMC8yMSAx
OjQ1IFBNLCBLdXBwdXN3YW15LCBTYXRoeWFuYXJheWFuYW4gd3JvdGU6Cj4+Cj4+Cj4+IE9uIDcv
MjcvMjEgMzoyNiBQTSwgVG9tIExlbmRhY2t5IHdyb3RlOgo+Pj4gZGlmZiAtLWdpdCBhL2FyY2gv
eDg2L2tlcm5lbC9oZWFkNjQuYyBiL2FyY2gveDg2L2tlcm5lbC9oZWFkNjQuYwo+Pj4gaW5kZXgg
ZGUwMTkwM2MzNzM1Li5jYWZlZDY0NTZkNDUgMTAwNjQ0Cj4+PiAtLS0gYS9hcmNoL3g4Ni9rZXJu
ZWwvaGVhZDY0LmMKPj4+ICsrKyBiL2FyY2gveDg2L2tlcm5lbC9oZWFkNjQuYwo+Pj4gQEAgLTE5
LDcgKzE5LDcgQEAKPj4+ICDCoCAjaW5jbHVkZSA8bGludXgvc3RhcnRfa2VybmVsLmg+Cj4+PiAg
wqAgI2luY2x1ZGUgPGxpbnV4L2lvLmg+Cj4+PiAgwqAgI2luY2x1ZGUgPGxpbnV4L21lbWJsb2Nr
Lmg+Cj4+PiAtI2luY2x1ZGUgPGxpbnV4L21lbV9lbmNyeXB0Lmg+Cj4+PiArI2luY2x1ZGUgPGxp
bnV4L3Byb3RlY3RlZF9ndWVzdC5oPgo+Pj4gIMKgICNpbmNsdWRlIDxsaW51eC9wZ3RhYmxlLmg+
Cj4+PiAgwqAgwqAgI2luY2x1ZGUgPGFzbS9wcm9jZXNzb3IuaD4KPj4+IEBAIC0yODUsNyArMjg1
LDcgQEAgdW5zaWduZWQgbG9uZyBfX2hlYWQgX19zdGFydHVwXzY0KHVuc2lnbmVkIGxvbmcKPj4+
IHBoeXNhZGRyLAo+Pj4gIMKgwqDCoMKgwqDCoCAqIHRoZXJlIGlzIG5vIG5lZWQgdG8gemVybyBp
dCBhZnRlciBjaGFuZ2luZyB0aGUgbWVtb3J5IGVuY3J5cHRpb24KPj4+ICDCoMKgwqDCoMKgwqAg
KiBhdHRyaWJ1dGUuCj4+PiAgwqDCoMKgwqDCoMKgICovCj4+PiAtwqDCoMKgIGlmIChtZW1fZW5j
cnlwdF9hY3RpdmUoKSkgewo+Pj4gK8KgwqDCoCBpZiAocHJvdF9ndWVzdF9oYXMoUEFUVFJfTUVN
X0VOQ1JZUFQpKSB7Cj4+PiAgwqDCoMKgwqDCoMKgwqDCoMKgIHZhZGRyID0gKHVuc2lnbmVkIGxv
bmcpX19zdGFydF9ic3NfZGVjcnlwdGVkOwo+Pj4gIMKgwqDCoMKgwqDCoMKgwqDCoCB2YWRkcl9l
bmQgPSAodW5zaWduZWQgbG9uZylfX2VuZF9ic3NfZGVjcnlwdGVkOwo+Pgo+Pgo+PiBTaW5jZSB0
aGlzIGNoYW5nZSBpcyBzcGVjaWZpYyB0byBBTUQsIGNhbiB5b3UgcmVwbGFjZSBQQVRUUl9NRU1f
RU5DUllQVCB3aXRoCj4+IHByb3RfZ3Vlc3RfaGFzKFBBVFRSX1NNRSkgfHwgcHJvdF9ndWVzdF9o
YXMoUEFUVFJfU0VWKS4gSXQgaXMgbm90IHVzZWQgaW4KPj4gVERYLgo+IAo+IFRoaXMgaXMgYSBk
aXJlY3QgcmVwbGFjZW1lbnQgZm9yIG5vdy4gSSB0aGluayB0aGUgY2hhbmdlIHlvdSdyZSByZXF1
ZXN0aW5nCj4gc2hvdWxkIGJlIGRvbmUgYXMgcGFydCBvZiB0aGUgVERYIHN1cHBvcnQgcGF0Y2hl
cyBzbyBpdCdzIGNsZWFyIHdoeSBpdCBpcwo+IGJlaW5nIGNoYW5nZWQuCgpPay4gSSB3aWxsIGlu
Y2x1ZGUgaXQgcGFydCBvZiBURFggY2hhbmdlcy4KCj4gCj4gQnV0LCB3b3VsZG4ndCBURFggc3Rp
bGwgbmVlZCB0byBkbyBzb21ldGhpbmcgd2l0aCB0aGlzIHNoYXJlZC91bmVuY3J5cHRlZAo+IGFy
ZWEsIHRob3VnaD8gT3Igc2luY2UgaXQgaXMgc2hhcmVkLCB0aGVyZSdzIGFjdHVhbGx5IG5vdGhp
bmcgeW91IG5lZWQgdG8KPiBkbyAodGhlIGJzcyBkZWNycHl0ZWQgc2VjdGlvbiBleGlzdHMgZXZl
biBpZiBDT05GSUdfQU1EX01FTV9FTkNSWVBUIGlzIG5vdAo+IGNvbmZpZ3VyZWQpPwoKS2lyaWxs
IGhhZCBhIHJlcXVpcmVtZW50IHRvIHR1cm4gb24gQ09ORklHX0FNRF9NRU1fRU5DUllQVCBmb3Ig
YWRkaW5nIGxhenkKYWNjZXB0IHN1cHBvcnQgaW4gVERYIGd1ZXN0IGtlcm5lbC4gS2lyaWxsLCBj
YW4geW91IGFkZCBkZXRhaWxzIGhlcmU/Cgo+IAo+IFRoYW5rcywKPiBUb20KPiAKPj4KCi0tIApT
YXRoeWFuYXJheWFuYW4gS3VwcHVzd2FteQpMaW51eCBLZXJuZWwgRGV2ZWxvcGVyCgpfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwprZXhlYyBtYWlsaW5nIGxp
c3QKa2V4ZWNAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9t
YWlsbWFuL2xpc3RpbmZvL2tleGVjCg==
