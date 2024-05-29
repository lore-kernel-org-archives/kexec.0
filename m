Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0730C27C43
	for <kexec@archiver.kernel.org>; Wed, 29 May 2024 15:16:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=lI3tfaClbWeP3MkR4QHVAM4R1CZ9AaqsXCE1R9YhdFg=; b=MOC8j+kqChBJa1
	3HtSeDMt6qMk3ARswMLfZZF/qaUYI59/Bi8IgflE4SVCQ4lrEZU5hZnufDQnxZ18/cn1iGOR/1Bzk
	Nnn3sp3g/PLsw9NRGT8JjYRsil77hYiN9OxWiSG7mxz+d+lNQD9fl/DbaOG6jh7phx9Y8zUlmmnHI
	xtXBNuGhiSLKXy3Uzbzpe6XhCBbySTRpgdFATxnka9VWsjMcPURVfXfn4huq++w+j76fHdIVYGqUJ
	35D4xvo6UvZMjVGv91EDiGleUxDCD8QTG6V78YWFlVs8jlnmqKF/wp4l8PwZ7QHSMmV/MjZaJY8Iu
	erXyQcw+W56Q5rret14g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sCL2R-00000004eKo-0UBe;
	Wed, 29 May 2024 15:16:27 +0000
Received: from mail.alien8.de ([2a01:4f9:3051:3f93::2])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sCL2N-00000004eFO-2gDh
	for kexec@lists.infradead.org;
	Wed, 29 May 2024 15:16:26 +0000
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 38D7840E01A3;
	Wed, 29 May 2024 15:16:11 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=fail (4096-bit key)
	reason="fail (body has been altered)" header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id NoOJQ2BFJLv9; Wed, 29 May 2024 15:16:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1716995765; bh=JxEAHhbyQDE99cyLseBirGgp8UILWOP5Nko9ahp4ykk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PdGuX3GdGiTa0UBwqDbqBBMWaahwz8CoKM8nSbk04nqa1vJJRShBdhSaMbJOBrOMS
	 Q2dU9SKv0i+u0By+NNXxoInoL89E8cB/UwRvQmEsbp0t9yeuptVk2+nMPiTa4YcVLS
	 CjhmDbntRtHeUoH0J/C5Payhj7MEEFDjwF6IvqT1PLULC38ho+iNxbpNPNVzkewdAn
	 psgdhkReuIkiERedkFSLAyGesfzLJ8F26P1AG+zP8BK+UOya9928tQ3UfRu8SjKw2V
	 P7sZOzs1ZlQk+rskHq2y7cEwA5kKlcGSFbIjdLoQXts0wDcNuVsJQm0tN1/dwbdkTe
	 yT8o9AeEw3ief09u3TvxcCEqgfh3D3iiUvUxBHDT+gHUolf0IK7jHToeQCiYz4mE57
	 DXSXJ6LCXNKvr16AW64LSuVZq1PUZLtjsPuJwLw3zb7H7wpkMI2K2/9zQwQEWDdQ0I
	 X0hCShNDcG3nur10QB3v3pIOER7veBEKaDBy1oOm8MK81qL16xr6HE20KLek5ES3DK
	 j2MCIyPKND/pZaSW2T8qfpkFydT2gl/95e+3hc9ThfFPyn0o3J4rbrit+6qSygYqb+
	 rkF9qhe71TCRmtWM4+jNZI1JKSQoJomFiEC6sNSBg4aDPLoLZivG2TqZWEsf0SxkKc
	 HvWFFqhKGF+2G/5xqStlY82I=
