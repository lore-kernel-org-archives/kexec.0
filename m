Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2A19C48BC4
	for <kexec@archiver.kernel.org>; Tue, 20 Feb 2024 10:30:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=pI8gi259dxalMxQtDRRo8aJ/C7OPaALMq+J0tJqENaw=; b=Tjmc2sJsF9I33x
	MYQwCM4gWcCAn8O3hLmvpMQt8loKeg14tx0lcHs2+jriy5Wvro2bcJAS8/OWK/pQlD0uD8/LkE+N0
	rFFaC1l7qLRhB/aJB+DgBtKT/HwFdPk0MHnP+RA4H05m7WObDkLjLmv7Sz+UubF4DPYA5GH6or30S
	Xxh/1OT2kvXx9k1OFGVR1OHvxletoUQFa9eH9VxA+MnRQmiXhmizzNLgpSqk0YAkLV4eV/QVF7CEz
	YL4LVPIGbtrGHwz+ujUc8bTebTm4AY1wFlBtJKQcCLpHDQGmJbJwuIF1/Dl1TxwEZ7Hp6bEl0bTQL
	MOxEe1BiC3vTrGqBrz8w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rcNOi-0000000EGrR-0crt;
	Tue, 20 Feb 2024 10:30:48 +0000
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rcNOe-0000000EGpI-3Va6;
	Tue, 20 Feb 2024 10:30:46 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id A6354CE13C7;
	Tue, 20 Feb 2024 10:30:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29965C433F1;
	Tue, 20 Feb 2024 10:30:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708425041;
	bh=rDg/9pQz+JjJErUCeBdP4AE5y1aHUaEqxtVxVjDTBi0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dv53lCXnUxAP5BUjIySykbuaNTQICqKsTGSDQF5bW3u7Cr+yRuZcvocze4Ikb9735
	 OmZ7vuyGPLaOIK9URG/85iZrOPUHhu441cQBZ4LYqviNRoFjJY4A1UvToClldVWpdZ
	 WgUaGuvfKPRL0ZXOQB/sa/C4QRbrlUX5zGSVPsU3+38Q+XNke9VSAYAt/TPV5GELzn
	 L/ju7NOORRvHekikdXfgrCAPpVRFbL0OcFUt+669NBF0PJv7dffBQun7e0a1rxMuZ2
	 OOadaojb0lQUEj7e19sUrNYpqbH75wyAbt18H1D12MTzaSXyN82rpvaYpqFs+fWFsQ
	 qZPHw3iW0X/3Q==
Date: Tue, 20 Feb 2024 12:30:01 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Alexander Graf <graf@amazon.com>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	linux-mm@kvack.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, kexec@lists.infradead.org,
	linux-doc@vger.kernel.org, x86@kernel.org,
	Eric Biederman <ebiederm@xmission.com>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Ashish Kalra <ashish.kalra@amd.com>,
	James Gowans <jgowans@amazon.com>,
	Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>,
	arnd@arndb.de, pbonzini@redhat.com, madvenka@linux.microsoft.com,
	Anthony Yznaga <anthony.yznaga@oracle.com>,
	Usama Arif <usama.arif@bytedance.com>,
	David Woodhouse <dwmw@amazon.co.uk>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH v3 09/17] x86: Add KHO support
Message-ID: <ZdR_KQSIrPuEh5G5@kernel.org>
References: <20240117144704.602-1-graf@amazon.com>
 <20240117144704.602-10-graf@amazon.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240117144704.602-10-graf@amazon.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240220_023045_275483_9456915B 
X-CRM114-Status: GOOD (  30.95  )
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

Hi Alex,

