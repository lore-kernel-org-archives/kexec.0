Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1CA3C27C50
	for <kexec@archiver.kernel.org>; Mon,  3 Jun 2024 17:43:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=yY5JrtVUJsqevy7XQz+IxDHZxAsxrTI+ihTfbO0KKK0=; b=YvXjJKmEcgxaRP
	X05aGurTS1QqN2nCqVZT1AO+JHFIsr6VX9Z/pyP5dR/OwlL3mjSTHib7vcH+0QmzxzQ+BZnOy2w59
	pVEB0PnWCMvvBLtlW0pFPDLdLb9sH6x2z40qI0kq/2XYa3HzGl8OenEFDzKMDISRtu8dF3jJl6gst
	iAdPdX3R6o80pZa4ivaz++JgRhN3+ps1UPRRZtNTyuJt/ZA84lzi9IvWwWXpFPg8NWH0DdhPn6n1N
	hHK18CKYP388CjUxTFSnn9f317Syu7zujsC5Q6Wcp+UBH1dMNFgSnuMR0Sg1MM1enI3c6AAwAwxol
	4wRnyAmbRCV1yA2ilxHQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sEBiY-0000000HXdt-1re6;
	Mon, 03 Jun 2024 17:43:34 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sEBiV-0000000HXca-2A1x
	for kexec@lists.infradead.org;
	Mon, 03 Jun 2024 17:43:33 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id AB20E60ED4;
	Mon,  3 Jun 2024 17:43:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B072AC2BD10;
	Mon,  3 Jun 2024 17:43:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717436610;
	bh=j2giooDoELICQ3uc1GkFOkfhcLltnqQzqVBJAIjeHJE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dn9hWA6dMSiBGPUDMEWP9UIEij5v/bfQHq6dKecKjdLT4o4xF9krfA07ri6VVunxE
	 4bkjIi0t07Rdx0fuUbeoNfVqxtHB4jCTCodT21dDg9EwLF+sHwtOvTxZaBDdYHu7A+
	 MPZ6I1itabOTmR5aSmjeztm99+G3aBKTXTa/6KY4kZh+KqC65MRO+arsYQtsH8Q7w6
	 aL9f1v1HYECrErCeXbf99FAoSpo/PGu3LFHJ64hsUnzXNU56M+VPjGrWrGUHlJ2W3w
	 buv7fKlUVL+U8OQFLzz1tfcCMEXCVv6CnEfVZ5emUTfC9xIY1d+5mObAeNL2faM4le
	 a1J8qUIjctEEA==
Date: Mon, 3 Jun 2024 20:41:29 +0300
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
Message-ID: <Zl4ASZfWMkvAcJXO@kernel.org>
References: <20240528095522.509667-1-kirill.shutemov@linux.intel.com>
 <cover.1717111180.git.ashish.kalra@amd.com>
 <f4be03b8488665f56a1e5c6e6459f447352dfcf5.1717111180.git.ashish.kalra@amd.com>
 <20240603085654.GBZl2FVjPd-gagt-UA@fat_crate.local>
 <8e3dfc15-f609-4839-85c7-1cc8cefd7acc@amd.com>
 <Zl3HfiQ6oHdTdOdA@kernel.org>
 <1ef36309-8d7f-447b-a54a-3cdafeccca64@amd.com>
 <Zl3hPefvOwPv0Mjn@kernel.org>
 <141a9666-f3cf-4323-9536-4367f489be43@amd.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <141a9666-f3cf-4323-9536-4367f489be43@amd.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240603_104331_817707_1FF60A70 
X-CRM114-Status: GOOD (  36.63  )
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