Received: from zn.tnic (p5de8ee85.dip0.t-ipconnect.de [93.232.238.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 73B3740E0177;
	Wed, 29 May 2024 15:15:37 +0000 (UTC)
Date: Wed, 29 May 2024 17:15:31 +0200
From: Borislav Petkov <bp@alien8.de>
To: Andrew Cooper <andrew.cooper3@citrix.com>,
	Nikolay Borisov <nik.borisov@suse.com>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Elena Reshetova <elena.reshetova@intel.com>,
	Jun Nakajima <jun.nakajima@intel.com>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	"Kalra, Ashish" <ashish.kalra@amd.com>,
	Sean Christopherson <seanjc@google.com>,
	"Huang, Kai" <kai.huang@intel.com>,
	Ard Biesheuvel <ardb@kernel.org>, Baoquan He <bhe@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>, kexec@lists.infradead.org,
	linux-hyperv@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv11 05/19] x86/relocate_kernel: Use named labels for less
 confusion
Message-ID: <20240529151531.GDZldGk5cBbyPrOBRP@fat_crate.local>
References: <20240528095522.509667-1-kirill.shutemov@linux.intel.com>
 <20240528095522.509667-6-kirill.shutemov@linux.intel.com>
 <1e1d1aea-7346-4022-9f5f-402d171adfda@suse.com>
 <t3zx4f6ynru7qp4oel4syza2alcuxz7q7hxqgf2lxusgobnsnh@vtnecqrsxci5>
 <20240529112852.GBZlcRdI3oqBtjKxAV@fat_crate.local>
 <55bc0649-c017-49ab-905d-212f140a403f@citrix.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <55bc0649-c017-49ab-905d-212f140a403f@citrix.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240529_081624_155896_C3EDBB92 
X-CRM114-Status: GOOD (  20.13  )
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
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
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

T24gV2VkLCBNYXkgMjksIDIwMjQgYXQgMDE6MzM6MzVQTSArMDEwMCwgQW5kcmV3IENvb3BlciB3
cm90ZToKPiBTZWVtcyBJJ3ZlIGdhaW5lZCBhIHJlcHV0YXRpb24uLi4KClllcyB5b3UgaGF2ZS4g
WW91IGhhdmUgdGhpcyB3ZWlyZCBpbnRlcmVzdCBpbiB2ZXJ5IGRlZXAgdWFyY2ggZGV0YWlscwp0
aGF0IEkgY2FuJ3Qgc2hhcmUuIE5vdCBhdCB0aGF0IGRldGFpbC4gOi1QCgo+IGptcCAxZiBkYXRl
cyBiYWNrIHRvIHllIG9sZGUgODA4Niwgd2hpY2ggc3RhcnRlZCB0aGUgd2hvbGUgdHJlbmQgb2Yg
dGhlCj4gaW5zdHJ1Y3Rpb24gcG9pbnRlciBqdXN0IGJlaW5nIGEgZmlnbWVudCBvZiB0aGUgSVNB
J3MgaW1hZ2luYXRpb25bMV0uCj4gCj4gSGFyZHdhcmUgbWFpbnRhaW5zIHRoZSBwb2ludGVyIHRv
IHRoZSBuZXh0IGJ5dGUgdG8gZmV0Y2ggKHRoZSBwcmVmZXRjaAo+IHF1ZXVlIHdhcyB1cCB0byA2
IGJ5dGVzKSwgYW5kIHRoZXJlIHdhcyBhIG1pY3JvLW9wIHRvIHN1YnRyYWN0IHRoZQo+IGN1cnJl
bnQgbGVuZ3RoIG9mIHRoZSBwcmVmZXRjaCBxdWV1ZSBmcm9tIHRoZSBhY2N1bXVsYXRvci4KPiAK
PiBJbiB0aG9zZSBkYXlzLCB0aGUgcHJlZmV0Y2ggcXVldWUgd2FzIG5vdCBjb2hlcmVudCB3aXRo
IG1haW4gbWVtb3J5LCBhbmQKPiBqdW1wcyAoYmVpbmcgYSBkaXNjb250aW51aXR5IGluIHRoZSBp
bnN0cnVjdGlvbiBzdHJlYW0pIHNpbXBseSBmbHVzaGVkCj4gdGhlIHByZWZldGNoIHF1ZXVlLgo+
IAo+IFRoaXMgd2FzIG5lY2Vzc2FyeSBhZnRlciBtb2RpZnlpbmcgZXhlY3V0YWJsZSBjb2RlLCBi
ZWNhdXNlIG90aGVyd2lzZQo+IHlvdSBjb3VsZCBlbmQgdXAgZXhlY3V0aW5nIHN0YWxlIGJ5dGVz
IGZyb20gdGhlIHByZWZldGNoIHF1ZXVlIGFuZCB0aGVuCj4gbm9uLXN0YWxlIGJ5dGVzIHRoZXJl
YWZ0ZXIuwqAgKE90aGVyd2lzZSBrbm93biBhcyB0aGUgd2F5IHRvIGRpc3Rpbmd1aXNoCj4gdGhl
IDgwODYgZnJvbSB0aGUgODA4OCBiZWNhdXNlIHRoZSBsYXR0ZXIgb25seSBoYWQgYSA0IGJ5dGUg
cHJlZmV0Y2ggcXVldWUuKQoKVGhhbmtzIC0gdGhhdCBjZXJ0YWlubHkgd2FrZXMgdXAgYSBsb25n
LWFzbGVlcCBuZXVyb24gaW4gdGhlIGJhY2sgb2YgbXkKbWluZC4uLgoKPiBBbnl3YXkuwqAgSXQn
cyBob3cgeW91IHVzZWQgdG8gc3BlbGwgInNlcmlhbGlzaW5nIG9wZXJhdGlvbiIgYmVmb3JlIHRo
YXQKPiB0ZXJtIGV2ZXIgZW50ZXJlZCB0aGUgYXJjaGl0ZWN0dXJlLsKgIExpbnV4IHN0aWxsIHN1
cHBvcnRzIENQVXMgcHJpb3IgdG8KPiB0aGUgUGVudGl1bSwgc28gc3RpbGwgbmVlZHMgdG8gY2Fy
ZSBhYm91dCBwcmVmZXRjaCBxdWV1ZXMgaW4gdGhlIDQ4Ni4KPiAKPiBIb3dldmVyLCB0aGlzIGV4
YW1wbGUgYXBwZWFycyB0byBiZSBpbiA2NGJpdCBjb2RlIGFuZCBmb2xsb3dpbmcgYSB3cml0ZQo+
IHRvIENSNCB3aGljaCB3aWxsIGJlIGZ1bGx5IHNlcmlhbGlzaW5nLCBzbyBpdCdzIHByb2JhYmx5
IGNvcHkmcGFzdGUgZnJvbQo+IDMyYml0IGNvZGUgd2hlcmUgaXQgd291bGQgYmUgbmVjZXNzYXJ5
IGluIHByaW5jaXBsZS4KCllhcCwgZnVsbHkgYWdyZWVkLiBXZSBjb3VsZCB0cnkgdG8gcmVtb3Zl
IGl0IGFuZCBzZWUgd2hhdCBjb21wbGFpbnMuCgpOaWtvbGF5LCB3YW5uYSBkbyBhIHBhdGNoIHdo
aWNoIHByb3Blcmx5IGV4cGxhaW5zIHRoZSBzaXR1YXRpb24/Cgo+IGh0dHBzOi8vd3d3LnJpZ2h0
by5jb20vMjAyMy8wMS9pbnNpZGUtODA4Ni1wcm9jZXNzb3JzLWluc3RydWN0aW9uLmh0bWwjZm46
cGMKPiAKPiBJbiBmYWN0LCBhbnlvbmUgd2hvIGhhc24ndCBzaG91bGQgcmVhZCB0aGUgZW50aXJl
IHNlcmllcyBvbiB0aGUgODA4NiwKPiBodHRwczovL3d3dy5yaWdodG8uY29tL3AvaW5kZXguaHRt
bAoKT2ggeWVhaCwgYWxyZWFkeSBib29rbWFya2VkLgoKVGhhbmtzIEFuZHkhCgotLSAKUmVnYXJk
cy9HcnVzcywKICAgIEJvcmlzLgoKaHR0cHM6Ly9wZW9wbGUua2VybmVsLm9yZy90Z2x4L25vdGVz
LWFib3V0LW5ldGlxdWV0dGUKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fCmtleGVjIG1haWxpbmcgbGlzdAprZXhlY0BsaXN0cy5pbmZyYWRlYWQub3JnCmh0
dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8va2V4ZWMK
