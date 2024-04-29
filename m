Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C442C4345F
	for <kexec@archiver.kernel.org>; Mon, 29 Apr 2024 14:29:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=qfrs/OnYM7l1zLyA/C4tUOc3T+ObBtgVgl4KRWeegAw=; b=aAzmzGxLUzFyzg
	t4Zc7XeVMwUbr7ZkEiWGqyc9b55nKTNXinKLWQzr5hM6qq7nXna4iVMm3Ii28K9ubQxXjpM41axmI
	oVP2Cqy8i27jQarDpZf29EbPwF7Tqnl8/O4aKDGuZNYpgkF9D7SFea7vPDSH84wmXhXz8chP70Ngy
	cmQ21fEHopkZh2eQ1fUYelrtbgfoGdrwqfmjt6kBAA2q+LzMnzFZIe15R/+XfGvq2rb++loHSsOQ4
	qkiTLUioWVdzDyrdZwycNFlC0bRq/4Ea3T9UNuiYpxqf1Xm5ulr6iPC+rkVYdelxrbablucRy5q8D
	atektrH1P1bVGpXpvD2g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s1S0c-000000037eh-3nVl;
	Mon, 29 Apr 2024 14:29:34 +0000
Received: from mgamail.intel.com ([198.175.65.18])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s1S0Z-000000037dg-3VIv
	for kexec@lists.infradead.org;
	Mon, 29 Apr 2024 14:29:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714400972; x=1745936972;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=lnmpDQnRv6ZNQZTqtUONOeLziTno1c2pGB56FVkEOEE=;
  b=cg29qHmpJxUhLcE/S2f8s+I+RTy3BN5/Up/6WFJV0ULB4xApKQhz2XuF
   iaP5teZYd5rnucwst2w+ok86df4Xqb9jzC8RKQW5/Rp5tjEC6j2rd5IsH
   3tod0+y/wWO11j9gM/6LrvNNu3n2gZex9O2BUDJONyzXjlGSKV20NdyFC
   S4vrMC0xvjwpMaSrOHRy0nveSLGuUcqSj3QB5ssMT3yQ0pN6uKmS8e0v6
   +ooZ9KoyYDmTXs3TG5qf9bTMxuVNu+rJKtUaXExwGp+2Jemv9O/ugw+T0
   D8aGrbsj9rlSjFUWrRcAH+06Rw7rpC15jLNzFdt68LLjCY9+saJEK1nJY
   g==;
X-CSE-ConnectionGUID: wIDx9ntoSgK2ed8oegudPA==
X-CSE-MsgGUID: JASOS4fATXCOeWkwYeOOow==
X-IronPort-AV: E=McAfee;i="6600,9927,11059"; a="10227697"
X-IronPort-AV: E=Sophos;i="6.07,239,1708416000"; 
   d="scan'208";a="10227697"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2024 07:29:31 -0700
X-CSE-ConnectionGUID: jCUPWXxUTdG7tdcGTA0h9w==
X-CSE-MsgGUID: vwoW0j5TRESQOwxzFM6Tuw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,239,1708416000"; 
   d="scan'208";a="57006944"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa002.jf.intel.com with ESMTP; 29 Apr 2024 07:29:25 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 82C161A0; Mon, 29 Apr 2024 17:29:23 +0300 (EEST)
Date: Mon, 29 Apr 2024 17:29:23 +0300
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Borislav Petkov <bp@alien8.de>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>, Elena Reshetova <elena.reshetova@intel.com>, 
	Jun Nakajima <jun.nakajima@intel.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, "Kalra, Ashish" <ashish.kalra@amd.com>, 
	Sean Christopherson <seanjc@google.com>, "Huang, Kai" <kai.huang@intel.com>, Baoquan He <bhe@redhat.com>, 
	kexec@lists.infradead.org, linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Dave Hansen <dave.hansen@intel.com>, Tao Liu <ltao@redhat.com>, 
	"K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, 
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, linux-hyperv@vger.kernel.org
Subject: Re: [PATCHv10 06/18] x86/mm: Make
 x86_platform.guest.enc_status_change_*() return errno
