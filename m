Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD4E9D637CF
	for <kexec@archiver.kernel.org>; Thu, 14 Nov 2024 01:46:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=GX5tWlO4z00A5Sh4MYU94AmII/E6zwjkK9+T8SU7X6U=; b=FMUPBFCQdNBFYl
	Xdbvf+eQHxo6e2x1goJltv1VtmV+6HTi/dlY/nDuLoxLdV7aXmb/dYbWRxgRASkhnmxudQWuUHI3K
	snn92gBSXoaBjQVXCZ1vs23aakq7v/g7aUKDST9Q1EFMRy6+O6V37Qt0ca/KCoSsnbWA1u2dsJgwl
	9+4pEhoxM6y1sgudA1jAMLYrm48V95jW1DEIEYuxDdgVJMQPIm3r7jSSW9yGPcxnHUwpj3MX0XRGY
	XZz2OFApl55MevvX/SxoS3i+64nkq2jBz91DWanV8p8Aow98iBx8yNGslSPKkNo13BDCtYlBdaNUl
	VbNjNqG8Z3DK2EzmKG1w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tBOwZ-00000008SrP-1wmO;
	Thu, 14 Nov 2024 01:46:47 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tBOwW-00000008SpS-2Tps
	for kexec@lists.infradead.org;
	Thu, 14 Nov 2024 01:46:46 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 6D0865C5BF4;
	Thu, 14 Nov 2024 01:45:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6126C4CEC3;
	Thu, 14 Nov 2024 01:46:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731548803;
	bh=lx1rGQYtbHGSPS7VyhMeibitndHfkvrCdu82/io1N/k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Cr/IgF0y3KYraVhqfntkGwRtaMnJQIObndIC4zsYzorJinmIZnRFy3jdZCACUO12e
	 XFWldrR/eGPUUAkCZgxN+mOXQfS7+mmUqYBp9M8UHW+oVJngCZ1EKxp9O14MEVk+d0
	 HoG7arZaj978lzFv4/C2o3iF5j1rdaoVBb1VVloNFOxr1jjDGlQrK/OfRYBIYnDfHt
	 sfwI3PNX1kvz7jtQN9TVZPDLc7UixVf2ZiZSa8jzH3/uPMMWU+hWBnUR5P8rEd9isz
	 X2W/0Zf8utndDqJlpgThdc3FmNkqC2z9QUBtciwxATWbdbVcLK7se+m/Kn77K2IuNt
	 30iq/Gk/2BRLg==
Date: Wed, 13 Nov 2024 17:46:41 -0800
From: jpoimboe <jpoimboe@kernel.org>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Peter Zijlstra <peterz@infradead.org>, "H. Peter Anvin" <hpa@zytor.com>,
	kexec@lists.infradead.org, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Kai Huang <kai.huang@intel.com>,
	Nikolay Borisov <nik.borisov@suse.com>,
	linux-kernel@vger.kernel.org, Simon Horman <horms@kernel.org>
Subject: Re: [RFC PATCH 2/2] x86/kexec: Add data section to relocate_kernel
Message-ID: <20241114014641.pmpdpq7gsowadpqs@jpoimboe>
References: <1983c62c02b863f6d70198730dbb55a1ef7ceb9f.camel@infradead.org>
 <20241108052241.3972433-1-dwmw2@infradead.org>
 <20241108052241.3972433-2-dwmw2@infradead.org>
 <B26FDB75-D8F3-4D9C-9078-C536C461A7CF@zytor.com>
 <1e8f11982ad0754d8123c143a514969fa2a07c05.camel@infradead.org>
 <20241112101423.GO22801@noisy.programming.kicks-ass.net>
 <785f90158524228a32bc4c22bfb4425ceadb0197.camel@infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <785f90158524228a32bc4c22bfb4425ceadb0197.camel@infradead.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241113_174644_751371_D6C6E37C 
X-CRM114-Status: GOOD (  27.27  )
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

