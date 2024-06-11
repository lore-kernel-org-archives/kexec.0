Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EBD9C27C75
	for <kexec@archiver.kernel.org>; Tue, 11 Jun 2024 19:47:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=rid0KqkmocidyRI5h7OTIusSWw+KD9Y+QhEfeQcCNgs=; b=w1LrY8vI94+Obh
	4hXeMdfv1I7tFO7++F5RDzg4PEhgSUaUcm+HQ6HvmLjsdIm3pYnlh9MwCuYB9bg7S73qoG/6iWgzh
	498tjyHcGzuiAX/Wo1R1KTy+jONZ8SvBuGifYB6qhChUxqq7csTdKLjGsUdCxpJj0TpGwL5vc0ys0
	tlDCvFHeOJn05ZUBimS2R/Lw/RyXdXkRsqmiVzDICZZ6kRJiScIOyRnSaqA3z/gNJexuJzMSKTHv4
	vkaamWKuslXxV2jlfRYArlj6OVJdkAMyPbz4tpCuAubLcZv5WKQUxyrG/hfefaR+RnLUwhM6fxAL1
	+tuy+a0dgYUT5IheIPBQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sH7T0-0000000A4Mi-22Gl;
	Tue, 11 Jun 2024 19:47:38 +0000
Received: from mail.alien8.de ([2a01:4f9:3051:3f93::2])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sH7Sx-0000000A4KY-1mlJ
	for kexec@lists.infradead.org;
	Tue, 11 Jun 2024 19:47:37 +0000
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 4ABFD40E016E;
	Tue, 11 Jun 2024 19:47:31 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 7egZOOhYrnUo; Tue, 11 Jun 2024 19:47:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1718135247; bh=KC/Wq1TdqELiVMasu/6IhWJ5RKEy2WZabJ1TgN7EDpo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gZjVbghDzG0nP5cUPybv4xjwXUw/XCKD2xi82Zv94c+xqXlSD2qHLWA4ec+ncBc9A
	 /a1LbzPD4bLO4EEN+CZY0NKOfHQcj1PykJZpMpMtxZEEOLM67AkxoxXoXosQ9lZlna
	 n7Nmi4ZPJGPeJs8K8LXnGz5e87NPVyAFi/gcG6STb1244NJSEKC7RqhedZN5nkS4Sy
	 /1yrO2GhIB+OjkfoTp0Jr+TB0qblLFXFBW+G8xnDCwMwPS1xtl4ZfIDiYfbfIwPCwq
	 HGCaTWzWkwQL2y7YyBWx6sM+HiiMq5xtYbL9BaOrv73UP3014pZLRW9Clf13aqUkNB
	 C8aX9ijV3RVLiLTdDlnp8Oapk+TFfOVcFewxvRyJpkpM4wmlMsWUwp+lZWPuLot5hm
	 2ttdOPqCnCNqZG+Z7gmSdGZA3LZ1VtpyumKmA3/zTqSpse2Sy4OWv96IySCJ7gCP0A
	 0ytFhs8/2PQce2RpYFem1c7BlZIAzvMeTr5lDdAusNnYS2qDbwouFUUyVLcfOFdQk4
	 XTgYvmOwdub7dCaPBGoiIrg294eaJ5nrLZ0/bKBf0m69dTyc0zoDe5URK34OLqCh58
	 5gpieItixDx5YAcr6EowJ4PnUifObwQoY8BAFo4X0/JYOs7rG3nPSPUm7XE4dYkEAv
	 zipMkDI2v+o+y2TApZy/pnJg=
Received: from zn.tnic (p5de8ee85.dip0.t-ipconnect.de [93.232.238.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 5670640E0031;
	Tue, 11 Jun 2024 19:47:00 +0000 (UTC)
Date: Tue, 11 Jun 2024 21:46:53 +0200
From: Borislav Petkov <bp@alien8.de>
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
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
	linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org,
	Tao Liu <ltao@redhat.com>
Subject: Re: [PATCHv11 18/19] x86/acpi: Add support for CPU offlining for
 ACPI MADT wakeup method
Message-ID: <20240611194653.GGZmiprSNzK0JSJL17@fat_crate.local>
References: <20240528095522.509667-1-kirill.shutemov@linux.intel.com>
 <20240528095522.509667-19-kirill.shutemov@linux.intel.com>
 <20240603083930.GNZl2BQk2lQ8WtcE4o@fat_crate.local>
 <icu4yecqfwhmbexupo4zzei4lbe5sgavsfkm27jd6t6gyjynul@c2wap3jhtik7>
 <20240610134020.GCZmcCRFxuObyv1W_d@fat_crate.local>
 <hidvykk3yan5rtlhum6go7j3lwgrcfcgxlwyjug3osfakw2x6f@4ohvo23zaesv>
 <nh7cihzlsjtoddtec6m62biqdn62k3ka5svs6m64qekhpebu5z@dkplwad2urgp>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <nh7cihzlsjtoddtec6m62biqdn62k3ka5svs6m64qekhpebu5z@dkplwad2urgp>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240611_124735_647560_9D9DF8B5 
X-CRM114-Status: GOOD (  11.92  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

On Tue, Jun 11, 2024 at 06:47:05PM +0300, Kirill A. Shutemov wrote:
> Borislav, given this code deduplication effort is not trivial, maybe we
> can do it as a separate patchset on top of this one?

Sure, as long as it gets done and doesn't get delayed indefinitely by
new and more important features enablement.

Usually, we do unifications and cleanups first - then new features but
this kexec pile has been long in the making already...

> I also wounder if it makes sense to combine ident_map.c and
> set_memory.c.  There's some overlap between the two.

Yeah, we have a bunch of different pagetable manipulating things, all
with their peculiarities and unifying them and having a good set of APIs
which everything else uses, is always a good thing.

And since we're talking cleanups, there's another thing I've been
looking at critically: CONFIG_X86_5LEVEL. Maybe it is time to get rid of
it and make the 5level stuff unconditional. And get rid of a bunch of
code since both vendors support 5level now...

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