Message-ID: <xoksw5s5tl6wso4xirh4u422xmera4pyulptfmn3zeqtp5lmt2@d3y6ucap37da>
References: <20240409113010.465412-1-kirill.shutemov@linux.intel.com>
 <20240409113010.465412-7-kirill.shutemov@linux.intel.com>
 <20240428172557.GLZi6GpTaSBj-DphCL@fat_crate.local>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240428172557.GLZi6GpTaSBj-DphCL@fat_crate.local>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240429_072931_958658_9B0F71D0 
X-CRM114-Status: GOOD (  19.62  )
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

T24gU3VuLCBBcHIgMjgsIDIwMjQgYXQgMDc6MjU6NTdQTSArMDIwMCwgQm9yaXNsYXYgUGV0a292
IHdyb3RlOgo+IE9uIFR1ZSwgQXByIDA5LCAyMDI0IGF0IDAyOjI5OjU4UE0gKzAzMDAsIEtpcmls
bCBBLiBTaHV0ZW1vdiB3cm90ZToKPiA+IFREWCBpcyBnb2luZyB0byBoYXZlIG1vcmUgdGhhbiBv
bmUgcmVhc29uIHRvIGZhaWwKPiA+IGVuY19zdGF0dXNfY2hhbmdlX3ByZXBhcmUoKS4KPiA+IAo+
ID4gQ2hhbmdlIHRoZSBjYWxsYmFjayB0byByZXR1cm4gZXJybm8gaW5zdGVhZCBvZiBhc3N1bWlu
ZyAtRUlPOwo+ID4gZW5jX3N0YXR1c19jaGFuZ2VfZmluaXNoKCkgY2hhbmdlZCB0b28gdG8ga2Vl
cCB0aGUgaW50ZXJmYWNlIHN5bW1ldHJpYy4KPiAKPiAiQ2hhbmdlIGVuY19zdGF0dXNfY2hhbmdl
X2ZpbmlzaCgpIHRvby4uLiAiCj4gCj4gIkRlc2NyaWJlIHlvdXIgY2hhbmdlcyBpbiBpbXBlcmF0
aXZlIG1vb2QsIGUuZy4gIm1ha2UgeHl6enkgZG8gZnJvdHoiCj4gaW5zdGVhZCBvZiAiW1RoaXMg
cGF0Y2hdIG1ha2VzIHh5enp5IGRvIGZyb3R6IiBvciAiW0ldIGNoYW5nZWQgeHl6enkKPiB0byBk
byBmcm90eiIsIGFzIGlmIHlvdSBhcmUgZ2l2aW5nIG9yZGVycyB0byB0aGUgY29kZWJhc2UgdG8g
Y2hhbmdlCj4gaXRzIGJlaGF2aW91ci4iCgpIbS4gSSBjb25zaWRlcmVkIHRoZSBzZW50ZW5jZSB0
byBiZSBpbiBpbXBlcmF0aXZlIG1vb2QgYWxyZWFkeS4gSSBndWVzcyBJCmRvbid0IGZ1bGx5IHVu
ZGVyc3RhbmQgd2hhdCBpbXBlcmF0aXZlIG1vb2QgaXMuIFdpbGwgZml4LgoKPiA+IFNpZ25lZC1v
ZmYtYnk6IEtpcmlsbCBBLiBTaHV0ZW1vdiA8a2lyaWxsLnNodXRlbW92QGxpbnV4LmludGVsLmNv
bT4KPiA+IFJldmlld2VkLWJ5OiBEYXZlIEhhbnNlbiA8ZGF2ZS5oYW5zZW5AaW50ZWwuY29tPgo+
ID4gUmV2aWV3ZWQtYnk6IEthaSBIdWFuZyA8a2FpLmh1YW5nQGludGVsLmNvbT4KPiA+IFRlc3Rl
ZC1ieTogVGFvIExpdSA8bHRhb0ByZWRoYXQuY29tPgo+ID4gLS0tCj4gPiAgYXJjaC94ODYvY29j
by90ZHgvdGR4LmMgICAgICAgICB8IDIwICsrKysrKysrKysrLS0tLS0tLS0tCj4gPiAgYXJjaC94
ODYvaHlwZXJ2L2l2bS5jICAgICAgICAgICB8IDIyICsrKysrKysrKystLS0tLS0tLS0tLS0KPiA+
ICBhcmNoL3g4Ni9pbmNsdWRlL2FzbS94ODZfaW5pdC5oIHwgIDQgKystLQo+ID4gIGFyY2gveDg2
L2tlcm5lbC94ODZfaW5pdC5jICAgICAgfCAgNCArKy0tCj4gPiAgYXJjaC94ODYvbW0vbWVtX2Vu
Y3J5cHRfYW1kLmMgICB8ICA4ICsrKystLS0tCj4gPiAgYXJjaC94ODYvbW0vcGF0L3NldF9tZW1v
cnkuYyAgICB8ICA4ICsrKysrLS0tCj4gPiAgNiBmaWxlcyBjaGFuZ2VkLCAzNCBpbnNlcnRpb25z
KCspLCAzMiBkZWxldGlvbnMoLSkKPiAKPiBBbm90aGVyIHRoaW5nIHlvdSBzaG91bGQgbG9uZyBr
bm93IGJ5IG5vdzogZ2V0X21haW50YWluZXIucGwuIFlvdSBkbwo+IGtub3cgdGhhdCB3aGVuIHlv
dSBzZW5kIGEgcGF0Y2ggd2hpY2ggdG91Y2hlcyBtdWx0aXBsZSBkaWZmZXJlbnQKPiAicGxhY2Vz
IiwgeW91IHJ1biBpdCB0aHJvdWdoIGdldF9tYWludGFpbmVyLnBsIHRvIGdldCBzb21lIGhpbnRz
IGFzIHRvCj4gd2hvIHRvIENDLCByaWdodD8KCllvdSBhcmUgcmlnaHQsIEkgZGlkbid0IHJ1biBn
ZXRfbWFpbnRhaW5lci5wbCB0aGlzIHRpbWUuIEkgbmV2ZXIgZ290IGl0CmludGVncmF0ZWQgcHJv
cGVybHkgaW50byBteSB3b3JrZmxvdy4gSG93IGRvIHlvdSB1c2UgaXQ/IElzIGl0IHBhcnQgb2YK
J2dpdCBzZW5kLWVtYWlsJyBob29rcyBvciBkbyB5b3UgZG8gaXQgbWFudWFsbHkgc29tZWhvdy4K
CkkgZG9uJ3QgZmVlbCBJIGNhbiB0cnVzdCB0aGUgc2NyaXB0IHRvIGRvIFRoZSBSaWdodCBUaGlu
Z+KEoiBhbGwgdGhlIHRpbWUKdG8gcHV0IGludG8gbXkgaG9va3MuIEkgZXhwZWN0IGl0IHRvIGJs
b3cgdXAgb24gdHJlZS13aWRlIHBhdGNoZXMgZm9yCmluc3RhbmNlLgoKQXMgcmVzdWx0IEkgb25s
eSBydW4gaXQgb2NjYXNpb25hbGx5LCB3aGVuIEkgcmVtZW1iZXIgdG8gd2hpY2ggaXMKc3Vib3B0
aW1hbC4KCkFueSB0aXBzPwoKLS0gCiAgS2lyeWwgU2h1dHNlbWF1IC8gS2lyaWxsIEEuIFNodXRl
bW92CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwprZXhl
YyBtYWlsaW5nIGxpc3QKa2V4ZWNAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5m
cmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2tleGVjCg==
