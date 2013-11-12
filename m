Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from out1-smtp.messagingengine.com ([66.111.4.25])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Vg9KM-0007Kx-64
 for kexec@lists.infradead.org; Tue, 12 Nov 2013 08:28:03 +0000
Date: Tue, 12 Nov 2013 00:30:12 -0800
From: Greg KH <greg@kroah.com>
Subject: Re: [patch 1/3 v2] Add function get_bootparam
Message-ID: <20131112083012.GB7708@kroah.com>
References: <20131105082947.500512312@dhcp-16-126.nay.redhat.com>
 <20131105083428.411624560@dhcp-16-126.nay.redhat.com>
 <1384219658.1847.84.camel@misato.fc.hp.com>
 <52819E71.70201@zytor.com> <20131112075831.GA6213@kroah.com>
 <20131112080854.GD6999@dhcp-16-126.nay.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20131112080854.GD6999@dhcp-16-126.nay.redhat.com>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Dave Young <dyoung@redhat.com>
Cc: mjg59@srcf.ucam.org, linux-efi@vger.kernel.org, Toshi Kani <toshi.kani@hp.com>, x86@kernel.org, kexec@lists.infradead.org, James.Bottomley@HansenPartnership.com, horms@verge.net.au, bp@alien8.de, ebiederm@xmission.com, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@kernel.org>, vgoyal@redhat.com

T24gVHVlLCBOb3YgMTIsIDIwMTMgYXQgMDQ6MDg6NTRQTSArMDgwMCwgRGF2ZSBZb3VuZyB3cm90
ZToKPiBPbiAxMS8xMS8xMyBhdCAxMTo1OHBtLCBHcmVnIEtIIHdyb3RlOgo+ID4gPiBrZXhlYy10
b29scyBjYW4gaGF2ZSBhIGZhbGxiYWNrIHRvIGRlYnVnZnMgaWYgd2UgcmVhbGx5IG5lZWQgaXQs
IGJ1dAo+ID4gPiBtYWtpbmcgcGVvcGxlIG1vdW50IGRlYnVnZnMgdG8gaGF2ZSBzb21lIGVzc2Vu
dGlhbCBwaWVjZSBvZgo+ID4gPiBmdW5jdGlvbmFsaXR5IHNjYXJlcyB0aGUgaGVjayBvdXQgb2Yg
bWUuCj4gPiAKPiA+IEkgYWdyZWUsIHRoYXQgd291bGQgbm90IGJlIGdvb2QuCj4gPiAKPiA+IEkn
bSBub3Qgc3VyZSB3aGF0IGV4YWN0bHkgdGhlIHN5c2ZzIGZpbGUgaXMgd2FudGluZyB0byBsb29r
IGxpa2U/ICBUaGUKPiA+IGVmaSBzZWN0aW9uIHZhcmlhYmxlIHN5c2ZzIGZpbGUgaXNuJ3Qgb2sg
KG11bHRpcGxlIGxpbmVzIHdpdGggbXVsdGlwbGUKPiA+IHZhbHVlcy4pICBXaGF0IGlzIHRoaXMg
Z29pbmcgdG8gbG9vayBsaWtlPwo+IAo+IFRoZSBjdXJyZW50IHN0cnVjdHVyZSBpbiBkZWJ1Z2Zz
IGlzIGxpa2UgYmVsb3csIGV4cG9ydCBldmVyeSBmaWVsZCBvZiBzZXR1cAo+IGhlYWRlciBhcyBv
bmUgZmlsZSB3aWxsIGJlIHRvbyBtdWNoIElNSE86Cj4gW3Jvb3RAZGFya3N0YXIgZGVidWddIyB0
cmVlIGJvb3RfcGFyYW1zCj4gYm9vdF9wYXJhbXMKPiDilJzilIDilIAgZGF0YSAvKiBiaW5hcnkg
ZGF0YSBvZiBzZXR1cCBoZWFkZXIgKi8KPiDilJzilIDilIAgc2V0dXBfZGF0YSAvKiBzZXR1cF9k
YXRhIGxpbmsgbGlzdCBub2RlcyAqLwo+IOKUgsKgwqAg4pSc4pSA4pSAIDAKPiDilILCoMKgIOKU
gsKgwqAg4pSc4pSA4pSAIGRhdGEgLyogYmluYXJ5IGRhdGEgb2Ygc2V0dXAgZGF0YSAqLwo+IOKU
gsKgwqAg4pSCwqDCoCDilJTilIDilIAgdHlwZSAvKiB0eXBlIG9mIHNldHVwIGRhdGEgKi8KPiDi
lILCoMKgIOKUlOKUgOKUgCAxCj4g4pSCwqDCoCAgICAg4pSc4pSA4pSAIGRhdGEKPiDilILCoMKg
ICAgICDilJTilIDilIAgdHlwZQo+IOKUlOKUgOKUgCB2ZXJzaW9uIC8qIGJvb3QgcHJvdG9jb2wg
dmVyc2lvbiAqLwoKQW5kIHRoZXNlIGJpbmFyeSBkYXRhIGJsb2JzIGFyZSBhICJzdGFuZGFyZCIg
c29tZXdoZXJlLCBhbmQgd2lsbCBub3QKY2hhbmdlIHBlciBrZXJuZWwgdmVyc2lvbiBjaGFuZ2U/
CgpJZiBzbywgdGhhdCBzdHJ1Y3R1cmUgaXMgZmluZSB3aXRoIG1lLgoKdGhhbmtzLAoKZ3JlZyBr
LWgKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmtleGVj
IG1haWxpbmcgbGlzdAprZXhlY0BsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZy
YWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8va2V4ZWMK
