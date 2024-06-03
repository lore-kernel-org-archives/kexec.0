Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EC25C25B75
	for <kexec@archiver.kernel.org>; Mon,  3 Jun 2024 17:10:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=JfoZgwcbMPSXml14qyD/zbYKdidZWSy0my2FcUEZd4c=; b=ip4rKnAr6ukpc7
	dC/STARpoPHxcWAr+8s2AxGzFqUEBSDE4pfpvTQUfe2LFCo0Dd8RDxXxmHEXjVKiXGCO1Korh2FMq
	Tdvk3yJIogdy/aTYcaA/sD9jjyZwTQhSVta0ioynj98u/YB7iLBLRbdS2TLHp4qIppx6QtORXfmWp
	i9RjKifvEr96234KYDt7kwo0ughvlHxmOL8AhY5M7KMl01gbVaiGtIAjMzNG2vVTzktMbohy4Ndu4
	EWkPtkHEqDmc6IOiOCMJ/PagvvXaum7Ab89kqEn7LQuVbTSNiwczG95iN9cV90PKRDbBESKVmIzH7
	FYkwPriQOZQGRhZ7PhQA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sEBCs-0000000HSyE-1Dv5;
	Mon, 03 Jun 2024 17:10:50 +0000
Received: from mail.alien8.de ([2a01:4f9:3051:3f93::2])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sEBCo-0000000HSx7-2zNm
	for kexec@lists.infradead.org;
	Mon, 03 Jun 2024 17:10:49 +0000
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 7CEE240E016E;
	Mon,  3 Jun 2024 17:10:44 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=fail (4096-bit key)
	reason="fail (body has been altered)" header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id JCzJOiEVf_pe; Mon,  3 Jun 2024 17:10:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1717434640; bh=VZi4MOG3Bn2AbfCCHa5aneDrHuPFqyTpnVMCPDS33j0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YtpaGEgvCC5TvSU3Bq1/2vHn0QfDG78lWUt1tzTvTVNMX99QjUeyus6DhFCr/hp1j
	 DtkMxtsyU2aIUsIf7KH2azMibL1NEZLwqaqcjpASxLdReZghHOQBhsuHxMjpI99ACL
	 qW9ambyFZqg3X3gFZ8kbOaZdLSzSOp0KFMDk3x4yImpiOTdhEycZbfzJq3YPH4NrwJ
	 rrP0DiJlY8H8B4o0fb9GlIAUIMKQO5vwVZhSqD2lzto2qPblJ2GHbC7hV7WFdpYoA2
	 QIfxA0VBBa7R9YZITjUHCrrMZbtsLXKPYw4//tDCnIgImwWVsRU6vAC5OdUD2Y9Ski
	 gw/5rOOKhm9RQIgUEH215xXcp+T/SK6svY7IR2zauNVge30TBqerxNw2csqJva7eIZ
	 ex7jcawgdS/syMunzrSkkNP9AvtSAgRnp93uHsT83di+7tSrWVGGLkshsW4ma8AF4k
	 +faFscvzdD/XjyAPQ1bpAQZnSlejaV+yvdkZhqs39swlercy5tAnENdEEB6RTaFwDn
	 UzEj5qkezedhE+FRfkhIcMfii+a1uqaaipDdT9329ESLthnb8S44EpuuAfn7Miy8u/
	 nHZkhAIwGSd6hTJ1pWzTxzhwHFSpoVnDGwzvAzumDwfi+YydIFLVPUZSkxaj/Jh7kZ
	 KkIf4c45itL33ZSGObRabSh4=