On Wed, Jan 17, 2024 at 02:46:56PM +0000, Alexander Graf wrote:
> We now have all bits in place to support KHO kexecs. This patch adds
> awareness of KHO in the kexec file as well as boot path for x86 and
> adds the respective kconfig option to the architecture so that it can
> use KHO successfully.
> 
> In addition, it enlightens it decompression code with KHO so that its
> KASLR location finder only considers memory regions that are not already
> occupied by KHO memory.
> 
> Signed-off-by: Alexander Graf <graf@amazon.com>
> 
> ---
> 
> v1 -> v2:
> 
>   - Change kconfig option to ARCH_SUPPORTS_KEXEC_KHO
>   - s/kho_reserve_mem/kho_reserve_previous_mem/g
>   - s/kho_reserve/kho_reserve_scratch/g
> ---
>  arch/x86/Kconfig                      |  3 ++
>  arch/x86/boot/compressed/kaslr.c      | 55 +++++++++++++++++++++++++++
>  arch/x86/include/uapi/asm/bootparam.h | 15 +++++++-
>  arch/x86/kernel/e820.c                |  9 +++++
>  arch/x86/kernel/kexec-bzimage64.c     | 39 +++++++++++++++++++
>  arch/x86/kernel/setup.c               | 46 ++++++++++++++++++++++
>  arch/x86/mm/init_32.c                 |  7 ++++
>  arch/x86/mm/init_64.c                 |  7 ++++
>  8 files changed, 180 insertions(+), 1 deletion(-)

...

> @@ -987,8 +1013,26 @@ void __init setup_arch(char **cmdline_p)
>  	cleanup_highmap();
>  
>  	memblock_set_current_limit(ISA_END_ADDRESS);
> +
>  	e820__memblock_setup();
>  
> +	/*
> +	 * We can resize memblocks at this point, let's dump all KHO
> +	 * reservations in and switch from scratch-only to normal allocations
> +	 */
> +	kho_reserve_previous_mem();
> +
> +	/* Allocations now skip scratch mem, return low 1M to the pool */
> +	if (is_kho_boot()) {
> +		u64 i;
> +		phys_addr_t base, end;
> +
> +		__for_each_mem_range(i, &memblock.memory, NULL, NUMA_NO_NODE,
> +				     MEMBLOCK_SCRATCH, &base, &end, NULL)
> +			if (end <= ISA_END_ADDRESS)
> +				memblock_clear_scratch(base, end - base);
> +	}

You had to mark lower 16M as MEMBLOCK_SCRATCH because at this point the
mapping of the physical memory is not ready yet and page tables only cover
lower 16M and the memory mapped in kexec::init_pgtable(). Hence the call
for memblock_set_current_limit(ISA_END_ADDRESS) slightly above, which
essentially makes scratch mem reserved by KHO unusable for allocations.

I'd suggest to move kho_reserve_previous_mem() earlier, probably even right
next to kho_populate().
kho_populate() already does memblock_add(scratch) and at that point it's
the only physical memory that memblock knows of, so if it'll have to
allocate, the allocations will end up there.

Also, there are no kernel allocations before e820__memblock_setup(), so the
only memory that might need to be allocated is for memblock_double_array()
and that will be discarded later anyway.

With this, it seems that MEMBLOCK_SCRATCH is not needed, as the scratch
memory is anyway the only usable memory up to e820__memblock_setup().

>  	/*
>  	 * Needs to run after memblock setup because it needs the physical
>  	 * memory size.
> @@ -1104,6 +1148,8 @@ void __init setup_arch(char **cmdline_p)
>  	 */
>  	arch_reserve_crashkernel();
>  
> +	kho_reserve_scratch();
> +
>  	memblock_find_dma_reserve();
>  
>  	if (!early_xdbc_setup_hardware())
> diff --git a/arch/x86/mm/init_32.c b/arch/x86/mm/init_32.c
> index b63403d7179d..6c3810afed04 100644
> --- a/arch/x86/mm/init_32.c
> +++ b/arch/x86/mm/init_32.c
> @@ -20,6 +20,7 @@
>  #include <linux/smp.h>
>  #include <linux/init.h>
>  #include <linux/highmem.h>
> +#include <linux/kexec.h>
>  #include <linux/pagemap.h>
>  #include <linux/pci.h>
>  #include <linux/pfn.h>
> @@ -738,6 +739,12 @@ void __init mem_init(void)
>  	after_bootmem = 1;
>  	x86_init.hyper.init_after_bootmem();
>  
> +	/*
> +	 * Now that all KHO pages are marked as reserved, let's flip them back
> +	 * to normal pages with accurate refcount.
> +	 */
> +	kho_populate_refcount();

This should go to mm_core_init(), there's nothing architecture specific
there.

> +
>  	/*
>  	 * Check boundaries twice: Some fundamental inconsistencies can
>  	 * be detected at build time already.

-- 
Sincerely yours,
Mike.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
