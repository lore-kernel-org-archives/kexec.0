Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from pegase2.c-s.fr ([93.17.235.10])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mQYYd-009dJh-IC
 for kexec@lists.infradead.org; Wed, 15 Sep 2021 17:18:53 +0000
Subject: Re: [PATCH v3 4/8] powerpc/pseries/svm: Add a powerpc version of
 cc_platform_has()
References: <cover.1631141919.git.thomas.lendacky@amd.com>
 <9d4fc3f8ea7b325aaa1879beab1286876f45d450.1631141919.git.thomas.lendacky@amd.com>
 <YUCOTIPPsJJpLO/d@zn.tnic> <87lf3yk7g4.fsf@mpe.ellerman.id.au>
 <YUHGDbtiGrDz5+NS@zn.tnic>
From: Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <f8388f18-5e90-5d0f-d681-0b17f8307dd4@csgroup.eu>
Date: Wed, 15 Sep 2021 19:18:34 +0200
MIME-Version: 1.0
In-Reply-To: <YUHGDbtiGrDz5+NS@zn.tnic>
Content-Language: fr-FR
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
To: Borislav Petkov <bp@alien8.de>, Michael Ellerman <mpe@ellerman.id.au>
Cc: Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>, linux-efi@vger.kernel.org, Brijesh Singh <brijesh.singh@amd.com>, kvm@vger.kernel.org, dri-devel@lists.freedesktop.org, platform-driver-x86@vger.kernel.org, Paul Mackerras <paulus@samba.org>, linux-s390@vger.kernel.org, Andi Kleen <ak@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, x86@kernel.org, amd-gfx@lists.freedesktop.org, Christoph Hellwig <hch@infradead.org>, linux-graphics-maintainer@vmware.com, Tom Lendacky <thomas.lendacky@amd.com>, Tianyu Lan <Tianyu.Lan@microsoft.com>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org

CgpMZSAxNS8wOS8yMDIxIMOgIDEyOjA4LCBCb3Jpc2xhdiBQZXRrb3YgYSDDqWNyaXTCoDoKPiBP
biBXZWQsIFNlcCAxNSwgMjAyMSBhdCAxMDoyODo1OUFNICsxMDAwLCBNaWNoYWVsIEVsbGVybWFu
IHdyb3RlOgo+PiBJIGRvbid0IGxvdmUgaXQsIGEgbmV3IEMgZmlsZSBhbmQgYW4gb3V0LW9mLWxp
bmUgY2FsbCB0byB0aGVuIGNhbGwgYmFjawo+PiB0byBhIHN0YXRpYyBpbmxpbmUgdGhhdCBmb3Ig
bW9zdCBjb25maWd1cmF0aW9uIHdpbGwgcmV0dXJuIGZhbHNlIC4uLiBidXQKPj4gd2hhdGV2ZXIg
OikKPiAKPiBZZWFoLCBoY2ggdGhpbmtzIGl0J2xsIGNhdXNlIGEgYmlnIG1lc3Mgb3RoZXJ3aXNl
Ogo+IAo+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xrbWwvWVNTY1d2cFhlVlh3JTJGZWQ1QGlu
ZnJhZGVhZC5vcmcvCgpDb3VsZCB5b3UgcGxlYXNlIHByb3ZpZGUgbW9yZSBleHBsaWNpdCBleHBs
YW5hdGlvbiB3aHkgaW5saW5pbmcgc3VjaCBhbiAKaGVscGVyIGlzIGNvbnNpZGVyZWQgYXMgYmFk
IHByYWN0aWNlIGFuZCBtZXNzeSA/CgpCZWNhdXNlIGFzIGRlbW9uc3RyYXRlZCBpbiBteSBwcmV2
aW91cyByZXNwb25zZSBzb21lIGRheXMgYWdvLCB0YWtpbmcgCnRoYXQgb3V0bGluZSBlbmRzIHVw
IHdpdGggYW4gdW5uZWNjZXNzYXJ5IHVnbHkgZ2VuZXJhdGVkIGNvZGUgYW5kIHdlIApkb24ndCBi
ZW5lZml0IGZyb250IEdDQydzIGNhcGFiaWxpdHkgdG8gZm9sZCBpbiBhbmQgb3B0IG91dCB1bnJl
YWNoYWJsZSAKY29kZS4KCkFzIHBvaW50ZWQgYnkgTWljaGFlbCBpbiBtb3N0IGNhc2VzIHRoZSBm
dW5jdGlvbiB3aWxsIGp1c3QgcmV0dXJuIGZhbHNlIApzbyBiZWhpbmQgdGhlIHBlcmZvcm1hbmNl
IGNvbmNlcm4sIHRoZXJlIGlzIGFsc28gdGhlIGNvZGUgc2l6ZSBhbmQgY29kZSAKY292ZXJhZ2Ug
dG9waWMgdGhhdCBpcyB0byBiZSB0YWtlbiBpbnRvIGFjY291bnQuIEFuZCBldmVuIHdoZW4gdGhl
IApmdW5jdGlvbiBkb2Vzbid0IHJldHVybiBmYWxzZSwgdGhlIG9ubHkgdGhpbmcgaXQgZG9lcyBm
b2xkcyBpbnRvIGEgCnNpbmdsZSBwb3dlcnBjIGluc3RydWN0aW9uIHNvIHRoZXJlIGlzIHJlYWxs
eSBubyBwb2ludCBpbiBtYWtpbmcgYSAKZGVkaWNhdGVkIG91dC1vZi1saW5lIGZvbmN0aW9uIGZv
ciB0aGF0IGFuZCBzdWZmZXIgdGhlIGNvc3QgYW5kIHRoZSBzaXplIApvZiBhIGZ1bmN0aW9uIGNh
bGwgYW5kIHRvIGp1c3RpZnkgdGhlIGFkZGl0aW9uIG9mIGEgZGVkaWNhdGVkIEMgZmlsZS4KCgo+
IAo+IEkgZ3Vlc3MgbGVzcyBpZmRlZmZlcnkgaXMgbmljZSB0b28uCgpJIGNhbid0IHNlZSB5b3Vy
IHBvaW50IGhlcmUuIElubGluaW5nIHRoZSBmdW5jdGlvbiB3b3VsZG4ndCBhZGQgYW55IAppZmRl
ZmZlcnkgYXMgZmFyIGFzIEkgY2FuIHNlZS4KClNvLCB3b3VsZCB5b3UgbWluZCByZWNvbnNpZGVy
aW5nIHlvdXIgYXBwcm9hY2ggYW5kIGFsbG93IGFyY2hpdGVjdHVyZXMgCnRvIHByb3ZpZGUgaW5s
aW5lIGltcGxlbWVudGF0aW9uIGJ5IGp1c3Qgbm90IGVuZm9yY2luZyBhIGdlbmVyaWMgCnByb3Rv
dHlwZSA/IE9yIG90aGVyd2lzZSBwcm92aWRlIG1vcmUgZGV0YWlscyBhbmQgZXhlbXBsZSBvZiB3
aHkgdGhlIApjb25zIGFyZSBtb3JlIGltcG9ydGFudCB2ZXJzdXMgdGhlIHByb3MgPwoKVGhhbmtz
CkNocmlzdG9waGUKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fCmtleGVjIG1haWxpbmcgbGlzdAprZXhlY0BsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9s
aXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8va2V4ZWMK