T24gVHVlLCBOb3YgMTIsIDIwMjQgYXQgMTA6NDU6MDVBTSArMDAwMCwgRGF2aWQgV29vZGhvdXNl
IHdyb3RlOgo+IE9uIFR1ZSwgMjAyNC0xMS0xMiBhdCAxMToxNCArMDEwMCwgUGV0ZXIgWmlqbHN0
cmEgd3JvdGU6Cj4gPiBPbiBUdWUsIE5vdiAxMiwgMjAyNCBhdCAwODo0NDozM0FNICswMDAwLCBE
YXZpZCBXb29kaG91c2Ugd3JvdGU6Cj4gPiA+IE9uIEZyaSwgMjAyNC0xMS0wOCBhdCAxMjoyNiAr
MDEwMCwgSC4gUGV0ZXIgQW52aW4gd3JvdGU6Cj4gPiA+ID4gCj4gPiA+ID4gPiAtLS0gYS9hcmNo
L3g4Ni9rZXJuZWwvdm1saW51eC5sZHMuUwo+ID4gPiA+ID4gKysrIGIvYXJjaC94ODYva2VybmVs
L3ZtbGludXgubGRzLlMKPiA+ID4gPiA+IEBAIC0xMDAsNyArMTAwLDcgQEAgY29uc3RfcGNwdV9o
b3QgPSBwY3B1X2hvdDsKPiA+ID4gPiA+IMKgwqDCoMKgwqDCoMKgwqAuID0gQUxJR04oUEFHRV9T
SVpFKTvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgXAo+ID4gPiA+ID4gwqDCoMKgwqDCoMKgwqDCoF9fcmVsb2NhdGVf
a2VybmVsX3N0YXJ0ID0gLjvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoFwKPiA+ID4gPiA+IMKgwqDCoMKgwqDCoMKgwqAqKC50ZXh0LnJlbG9j
YXRlX2tlcm5lbCk7wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqBcCj4gPiA+ID4gPiAtwqDCoMKgwqDCoMKgwqAqKC5yb2RhdGEucmVs
b2NhdGVfa2VybmVsKTvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgXAo+ID4gPiA+ID4gK8KgwqDCoMKgwqDCoMKgKiguZGF0YS5yZWxvY2F0
ZV9rZXJuZWwpO8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgXAo+ID4gCj4gPiBXaHkgYXJlIHdlIGhhdmluZyBkYXRhIGluIHRoZSBt
aWRkbGUgb2YgdGhlIHRleHQgc2VjdGlvbj8KPiAKPiBUaGlzIGlzIHRoZSByZWxvY2F0ZV9rZXJu
ZWwoKSBwYWdlLiBJdCdzIHRoZSBsYXN0IHRoaW5nIHRoZSBrZXJuZWwKPiBjYWxscyBvbiBrZXhl
Yy4KPiAKPiBUaGUga2VybmVsIGZpcnN0IHRha2VzIGEgKmNvcHkqIG9mIGl0IGFuZCBwbGFjZXMg
aXQgaW50byB0aGUgaWRlbnRpdHkKPiBtYXBwaW5nIHBhZ2UgdGFibGVzIHdoaWNoIGFyZSBzZXQg
dXAgZm9yIGtleGVjLgo+IAo+IFRoZSByZWxvY2F0ZV9rZXJuZWwoKSBmdW5jdGlvbiBpcyB0aGVu
IGNhbGxlZCBhdCBpdHMgKm9yaWdpbmFsKgo+IGxvY2F0aW9uIGluIHRoZSBrZXJuZWwgdGV4dC4g
QmVmb3JlIHJlbG9hZGluZyAlY3IzLCBpdCBzdG9yZXMgc29tZQo+IGluZm9ybWF0aW9uIHdoaWNo
IGlzIGdvaW5nIHRvIGJlY29tZSB1bmF2YWlsYWJsZSBpbnRvIGl0cyBvd24gcGFnZQo+IChjdXJy
ZW50bHkgdXNpbmcgYSBiaXQgb2YgYSBuYXN0eSBoYWNrIGJhc2VkIG9uIGEgaGFyZC1jb2RlZAo+
IEtFWEVDX0NPTlRST0xfQ09ERV9NQVhfU0laRSBiZWNhdXNlIHdlIGNhbid0IGp1c3QgdXNlIGRh
dGEgc3ltYm9sCj4gcmVmZXJlbmNlcykuCj4gCj4gVGhlbiBpdCByZWxvYWRzICVjcjMgYW5kIGp1
bXBzIHRvIHRoZSBpZGVudGl0eS1tYXBwZWQgY29weSBvZiBpdHNlbGYuCj4gCj4gQ291bGQgd2Ug
cHV0IC50ZXh0LnJlbG9jYXRlX2tlcm5lbCBhbmQgLmRhdGEucmVsb2NhdGVfa2VybmVsIHNvbWV3
aGVyZQo+ICpvdGhlciogdGhhbiB0aGUgbWFpbiBrZXJuZWwgdGV4dCBzZWdtZW50PyBQcm9iYWJs
eS4uLiBpdCB1c2UgdXNlCj4gYWx0ZXJuYXRpdmUgaW5zdHJ1Y3Rpb25zLCBidXQgd2UgY291bGQg
ZGVhbCB3aXRoIHRoYXQuIEFuZCBpZiB3ZSBjYWxsCj4gZnJvbSBtYWNoaW5lX2tleGVjKCkgZGly
ZWN0bHkgaW50byB0aGUgKmNvcHkqIChoYXZpbmcgbWFya2VkIGl0Cj4gZXhlY3V0YWJsZSksIG1h
eWJlLi4uPwoKSSBmZXRjaGVkIHlvdXIgYnJhbmNoIGFuZCBvbmx5IHNhdyBhICJSRVQgYmVmb3Jl
IFVOVFJBSU4iIHdhcm5pbmcsIGRpZAp5b3UgaGFwcGVuIHRvIGFscmVhZHkgZml4IHRoZSBvdGhl
ciB3YXJuaW5ncyB1cD8KClNvbWV0aGluZyBsaWtlIHRoZSBiZWxvdyBmaXhlcyB0aGUgd2Fybmlu
ZyBJIHNhdy4KClRob3VnaCwgbWF5YmUgaXQncyBiZXR0ZXIgdG8ganVzdCB0ZWxsIG9ianRvb2wg
dG8ga2VlcCBpdHMgcGF3cyBvZmYgb2YKdGhlIHByb2JsZW1hdGljIGZ1bmN0aW9ucyBieSB1c2Ug
b2YgdGhlIFNUQUNLX0ZSQU1FX05PTl9TVEFOREFSRCBtYWNybz8KVGhlbiB5b3UgY291bGQgZ2V0
IHJpZCBvZiBhbGwgdGhlIHVud2luZCBoaW50cyBhbmQgYW5ub3RhdGlvbnMuCgoKZGlmZiAtLWdp
dCBhL3Rvb2xzL29ianRvb2wvY2hlY2suYyBiL3Rvb2xzL29ianRvb2wvY2hlY2suYwppbmRleCA2
NjA0ZjVkMDM4YWEuLjliYTEwNTMwYjljNyAxMDA2NDQKLS0tIGEvdG9vbHMvb2JqdG9vbC9jaGVj
ay5jCisrKyBiL3Rvb2xzL29ianRvb2wvY2hlY2suYwpAQCAtNDAxMiw4ICs0MDEyLDExIEBAIHN0
YXRpYyBpbnQgdmFsaWRhdGVfdW5yZXQoc3RydWN0IG9ianRvb2xfZmlsZSAqZmlsZSwgc3RydWN0
IGluc3RydWN0aW9uICppbnNuKQogCQkJcmV0dXJuIDA7CiAKIAkJY2FzZSBJTlNOX1JFVFVSTjoK
LQkJCVdBUk5fSU5TTihpbnNuLCAiUkVUIGJlZm9yZSBVTlRSQUlOIik7Ci0JCQlyZXR1cm4gMTsK
KwkJCWlmICghaW5zbi0+cmV0cG9saW5lX3NhZmUpIHsKKwkJCQlXQVJOX0lOU04oaW5zbiwgIlJF
VCBiZWZvcmUgVU5UUkFJTiIpOworCQkJCXJldHVybiAxOworCQkJfQorCQkJYnJlYWs7CiAKIAkJ
Y2FzZSBJTlNOX05PUDoKIAkJCWlmIChpbnNuLT5yZXRwb2xpbmVfc2FmZSkKCgpfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwprZXhlYyBtYWlsaW5nIGxpc3QK
a2V4ZWNAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWls
bWFuL2xpc3RpbmZvL2tleGVjCg==
