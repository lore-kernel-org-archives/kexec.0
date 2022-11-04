Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46CF4C4332F
	for <kexec@archiver.kernel.org>; Fri,  4 Nov 2022 12:51:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ferJCUvZXrDpW+QH+PbshHNtRLwEx0ixhg+Xg5HA1Qg=; b=nO7w2shAtSXGyb
	zHVg5poxobzlC8G/4v1+/3nX+wgKIc1cCszKeRSfR8IM4zriovrBBc/ROIr9Ef6j/N79ZqZgFh/Fe
	1CJWNOXJmsB7nf37xg8ACKylPhbqUznljnp4OyKiUHIjp0oG7TIJBtRVTx1b48ahJ3aJIxlr7N3E9
	ArcK8+AWAJvLUKnAMkbWZSKMmZ0I8BQT0SAqt2ivwcCwaa9IBU6Wfi9zs5cSNIzmD3aYuJYUWJF6d
	VYRBCRu9aJ3Ny0gMLWd+LlwsKKM0Mx1+lUxNOb2j9xLFZeYaabNhcdO4gRHKgc2SptYXTiNPbtNhj
	V+ChlearqQH5yZPxfTCw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oqwAA-003WHg-3w; Fri, 04 Nov 2022 12:51:10 +0000
Received: from ams.source.kernel.org ([145.40.68.75])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oqwA6-003WG6-3C; Fri, 04 Nov 2022 12:51:08 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id DF915B82D32;
	Fri,  4 Nov 2022 12:51:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EC7AC433C1;
	Fri,  4 Nov 2022 12:51:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1667566262;
	bh=jiGK3o0Gv2eoeA5+7Wfk08wEapetiZPf58b7uXbb8OM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pL7mTk8F89Yl8cKQ3USab8PnD5gWNSbJPe59wpc6mDAnghO5Mlzkm2buzRwpQnznn
	 LY+RQU9wjvHzOffXdRWfhSO2yBpHyh5/8Ju+FMCDgSWBayXPBKlm1Q30wyr3i3dutf
	 MlttYKL0FlhOSaiXlhxSCetIkOAuJALHaN3Z3lD6RHrx6jjXt8TJb2qVIaxChKniK4
	 Lwac4P4BwJ/gjQ2W8nsNoOfO8DvZDdLOa4wuVA8QEIJqqksq0jQp2S/LC71srWrC67
	 cdA3M/PJh+8OwuHV8KYIqznRffsrILVmKM971w5bQWXArXg23+2Z8ErgD/tU7DdBdA
	 7XkWq5405Kshg==
Date: Fri, 4 Nov 2022 12:50:57 +0000
From: Conor Dooley <conor@kernel.org>
To: Li Huafei <lihuafei1@huawei.com>
Cc: paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu,
	lizhengyu3@huawei.com, liaochang1@huawei.com,
	u.kleine-koenig@pengutronix.de, rdunlap@infradead.org,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	kexec@lists.infradead.org
Subject: Re: [PATCH 1/2] RISC-V: kexec: Fix memory leak of fdt buffer
Message-ID: <Y2UKsW8RzuNmEo8r@spud>
References: <20221104095658.141222-1-lihuafei1@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20221104095658.141222-1-lihuafei1@huawei.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221104_055106_467428_A2933422 
X-CRM114-Status: GOOD (  22.51  )
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

