Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3719C25B75
	for <kexec@archiver.kernel.org>; Mon,  3 Jun 2024 15:33:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=aanLDTsltuU/McZ6g6CZD3MI51YDUB0hjm5kHN+T4Cc=; b=SNNPR2bt383f6j
	wLRQdQ9aVA8IKbH+1j9AhJ7+AqPnjqfBn3UZsGIi+manD6psQHVD+OaI+o/gA7ugyguf30twktWTr
	x+fnj/XWUWAGfotoGfHFZqq1rPfJcvEN95i1G6mHjKbxIyYnKOjgu6J/btpo+bvmOEK+uFMiU3hYk
	gZfzQLQRTlgpn0JozGbtuOL9RQ7wIeSdwycAN8IZABIt9c3SRV96MS+Zr66MSv7EUYAtgQueYnCf5
	JwufSnS7gakNQvlJtlQtaExY4ybrbPNQySqWlnHJJvzG7Osduu7zr1zlUTVVqeUsrGC917Y6tU9u7
	a8OpJJ1f63vaAm009G7A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sE9gT-0000000HFD4-1gLo;
	Mon, 03 Jun 2024 15:33:17 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sE9gQ-0000000HFBM-1CYv
	for kexec@lists.infradead.org;
	Mon, 03 Jun 2024 15:33:15 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 84FDB60EC4;
	Mon,  3 Jun 2024 15:33:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9E44C2BD10;
	Mon,  3 Jun 2024 15:33:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717428793;
	bh=OgWlnRG7yqy7Yvp/hofY3k+TP4mvTMnfi5TRon+rND4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=V78vWfJnvZewwuSibFDHSbCkT7UuQxhh7H/3SePSqXD1IHensUS8575I57nhRRGNm
	 uDOgM18EICY1RU5BGasMfeKdxeRj3rrm2PDIut5kb5N6LTjgQt4lmtZpEoxnd4D/NG
	 DFR4YbrHY4UahiNnkq8kYpIUnqE0jLjoUVsHEudhor2/ijmq3hhwTvR/6TzD+CSeXk
	 70VXT93b0/xJnbu9pKur+08cmupOp+QAg40GAQgg9mAJ18lSAUQwwZQ5MgypDm/HJX
	 A3mtO4WABeasmB7CgPZkv6Qg4s3KxOUWiaz18mYJUJb7SAL8aYxu1BywfFZ6bIqfaX
	 CkQFqvbp/2bJA==
Date: Mon, 3 Jun 2024 18:31:13 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Borislav Petkov <bp@alien8.de>
Cc: "Kalra, Ashish" <ashish.kalra@amd.com>, tglx@linutronix.de,
	mingo@redhat.com, dave.hansen@linux.intel.com, x86@kernel.org,
	rafael@kernel.org, hpa@zytor.com, peterz@infradead.org,
	adrian.hunter@intel.com, sathyanarayanan.kuppuswamy@linux.intel.com,
	jun.nakajima@intel.com, rick.p.edgecombe@intel.com,
	thomas.lendacky@amd.com, michael.roth@amd.com, seanjc@google.com,
	kai.huang@intel.com, bhe@redhat.com,
	kirill.shutemov@linux.intel.com, bdas@redhat.com,
	vkuznets@redhat.com, dionnaglaze@google.com, anisinha@redhat.com,
	jroedel@suse.de, ardb@kernel.org, kexec@lists.infradead.org,
	linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 1/3] efi/x86: Fix EFI memory map corruption with kexec
Message-ID: <Zl3hwYL2GDiyUfGo@kernel.org>
References: <20240528095522.509667-1-kirill.shutemov@linux.intel.com>
 <cover.1717111180.git.ashish.kalra@amd.com>
 <f4be03b8488665f56a1e5c6e6459f447352dfcf5.1717111180.git.ashish.kalra@amd.com>
 <20240603085654.GBZl2FVjPd-gagt-UA@fat_crate.local>
 <8e3dfc15-f609-4839-85c7-1cc8cefd7acc@amd.com>
 <Zl3HfiQ6oHdTdOdA@kernel.org>
 <1ef36309-8d7f-447b-a54a-3cdafeccca64@amd.com>
 <20240603144639.GCZl3XTwmFHwi-KUZW@fat_crate.local>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240603144639.GCZl3XTwmFHwi-KUZW@fat_crate.local>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240603_083314_416962_15AD652F 
X-CRM114-Status: GOOD (  17.49  )
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

On Mon, Jun 03, 2024 at 04:46:39PM +0200, Borislav Petkov wrote:
> On Mon, Jun 03, 2024 at 09:01:49AM -0500, Kalra, Ashish wrote:
> > If we skip efi_arch_mem_reserve() (which should probably be anyway skipped
> > for kexec case), then for kexec boot, EFI memmap is memremapped in the same
> > virtual address as the first kernel and not the allocated memblock address.
> 
> Are you saying that we should simply do
> 
> diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
> index fdf07dd6f459..410cb0743289 100644
> --- a/drivers/firmware/efi/efi.c
> +++ b/drivers/firmware/efi/efi.c
> @@ -577,6 +577,9 @@ void __init efi_mem_reserve(phys_addr_t addr, u64 size)
>  	if (WARN_ON_ONCE(efi_enabled(EFI_PARAVIRT)))
>  		return;
>  
> +	if (kexec_in_progress)
> +		return;
> +
>  	if (!memblock_is_region_reserved(addr, size))
>  		memblock_reserve(addr, size);
>  
> and skip that whole call?

I think Ashish suggested rather 

diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
index fdf07dd6f459..eccc10ab15a4 100644
--- a/drivers/firmware/efi/efi.c
+++ b/drivers/firmware/efi/efi.c
@@ -580,6 +580,9 @@ void __init efi_mem_reserve(phys_addr_t addr, u64 size)
 	if (!memblock_is_region_reserved(addr, size))
 		memblock_reserve(addr, size);
 
+	if (kexec_in_progress)
+		return;
+
 	/*
 	 * Some architectures (x86) reserve all boot services ranges
 	 * until efi_free_boot_services() because of buggy firmware
 
> -- 
> Regards/Gruss,
>     Boris.
> 
> https://people.kernel.org/tglx/notes-about-netiquette

-- 
Sincerely yours,
Mike.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