Received: from zn.tnic (p5de8ee85.dip0.t-ipconnect.de [93.232.238.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 014BE40E016A;
	Mon,  3 Jun 2024 17:10:10 +0000 (UTC)
Date: Mon, 3 Jun 2024 19:10:10 +0200
From: Borislav Petkov <bp@alien8.de>
To: "Kalra, Ashish" <ashish.kalra@amd.com>
Cc: Mike Rapoport <rppt@kernel.org>, tglx@linutronix.de, mingo@redhat.com,
	dave.hansen@linux.intel.com, x86@kernel.org, rafael@kernel.org,
	hpa@zytor.com, peterz@infradead.org, adrian.hunter@intel.com,
	sathyanarayanan.kuppuswamy@linux.intel.com, jun.nakajima@intel.com,
	rick.p.edgecombe@intel.com, thomas.lendacky@amd.com,
	michael.roth@amd.com, seanjc@google.com, kai.huang@intel.com,
	bhe@redhat.com, kirill.shutemov@linux.intel.com, bdas@redhat.com,
	vkuznets@redhat.com, dionnaglaze@google.com, anisinha@redhat.com,
	jroedel@suse.de, ardb@kernel.org, kexec@lists.infradead.org,
	linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org,
	Dave Young <dyoung@redhat.com>
Subject: Re: [PATCH v7 1/3] efi/x86: Fix EFI memory map corruption with kexec
Message-ID: <20240603171010.GIZl348oNg7DtyV-cv@fat_crate.local>
References: <cover.1717111180.git.ashish.kalra@amd.com>
 <f4be03b8488665f56a1e5c6e6459f447352dfcf5.1717111180.git.ashish.kalra@amd.com>
 <20240603085654.GBZl2FVjPd-gagt-UA@fat_crate.local>
 <8e3dfc15-f609-4839-85c7-1cc8cefd7acc@amd.com>
 <Zl3HfiQ6oHdTdOdA@kernel.org>
 <1ef36309-8d7f-447b-a54a-3cdafeccca64@amd.com>
 <20240603144639.GCZl3XTwmFHwi-KUZW@fat_crate.local>
 <Zl3hwYL2GDiyUfGo@kernel.org>
 <7eb4ca99-679c-4f23-9562-a39b966c28a0@amd.com>
 <1d03466a-052c-4152-9dc4-0b72d95cde6d@amd.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1d03466a-052c-4152-9dc4-0b72d95cde6d@amd.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240603_101047_184918_D7AC539A 
X-CRM114-Status: UNSURE (   9.50  )
X-CRM114-Notice: Please train this message.
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

T24gTW9uLCBKdW4gMDMsIDIwMjQgYXQgMTI6MDU6NDVQTSAtMDUwMCwgS2FscmEsIEFzaGlzaCB3
cm90ZToKPiBSZS1zZW5kaW5nIHRoaXMsIGxhc3QgcmVzcG9uc2UgZ290IGdhcmJsZWQuCgpBbmQg
dGhpcyBnb3QgbGluZXdyYXBwZWQuCgpUaHVuZGVyYmlyZCBzZWN0aW9uIGluIERvY3VtZW50YXRp
b24vcHJvY2Vzcy9lbWFpbC1jbGllbnRzLnJzdC4KCj4gaW5kZXggZjBjYzAwMDMyNzUxLi42ZjM5
OGM1OTI3OGEgMTAwNjQ0Cj4gLS0tIGEvYXJjaC94ODYvcGxhdGZvcm0vZWZpL3F1aXJrcy5jCj4g
KysrIGIvYXJjaC94ODYvcGxhdGZvcm0vZWZpL3F1aXJrcy5jCj4gQEAgLTI1NSwxNSArMjU1LDM5
IEBAIHZvaWQgX19pbml0IGVmaV9hcmNoX21lbV9yZXNlcnZlKHBoeXNfYWRkcl90IGFkZHIsIHU2
NAo+IHNpemUpCgpeXl4KCj4gwqDCoMKgwqDCoMKgwqAgc3RydWN0IGVmaV9tZW1vcnlfbWFwX2Rh
dGEgZGF0YSA9IHsgMCB9Owo+IMKgwqDCoMKgwqDCoMKgIHN0cnVjdCBlZmlfbWVtX3JhbmdlIG1y
Owo+IMKgwqDCoMKgwqDCoMKgIGVmaV9tZW1vcnlfZGVzY190IG1kOwo+IC3CoMKgwqDCoMKgwqAg
aW50IG51bV9lbnRyaWVzOwo+ICvCoMKgwqDCoMKgwqAgaW50IG51bV9lbnRyaWVzLCByZXQ7Cj4g
wqDCoMKgwqDCoMKgwqAgdm9pZCAqbmV3Owo+IAo+IC3CoMKgwqDCoMKgwqAgaWYgKGVmaV9tZW1f
ZGVzY19sb29rdXAoYWRkciwgJm1kKSB8fAo+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoCBtZC50eXBl
ICE9IEVGSV9CT09UX1NFUlZJQ0VTX0RBVEEpIHsKPiArwqDCoMKgwqDCoMKgIC8qCj4gK8KgwqDC
oMKgwqDCoMKgICogZWZpX21lbV9yZXNlcnZlKCkgaXMgdXNlZCB0byByZXNlcnZlIGJvb3Qgc2Vy
dmljZSBtZW1vcnksIGVnLgo+IGJncnQsCgpeXl4KCi0tIApSZWdhcmRzL0dydXNzLAogICAgQm9y
aXMuCgpodHRwczovL3Blb3BsZS5rZXJuZWwub3JnL3RnbHgvbm90ZXMtYWJvdXQtbmV0aXF1ZXR0
ZQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18Ka2V4ZWMg
bWFpbGluZyBsaXN0CmtleGVjQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJh
ZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9rZXhlYwo=