On Fri, Nov 04, 2022 at 05:56:57PM +0800, Li Huafei wrote:
> This is reported by kmemleak detector:
> 
> unreferenced object 0xff60000082864000 (size 9588):
>   comm "kexec", pid 146, jiffies 4294900634 (age 64.788s)
>   hex dump (first 32 bytes):
>     d0 0d fe ed 00 00 12 ed 00 00 00 48 00 00 11 40  ...........H...@
>     00 00 00 28 00 00 00 11 00 00 00 02 00 00 00 00  ...(............
>   backtrace:
>     [<00000000f95b17c4>] kmemleak_alloc+0x34/0x3e
>     [<00000000b9ec8e3e>] kmalloc_order+0x9c/0xc4
>     [<00000000a95cf02e>] kmalloc_order_trace+0x34/0xb6
>     [<00000000f01e68b4>] __kmalloc+0x5c2/0x62a
>     [<000000002bd497b2>] kvmalloc_node+0x66/0xd6
>     [<00000000906542fa>] of_kexec_alloc_and_setup_fdt+0xa6/0x6ea
>     [<00000000e1166bde>] elf_kexec_load+0x206/0x4ec
>     [<0000000036548e09>] kexec_image_load_default+0x40/0x4c
>     [<0000000079fbe1b4>] sys_kexec_file_load+0x1c4/0x322
>     [<0000000040c62c03>] ret_from_syscall+0x0/0x2
> 
> In elf_kexec_load(), a buffer is allocated via kvmalloc() to store fdt.
> While it's not freed back to system when kexec kernel is reloaded or
> unloaded.  Then memory leak is caused.  Fix it by introducing riscv
> specific function arch_kimage_file_post_load_cleanup(), and freeing the
> buffer there.
> 
> Fixes: 6261586e0c91 ("RISC-V: Add kexec_file support")
> Signed-off-by: Li Huafei <lihuafei1@huawei.com>

Both of these bits of cleanup seem to echo what's the case on arm64.
Seems reasonable to me..
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

> ---
>  arch/riscv/include/asm/kexec.h |  5 +++++
>  arch/riscv/kernel/elf_kexec.c  | 10 ++++++++++
>  2 files changed, 15 insertions(+)
> 
> diff --git a/arch/riscv/include/asm/kexec.h b/arch/riscv/include/asm/kexec.h
> index eee260e8ab30..2b56769cb530 100644
> --- a/arch/riscv/include/asm/kexec.h
> +++ b/arch/riscv/include/asm/kexec.h
> @@ -39,6 +39,7 @@ crash_setup_regs(struct pt_regs *newregs,
>  #define ARCH_HAS_KIMAGE_ARCH
>  
>  struct kimage_arch {
> +	void *fdt; /* For CONFIG_KEXEC_FILE */
>  	unsigned long fdt_addr;
>  };
>  
> @@ -62,6 +63,10 @@ int arch_kexec_apply_relocations_add(struct purgatory_info *pi,
>  				     const Elf_Shdr *relsec,
>  				     const Elf_Shdr *symtab);
>  #define arch_kexec_apply_relocations_add arch_kexec_apply_relocations_add
> +
> +struct kimage;
> +int arch_kimage_file_post_load_cleanup(struct kimage *image);
> +#define arch_kimage_file_post_load_cleanup arch_kimage_file_post_load_cleanup
>  #endif
>  
>  #endif
> diff --git a/arch/riscv/kernel/elf_kexec.c b/arch/riscv/kernel/elf_kexec.c
> index 0cb94992c15b..ff30fcb43f47 100644
> --- a/arch/riscv/kernel/elf_kexec.c
> +++ b/arch/riscv/kernel/elf_kexec.c
> @@ -21,6 +21,14 @@
>  #include <linux/memblock.h>
>  #include <asm/setup.h>
>  
> +int arch_kimage_file_post_load_cleanup(struct kimage *image)
> +{
> +	kvfree(image->arch.fdt);
> +	image->arch.fdt = NULL;
> +
> +	return kexec_image_post_load_cleanup_default(image);
> +}
> +
>  static int riscv_kexec_elf_load(struct kimage *image, struct elfhdr *ehdr,
>  				struct kexec_elf_info *elf_info, unsigned long old_pbase,
>  				unsigned long new_pbase)
> @@ -298,6 +306,8 @@ static void *elf_kexec_load(struct kimage *image, char *kernel_buf,
>  		pr_err("Error add DTB kbuf ret=%d\n", ret);
>  		goto out_free_fdt;
>  	}
> +	/* Cache the fdt buffer address for memory cleanup */
> +	image->arch.fdt = fdt;
>  	pr_notice("Loaded device tree at 0x%lx\n", kbuf.mem);
>  	goto out;
>  
> -- 
> 2.17.1
> 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
