Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 660D6C25B75
	for <kexec@archiver.kernel.org>; Mon,  3 Jun 2024 15:31:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=AwUOmrYFbAtSOHNtks7/O0zY02ZlirfKTbQh1ssVIIY=; b=WR+dnOls1TKCr8
	2vAn7KNXmrtbWFo4GPDfqAXR22QoLTznpI421cxHflt5ih/R5VyljYoxQlA+1AddgxpFoACWtDfP4
	mC2okDbtdN4LMTZO1CeJ3QErelclVMw9zEjFGT1u9kmsbPvdjp3t/ecAZsf3tnCjy+0D1+u8hGmhH
	c420f/E6F96FZwySMwRDGuIK7Rb/i/iG9aIzuroRySRmzoX3vGTMuQvDL6WQ96iEMqhtcxL/W9crh
	4fpKK8k17pv8t+0ZUl4ZRRT+2eqkk7za5UT2mz0xd8lKDmGyg89Ow8gba5Pz9FDg34BI/5ETYmdbX
	+tfqRiD9wR/0DlWyWeWA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sE9eQ-0000000HEkU-3vLu;
	Mon, 03 Jun 2024 15:31:10 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sE9eJ-0000000HEi5-1sCj
	for kexec@lists.infradead.org;
	Mon, 03 Jun 2024 15:31:08 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 8D80860EC0;
	Mon,  3 Jun 2024 15:31:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6CFBC2BD10;
	Mon,  3 Jun 2024 15:30:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717428662;
	bh=odR2yE0PrRaovS85NwYBENVHPZalKhxFjP3osPFtmGI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OHlX5b47nBaH+NbFGZWsM5ISVowFzvmzrSp6y4oP/rXvG5yYP6L8HH2LG6uKupMz5
	 tXCTbOgWYebcYp+bv2SlxdC1QnUrmnM15cvJaB5TrIyeEeQa2b7jHgACz39soaomFg
	 czTkykzix1LIgAv4l04GRBPZZF/bISMNW6FumlIKXv4+q3MWD0/Aa16hh5Qq1QTrlc
	 GLd2HPiz+KJJTTvCq+LHa2KNUPmLzVuc1WNSDZwtcYPeRaWQIwHnNEeWy8vcIGMGwa
	 tggzcPBCL+1/NVikvspB//QMd31Jcf7dvIpxmL+QStiyrMo4rpj2BxxCUq8/bVf4C9
	 uvJRpjW0kmoDw==
Date: Mon, 3 Jun 2024 18:29:01 +0300
From: Mike Rapoport <rppt@kernel.org>
To: "Kalra, Ashish" <ashish.kalra@amd.com>
Cc: Borislav Petkov <bp@alien8.de>, tglx@linutronix.de, mingo@redhat.com,
	dave.hansen@linux.intel.com, x86@kernel.org, rafael@kernel.org,
	hpa@zytor.com, peterz@infradead.org, adrian.hunter@intel.com,
	sathyanarayanan.kuppuswamy@linux.intel.com, jun.nakajima@intel.com,
	rick.p.edgecombe@intel.com, thomas.lendacky@amd.com,
	michael.roth@amd.com, seanjc@google.com, kai.huang@intel.com,
	bhe@redhat.com, kirill.shutemov@linux.intel.com, bdas@redhat.com,
	vkuznets@redhat.com, dionnaglaze@google.com, anisinha@redhat.com,
	jroedel@suse.de, ardb@kernel.org, kexec@lists.infradead.org,
	linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 1/3] efi/x86: Fix EFI memory map corruption with kexec
Message-ID: <Zl3hPefvOwPv0Mjn@kernel.org>
References: <20240528095522.509667-1-kirill.shutemov@linux.intel.com>
 <cover.1717111180.git.ashish.kalra@amd.com>
 <f4be03b8488665f56a1e5c6e6459f447352dfcf5.1717111180.git.ashish.kalra@amd.com>
 <20240603085654.GBZl2FVjPd-gagt-UA@fat_crate.local>
 <8e3dfc15-f609-4839-85c7-1cc8cefd7acc@amd.com>
 <Zl3HfiQ6oHdTdOdA@kernel.org>
 <1ef36309-8d7f-447b-a54a-3cdafeccca64@amd.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1ef36309-8d7f-447b-a54a-3cdafeccca64@amd.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240603_083103_593354_3A44CA1B 
X-CRM114-Status: GOOD (  28.06  )
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

On Mon, Jun 03, 2024 at 09:01:49AM -0500, Kalra, Ashish wrote:
> On 6/3/2024 8:39 AM, Mike Rapoport wrote:
> 
> > On Mon, Jun 03, 2024 at 08:06:56AM -0500, Kalra, Ashish wrote:
> > > On 6/3/2024 3:56 AM, Borislav Petkov wrote
> > > 
> > > > > EFI memory map and due to early allocation it uses memblock allocation.
> > > > > 
> > > > > Later during boot, efi_enter_virtual_mode() calls kexec_enter_virtual_mode()
> > > > > in case of a kexec-ed kernel boot.
> > > > > 
> > > > > This function kexec_enter_virtual_mode() installs the new EFI memory map by
> > > > > calling efi_memmap_init_late() which remaps the efi_memmap physically allocated
> > > > > in efi_arch_mem_reserve(), but this remapping is still using memblock allocation.
> > > > > 
> > > > > Subsequently, when memblock is freed later in boot flow, this remapped
> > > > > efi_memmap will have random corruption (similar to a use-after-free scenario).
> > > > > 
> > > > > The corrupted EFI memory map is then passed to the next kexec-ed kernel
> > > > > which causes a panic when trying to use the corrupted EFI memory map.
> > > > This sounds fishy: memblock allocated memory is not freed later in the
> > > > boot - it remains reserved. Only free memory is freed from memblock to
> > > > the buddy allocator.
> > > > 
> > > > Or is the problem that memblock-allocated memory cannot be memremapped
> > > > because *raisins*?
> > > This is what seems to be happening:
> > > 
> > > efi_arch_mem_reserve() calls efi_memmap_alloc() to allocate memory for
> > > EFI memory map and due to early allocation it uses memblock allocation.
> > > 
> > > And later efi_enter_virtual_mode() calls kexec_enter_virtual_mode()
> > > in case of a kexec-ed kernel boot.
> > > 
> > > This function kexec_enter_virtual_mode() installs the new EFI memory map by
> > > calling efi_memmap_init_late() which does memremap() on memblock-allocated memory.
> > Does the issue happen only with SNP?
> 
> This is observed under SNP as efi_arch_mem_reserve() is only being called
> with SNP enabled and then efi_arch_mem_reserve() allocates EFI memory map
> using memblock.

I don't see how efi_arch_mem_reserve() is only called with SNP. What did I
miss?
 
> If we skip efi_arch_mem_reserve() (which should probably be anyway skipped
> for kexec case), then for kexec boot, EFI memmap is memremapped in the same
> virtual address as the first kernel and not the allocated memblock address.

Maybe we should skip efi_arch_mem_reserve() for kexec case, but I think we
still need to understand what's causing memory corruption.

> Thanks, Ashish
> 
> > 
> > I didn't really dig, but my theory would be that it has something to do
> > with arch_memremap_can_ram_remap() in arch/x86/mm/ioremap.c
> > > Thanks, Ashish

-- 
Sincerely yours,
Mike.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
