Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-bn8nam11on2068.outbound.protection.outlook.com
 ([40.107.236.68] helo=NAM11-BN8-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mDXkF-004pGL-Gl
 for kexec@lists.infradead.org; Tue, 10 Aug 2021 19:49:07 +0000
Subject: Re: [PATCH 07/11] treewide: Replace the use of mem_encrypt_active()
 with prot_guest_has()
References: <cover.1627424773.git.thomas.lendacky@amd.com>
 <029791b24c6412f9427cfe6ec598156c64395964.1627424774.git.thomas.lendacky@amd.com>
 <166f30d8-9abb-02de-70d8-6e97f44f85df@linux.intel.com>
From: Tom Lendacky <thomas.lendacky@amd.com>
Message-ID: <4b885c52-f70a-147e-86bd-c71a8f4ef564@amd.com>
Date: Tue, 10 Aug 2021 14:48:54 -0500
In-Reply-To: <166f30d8-9abb-02de-70d8-6e97f44f85df@linux.intel.com>
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
To: "Kuppuswamy, Sathyanarayanan" <sathyanarayanan.kuppuswamy@linux.intel.com>, linux-kernel@vger.kernel.org, x86@kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, iommu@lists.linux-foundation.org, kvm@vger.kernel.org, linux-efi@vger.kernel.org, platform-driver-x86@vger.kernel.org, linux-graphics-maintainer@vmware.com, amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, kexec@lists.infradead.org, linux-fsdevel@vger.kernel.org
Cc: Borislav Petkov <bp@alien8.de>, Brijesh Singh <brijesh.singh@amd.com>, Joerg Roedel <joro@8bytes.org>, Andi Kleen <ak@linux.intel.com>, Tianyu Lan <Tianyu.Lan@microsoft.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, Will Deacon <will@kernel.org>, Dave Young <dyoung@redhat.com>, Baoquan He <bhe@redhat.com>

T24gOC8xMC8yMSAxOjQ1IFBNLCBLdXBwdXN3YW15LCBTYXRoeWFuYXJheWFuYW4gd3JvdGU6Cj4g
Cj4gCj4gT24gNy8yNy8yMSAzOjI2IFBNLCBUb20gTGVuZGFja3kgd3JvdGU6Cj4+IGRpZmYgLS1n
aXQgYS9hcmNoL3g4Ni9rZXJuZWwvaGVhZDY0LmMgYi9hcmNoL3g4Ni9rZXJuZWwvaGVhZDY0LmMK
Pj4gaW5kZXggZGUwMTkwM2MzNzM1Li5jYWZlZDY0NTZkNDUgMTAwNjQ0Cj4+IC0tLSBhL2FyY2gv
eDg2L2tlcm5lbC9oZWFkNjQuYwo+PiArKysgYi9hcmNoL3g4Ni9rZXJuZWwvaGVhZDY0LmMKPj4g
QEAgLTE5LDcgKzE5LDcgQEAKPj4gwqAgI2luY2x1ZGUgPGxpbnV4L3N0YXJ0X2tlcm5lbC5oPgo+
PiDCoCAjaW5jbHVkZSA8bGludXgvaW8uaD4KPj4gwqAgI2luY2x1ZGUgPGxpbnV4L21lbWJsb2Nr
Lmg+Cj4+IC0jaW5jbHVkZSA8bGludXgvbWVtX2VuY3J5cHQuaD4KPj4gKyNpbmNsdWRlIDxsaW51
eC9wcm90ZWN0ZWRfZ3Vlc3QuaD4KPj4gwqAgI2luY2x1ZGUgPGxpbnV4L3BndGFibGUuaD4KPj4g
wqAgwqAgI2luY2x1ZGUgPGFzbS9wcm9jZXNzb3IuaD4KPj4gQEAgLTI4NSw3ICsyODUsNyBAQCB1
bnNpZ25lZCBsb25nIF9faGVhZCBfX3N0YXJ0dXBfNjQodW5zaWduZWQgbG9uZwo+PiBwaHlzYWRk
ciwKPj4gwqDCoMKgwqDCoMKgICogdGhlcmUgaXMgbm8gbmVlZCB0byB6ZXJvIGl0IGFmdGVyIGNo
YW5naW5nIHRoZSBtZW1vcnkgZW5jcnlwdGlvbgo+PiDCoMKgwqDCoMKgwqAgKiBhdHRyaWJ1dGUu
Cj4+IMKgwqDCoMKgwqDCoCAqLwo+PiAtwqDCoMKgIGlmIChtZW1fZW5jcnlwdF9hY3RpdmUoKSkg
ewo+PiArwqDCoMKgIGlmIChwcm90X2d1ZXN0X2hhcyhQQVRUUl9NRU1fRU5DUllQVCkpIHsKPj4g
wqDCoMKgwqDCoMKgwqDCoMKgIHZhZGRyID0gKHVuc2lnbmVkIGxvbmcpX19zdGFydF9ic3NfZGVj
cnlwdGVkOwo+PiDCoMKgwqDCoMKgwqDCoMKgwqAgdmFkZHJfZW5kID0gKHVuc2lnbmVkIGxvbmcp
X19lbmRfYnNzX2RlY3J5cHRlZDsKPiAKPiAKPiBTaW5jZSB0aGlzIGNoYW5nZSBpcyBzcGVjaWZp
YyB0byBBTUQsIGNhbiB5b3UgcmVwbGFjZSBQQVRUUl9NRU1fRU5DUllQVCB3aXRoCj4gcHJvdF9n
dWVzdF9oYXMoUEFUVFJfU01FKSB8fCBwcm90X2d1ZXN0X2hhcyhQQVRUUl9TRVYpLiBJdCBpcyBu
b3QgdXNlZCBpbgo+IFREWC4KClRoaXMgaXMgYSBkaXJlY3QgcmVwbGFjZW1lbnQgZm9yIG5vdy4g
SSB0aGluayB0aGUgY2hhbmdlIHlvdSdyZSByZXF1ZXN0aW5nCnNob3VsZCBiZSBkb25lIGFzIHBh
cnQgb2YgdGhlIFREWCBzdXBwb3J0IHBhdGNoZXMgc28gaXQncyBjbGVhciB3aHkgaXQgaXMKYmVp
bmcgY2hhbmdlZC4KCkJ1dCwgd291bGRuJ3QgVERYIHN0aWxsIG5lZWQgdG8gZG8gc29tZXRoaW5n
IHdpdGggdGhpcyBzaGFyZWQvdW5lbmNyeXB0ZWQKYXJlYSwgdGhvdWdoPyBPciBzaW5jZSBpdCBp
cyBzaGFyZWQsIHRoZXJlJ3MgYWN0dWFsbHkgbm90aGluZyB5b3UgbmVlZCB0bwpkbyAodGhlIGJz
cyBkZWNycHl0ZWQgc2VjdGlvbiBleGlzdHMgZXZlbiBpZiBDT05GSUdfQU1EX01FTV9FTkNSWVBU
IGlzIG5vdApjb25maWd1cmVkKT8KClRoYW5rcywKVG9tCgo+IAoKX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18Ka2V4ZWMgbWFpbGluZyBsaXN0CmtleGVjQGxp
c3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0
aW5mby9rZXhlYwo=
