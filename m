Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-dm6nam11on2057.outbound.protection.outlook.com
 ([40.107.223.57] helo=NAM11-DM6-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mDqKq-007aRL-3M
 for kexec@lists.infradead.org; Wed, 11 Aug 2021 15:40:07 +0000
Subject: Re: [PATCH 01/11] mm: Introduce a function to check for
 virtualization protection features
References: <cover.1627424773.git.thomas.lendacky@amd.com>
 <cbc875b1d2113225c2b44a2384d5b303d0453cf7.1627424774.git.thomas.lendacky@amd.com>
 <805946e3-5138-3565-65eb-3cb8ac6f0b3e@linux.intel.com>
From: Tom Lendacky <thomas.lendacky@amd.com>
Message-ID: <e7208040-9ccc-b2df-b2d3-a06ed793908b@amd.com>
Date: Wed, 11 Aug 2021 10:39:54 -0500
In-Reply-To: <805946e3-5138-3565-65eb-3cb8ac6f0b3e@linux.intel.com>
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
Cc: Borislav Petkov <bp@alien8.de>, Brijesh Singh <brijesh.singh@amd.com>, Joerg Roedel <joro@8bytes.org>, Andi Kleen <ak@linux.intel.com>, Tianyu Lan <Tianyu.Lan@microsoft.com>

T24gOC8xMS8yMSA5OjUzIEFNLCBLdXBwdXN3YW15LCBTYXRoeWFuYXJheWFuYW4gd3JvdGU6Cj4g
T24gNy8yNy8yMSAzOjI2IFBNLCBUb20gTGVuZGFja3kgd3JvdGU6Cj4+IGRpZmYgLS1naXQgYS9p
bmNsdWRlL2xpbnV4L3Byb3RlY3RlZF9ndWVzdC5oCj4+IGIvaW5jbHVkZS9saW51eC9wcm90ZWN0
ZWRfZ3Vlc3QuaAo+PiBuZXcgZmlsZSBtb2RlIDEwMDY0NAo+PiBpbmRleCAwMDAwMDAwMDAwMDAu
LmY4ZWQ3YjcyOTY3Ygo+PiAtLS0gL2Rldi9udWxsCj4+ICsrKyBiL2luY2x1ZGUvbGludXgvcHJv
dGVjdGVkX2d1ZXN0LmgKPj4gQEAgLTAsMCArMSwzMiBAQAo+PiArLyogU1BEWC1MaWNlbnNlLUlk
ZW50aWZpZXI6IEdQTC0yLjAtb25seSAqLwo+PiArLyoKPj4gKyAqIFByb3RlY3RlZCBHdWVzdCAo
YW5kIEhvc3QpIENhcGFiaWxpdHkgY2hlY2tzCj4+ICsgKgo+PiArICogQ29weXJpZ2h0IChDKSAy
MDIxIEFkdmFuY2VkIE1pY3JvIERldmljZXMsIEluYy4KPj4gKyAqCj4+ICsgKiBBdXRob3I6IFRv
bSBMZW5kYWNreTx0aG9tYXMubGVuZGFja3lAYW1kLmNvbT4KPj4gKyAqLwo+PiArCj4+ICsjaWZu
ZGVmIF9QUk9URUNURURfR1VFU1RfSAo+PiArI2RlZmluZSBfUFJPVEVDVEVEX0dVRVNUX0gKPj4g
Kwo+PiArI2lmbmRlZiBfX0FTU0VNQkxZX18KPiAKPiBDYW4geW91IGluY2x1ZGUgaGVhZGVycyBm
b3IgYm9vbCB0eXBlIGFuZCBmYWxzZSBkZWZpbml0aW9uPwoKQ2FuIGRvLgoKVGhhbmtzLApUb20K
Cj4gCj4gLS0tIGEvaW5jbHVkZS9saW51eC9wcm90ZWN0ZWRfZ3Vlc3QuaAo+ICsrKyBiL2luY2x1
ZGUvbGludXgvcHJvdGVjdGVkX2d1ZXN0LmgKPiBAQCAtMTIsNiArMTIsOSBAQAo+IAo+IMKgI2lm
bmRlZiBfX0FTU0VNQkxZX18KPiAKPiArI2luY2x1ZGUgPGxpbnV4L3R5cGVzLmg+Cj4gKyNpbmNs
dWRlIDxsaW51eC9zdGRkZWYuaD4KPiAKPiBPdGhlcndpc2UsIEkgc2VlIGZvbGxvd2luZyBlcnJv
cnMgaW4gbXVsdGktY29uZmlnIGF1dG8gdGVzdGluZy4KPiAKPiBpbmNsdWRlL2xpbnV4L3Byb3Rl
Y3RlZF9ndWVzdC5oOjQwOjE1OiBlcnJvcjogdW5rbm93biB0eXBlIG5hbWUgJ2Jvb2wnCj4gaW5j
bHVkZS9saW51eC9wcm90ZWN0ZWRfZ3Vlc3QuaDo0MDo2MzogZXJyb3I6ICdmYWxzZScgdW5kZWNs
YXJlZCAoZmlyc3QKPiB1c2UgaW4gdGhpcyBmdW5jdGkKPiAKCl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fCmtleGVjIG1haWxpbmcgbGlzdAprZXhlY0BsaXN0
cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGlu
Zm8va2V4ZWMK