On Mon, Jun 03, 2024 at 11:56:01AM -0500, Kalra, Ashish wrote:
> On 6/3/2024 10:29 AM, Mike Rapoport wrote:
> 
> > On Mon, Jun 03, 2024 at 09:01:49AM -0500, Kalra, Ashish wrote:
> > > On 6/3/2024 8:39 AM, Mike Rapoport wrote:
> > > 
> > > > On Mon, Jun 03, 2024 at 08:06:56AM -0500, Kalra, Ashish wrote:
> > > > > On 6/3/2024 3:56 AM, Borislav Petkov wrote
> > > > > 
> > > > > > > EFI memory map and due to early allocation it uses memblock allocation.
> > > > > > > 
> > > > > > > Later during boot, efi_enter_virtual_mode() calls kexec_enter_virtual_mode()
> > > > > > > in case of a kexec-ed kernel boot.
> > > > > > > 
> > > > > > > This function kexec_enter_virtual_mode() installs the new EFI memory map by
> > > > > > > calling efi_memmap_init_late() which remaps the efi_memmap physically allocated
> > > > > > > in efi_arch_mem_reserve(), but this remapping is still using memblock allocation.
> > > > > > > 
> > > > > > > Subsequently, when memblock is freed later in boot flow, this remapped
> > > > > > > efi_memmap will have random corruption (similar to a use-after-free scenario).
> > > > > > > 
> > > > > > > The corrupted EFI memory map is then passed to the next kexec-ed kernel
> > > > > > > which causes a panic when trying to use the corrupted EFI memory map.
> > > > > > This sounds fishy: memblock allocated memory is not freed later in the
> > > > > > boot - it remains reserved. Only free memory is freed from memblock to
> > > > > > the buddy allocator.
> > > > > > 
> > > > > > Or is the problem that memblock-allocated memory cannot be memremapped
> > > > > > because *raisins*?
> > > > > This is what seems to be happening:
> > > > > 
> > > > > efi_arch_mem_reserve() calls efi_memmap_alloc() to allocate memory for
> > > > > EFI memory map and due to early allocation it uses memblock allocation.
> > > > > 
> > > > > And later efi_enter_virtual_mode() calls kexec_enter_virtual_mode()
> > > > > in case of a kexec-ed kernel boot.
> > > > > 
> > > > > This function kexec_enter_virtual_mode() installs the new EFI memory map by
> > > > > calling efi_memmap_init_late() which does memremap() on memblock-allocated memory.
> > > > Does the issue happen only with SNP?
> > > This is observed under SNP as efi_arch_mem_reserve() is only being called
> > > with SNP enabled and then efi_arch_mem_reserve() allocates EFI memory map
> > > using memblock.
> > I don't see how efi_arch_mem_reserve() is only called with SNP. What did I
> > miss?
> 
> This is the call stack for efi_arch_mem_reserve():
> 
> [    0.310010]  efi_arch_mem_reserve+0xb1/0x220
> [    0.311382]  efi_mem_reserve+0x36/0x60
> [    0.311973]  efi_bgrt_init+0x17d/0x1a0
> [    0.313265]  acpi_parse_bgrt+0x12/0x20
> [    0.313858]  acpi_table_parse+0x77/0xd0
> [    0.314463]  acpi_boot_init+0x362/0x630
> [    0.315069]  setup_arch+0xa88/0xf80
> [    0.315629]  start_kernel+0x68/0xa90
> [    0.316194]  x86_64_start_reservations+0x1c/0x30
> [    0.316921]  x86_64_start_kernel+0xbf/0x110
> [    0.317582]  common_startup_64+0x13e/0x141
> 
> So, probably it is being invoked specifically for AMD platform ?

AFAIU, efi_bgrt_init() can be called for any x86 platform, with or without
encryption. 
So if my understating is correct, efi_arch_mem_reserve() will be called with SNP
disabled as well. And if kexec works ok without SNP but fails with SNP this
may give as a clue to the root cause of the failure.
 
> > > If we skip efi_arch_mem_reserve() (which should probably be anyway skipped
> > > for kexec case), then for kexec boot, EFI memmap is memremapped in the same
> > > virtual address as the first kernel and not the allocated memblock address.
> > Maybe we should skip efi_arch_mem_reserve() for kexec case, but I think we
> > still need to understand what's causing memory corruption.
> 
> When, efi_arch_mem_reserve() allocates memory for EFI memory map using
> memblock and then later in boot, kexec_enter_virtual_mode() does memremap on
> this memblock allocated memory, subsequently after this i see EFI memory map
> corruption, so are there are any issues doing memremap on memblock-allocated
> memory ?

memblock-allocated memory is just RAM, so my take is that memremap() cannot
figure out the encryption bits properly.

You can check if there are issues with memrmapp()ing memblock-allocated
memory by sticking memblock_phys_alloc() somewhere, filling that memory with a
pattern and then calling memremap(addr, size, MEMREMAP_WB) and checking if
the pattern is still there.
 
> Thanks, Ashish
> 
> > > > I didn't really dig, but my theory would be that it has something to do
> > > > with arch_memremap_can_ram_remap() in arch/x86/mm/ioremap.c
> > > > > Thanks, Ashish

-- 
Sincerely yours,
Mike.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
