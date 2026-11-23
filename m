Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08DB0606A31A
	for <kexec@archiver.kernel.org>; Mon, 23 Nov 2026 07:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=svpNaFeY;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hnUEHKCx
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:References:Cc:To:From:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=0OSpOlJ5QU7jjdI5ogSU6KcCruhdHca3yQivXfMqClg=; b=svpNaFeYVdHMiw
	PO6aW+ZusTHpOrjd7Xf4tU4nB7+jnSdrVB6tDJcSsme9fUseVrWXOFo3+OtEGgtwAosFysBU2L0Jb
	j0aE/AdDlTm6GD7js2+qSgBZvO1pObYuS9kL6fN1wbLCgJjNyx1uYGyRQ8UKlApwxkdPnnVxKIZAc
	BOTyPCU2hVQguO+eU8SjG9i5w3H5n33WNo3ELS68YAPWMnUBb3Kohr7Nrwt1vRzA7MFAK7f/oTGEz
	CqQ32OVgguDRdXSLLLcxhcs4ylZLZI+dhX+ytAYroeBL42cEfSz+7pMOohEPyAu+O/CBvo0wuYds8
	zMPs1IrYlh8BHtri+LYA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xVOfG-00000002TST-2k6a;
	Mon, 23 Nov 2026 07:40:38 +0000
Received: from mail-pj2-x0b.google.com ([2607:f8b0:4864:39::b])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xVOfE-00000002TRT-0qh2
	for kexec@lists.infradead.org;
	Mon, 23 Nov 2026 07:40:37 +0000
Received: by mail-pj2-x0b.google.com with SMTP id 98e67ed59e1d1-3b094d5f1b4so604079a91.0
        for <kexec@lists.infradead.org>; Sun, 22 Nov 2026 23:40:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795419635; x=1796024435; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=0OSpOlJ5QU7jjdI5ogSU6KcCruhdHca3yQivXfMqClg=;
        b=hnUEHKCxs25ibK8s8PZveTfVavr916DlwWOWG0NSCEWfSpVWuHMX/yugM9TcXlfnvh
         731fhe1pgUahWBMpfkrQxDJAV+kFy7nXFH2p7VUIwVN3zCj0GEH6pVaHlI4Jxq/CTWsm
         MLDjtjo53Mum3DV0qbhnDjeJZY9GsCgRCHiIJyKvqt2OB/svjl7tdtkbZzscnZss9yAd
         oj+ybhNr7fYss90ZXuFnntSsopu1a29awbDoEDpEDhBnvrUw+JXPnSUzN6fMHUGU3Hgb
         j+3UiebIBEG5R/kH2sgSbKcwkO110zV2qGTj7oq9pJkoaUYWuAj7HrrIGLUoZiLMabMg
         nOtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795419635; x=1796024435;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0OSpOlJ5QU7jjdI5ogSU6KcCruhdHca3yQivXfMqClg=;
        b=j37Ua5hgNqOeAm89nf7UFfFD0GiN+/tmuRUtfPAkeWp3addFk7uW18sa2XOZwljssv
         GQOq3H7Hv9agnR0iyib7EHJoGmiIvy8y37m79gWLEB8M2f6+3JRAkd9V4SWioD7LjAMC
         z7BEWZQ7yu6e6BgslQIjHzcnthQMl3g2cL5e0olVemM2n45mDunM3EiL9K6KfOIImiwi
         EcxIzbVjThl1g320WCNixlTCuhWkZePf+0pGpaBzZ03EhQqE6SdIoj2WGlaSkIyvhsqj
         9TNJXnj6O11cRZlqQ0X6aDo3Om8ozUM1/4GNtRVoaWHARfQLaXX4dvU4RfwZlHQIlGEr
         gl0w==
X-Forwarded-Encrypted: i=1; AL+hErHEYNVV+qGeM2nfceWdIkRDd9qDrzWoqybCI5zCaXmvp0jnbpGBmRqulM4bmzNYUTlv5dGblQ==@lists.infradead.org
X-Gm-Message-State: APuU4Z8xZfnpk2Ym1klGc8ZZInjh1BAZkXwbjN7GKTDn2EjPIuamAMLA
	Ksf6jEfTnW5b2MCwv+kLBq7UrxtRBiyb3AiYp4iLhoXx/PN0w3zO+rfl
X-Gm-Gg: AZFdTZdLlg9mht+HMgWrwTwOBGSlThE3eEqetvG31nEC7MyGbVt7BMdwk12a37JGIZN
	7OhNDGVgQHxFmP35tKG2tciRf852ljLJOQMYWCrUlvGXjsuoKOtwk0lw0GCw3UZk3lNMb1ydjwx
	L2kf7cynD9Z/0wY1kP4tZuCnBZlZ7ropQo2tBznKZ/c1Uooo3L4bcWPDuQ3JaXtT+a+TqmKEqHk
	m12wa1JCrd9OJ7j5FWv/rWA9R7XnfX9YICeqPGR5pSZlpywomzhr3lvaZMBxE+VQBbi+p8MWRTA
	Fb/wgLCKmtFh6Pi/qH7zyvRViyF+qKhhCNIr17GAMFGLgR9GB7RO/ipso9w/u9BTnWY78QTec0m
	zzImhREdzHb2scqsSNs/7YNyoFPeB33AtqYUtWUojs6TkfyjiBCVajEkN48Wzi9MhO4OGNja5ra
	NGSsMljcjH6wqlLDumcn6fRzjRPusVnLfbUdaYii0WpFgYBgptk73Ako7ZtgEThPKysfbDI8gUL
	dYxuzeo2OX6by+NZ8zfSY608kNUklHz9D6ATcIQV689xBQlU3NNMy4YIyJBkTf3ZnQrvR3ueADe
	Oq8yXa4lSOxO1BX9sp01CU6Mata9IwRtJj/+
X-Received: by 2002:a17:90b:2f8c:b0:3b4:1997:3495 with SMTP id 98e67ed59e1d1-3b41c9613bbmr9155015a91.57.1795419634749;
        Sun, 22 Nov 2026 23:40:34 -0800 (PST)
Received: from [10.125.112.22] ([122.11.210.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b41ad8ef99sm17103994a91.12.2026.11.22.23.40.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Nov 2026 23:40:34 -0800 (PST)
Message-ID: <a3ebfc1c-9c98-44a1-96e2-4d92daed4ba4@gmail.com>
Date: Mon, 23 Nov 2026 15:40:19 +0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 1/8] riscv: build crash_mem ranges from memblock
 instead of resource tree
From: Wandun <chenwandun1@gmail.com>
To: pjw@kernel.org, palmer@dabbelt.com, aou@eecs.berkeley.edu
Cc: catalin.marinas@arm.com, will@kernel.org, mark.rutland@arm.com,
 chenhuacai@kernel.org, kernel@xen0n.name, alex@ghiti.fr, tglx@kernel.org,
 mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
 hpa@zytor.com, saravanak@kernel.org, akpm@linux-foundation.org,
 pasha.tatashin@soleen.com, pratyush@kernel.org, ruirui.yang@linux.dev,
 robin.murphy@arm.com, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, loongarch@lists.linux.dev,
 linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
 kexec@lists.infradead.org, linux-mm@kvack.org, iommu@lists.linux.dev,
 robh@kernel.org, baoquan.he@linux.dev, rppt@kernel.org,
 m.szyprowski@samsung.com
References: <20261021083011.2170525-1-chenwandun1@gmail.com>
 <20261021083011.2170525-2-chenwandun1@gmail.com>
Content-Language: en-US
In-Reply-To: <20261021083011.2170525-2-chenwandun1@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261122_234036_249456_A2945D3E 
X-CRM114-Status: GOOD (  16.92  )
X-Spam-Score: -1.9 (-)
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <kexec.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
X-Spam-Status: No, score=-14.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 10/21/26 16:30, Wandun Chen wrote:
> From: Wandun Chen <chenwandun@lixiang.com>
> 
> Replace walk_system_ram_res() with for_each_mem_range(). A later patch
> introduces MEMBLOCK_NODUMP in memblock, the reserved-memory regions
> marked with MEMBLOCK_NODUMP can be excluded from the vmcore by walking
> memblock.
> 
> for_each_mem_range() iterates memblock.memory, which is freed after
> init unless ARCH_KEEP_MEMBLOCK is selected. riscv needs ARCH_KEEP_MEMBLOCK
> to filter reserved memory from the vmcore, so extend its condition
> (ACPI || KEXEC) with CRASH_DUMP. arm64 and loongarch already select
> ARCH_KEEP_MEMBLOCK unconditionally.


Hi Paul, Palmer, Albert,

A gentle ping on this patch.

Mike has requested a RISC-V maintainer Ack before taking the revised
series through the kexec tree. Could you please take a look when you
have a chance?

Thanks,
Wandun

> 
> Signed-off-by: Wandun Chen <chenwandun@lixiang.com>
> Tested-by: Meijing Zhao <zhaomeijing@lixiang.com>
> Acked-by: Baoquan He <baoquan.he@linux.dev>
> ---
>  arch/riscv/Kconfig                     |  2 +-
>  arch/riscv/kernel/machine_kexec_file.c | 31 ++++++++++----------------
>  2 files changed, 13 insertions(+), 20 deletions(-)
> 
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index e7891a2a89da..e21d0bab77ee 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -58,7 +58,7 @@ config RISCV
>  	select ARCH_HAS_UBSAN
>  	select ARCH_HAS_VDSO_ARCH_DATA
>  	select ARCH_HAVE_NMI_SAFE_CMPXCHG
> -	select ARCH_KEEP_MEMBLOCK if ACPI || KEXEC
> +	select ARCH_KEEP_MEMBLOCK if ACPI || KEXEC || CRASH_DUMP
>  	select ARCH_MHP_MEMMAP_ON_MEMORY_ENABLE	if 64BIT && MMU
>  	select ARCH_OPTIONAL_KERNEL_RWX if ARCH_HAS_STRICT_KERNEL_RWX
>  	select ARCH_OPTIONAL_KERNEL_RWX_DEFAULT
> diff --git a/arch/riscv/kernel/machine_kexec_file.c b/arch/riscv/kernel/machine_kexec_file.c
> index 26cd2a8bd0cd..808e872f4063 100644
> --- a/arch/riscv/kernel/machine_kexec_file.c
> +++ b/arch/riscv/kernel/machine_kexec_file.c
> @@ -37,39 +37,32 @@ int arch_kimage_file_post_load_cleanup(struct kimage *image)
>  }
>  
>  #ifdef CONFIG_CRASH_DUMP
> -static int get_nr_ram_ranges_callback(struct resource *res, void *arg)
> -{
> -	unsigned int *nr_ranges = arg;
> -
> -	(*nr_ranges)++;
> -	return 0;
> -}
> -
>  unsigned int arch_get_system_nr_ranges(void)
>  {
>  	unsigned int nr_ranges = 2 + crashk_cma_cnt; /* For exclusion of crashkernel region */
> +	u64 i;
> +	phys_addr_t start, end;
>  
> -	walk_system_ram_res(0, -1, &nr_ranges, get_nr_ram_ranges_callback);
> +	for_each_mem_range(i, &start, &end)
> +		nr_ranges++;
>  
>  	return nr_ranges;
>  }
>  
> -static int prepare_elf64_ram_headers_callback(struct resource *res, void *arg)
> +int arch_crash_populate_cmem(struct crash_mem *cmem)
>  {
> -	struct crash_mem *cmem = arg;
> +	u64 i;
> +	phys_addr_t start, end;
>  
> -	cmem->ranges[cmem->nr_ranges].start = res->start;
> -	cmem->ranges[cmem->nr_ranges].end = res->end;
> -	cmem->nr_ranges++;
> +	for_each_mem_range(i, &start, &end) {
> +		cmem->ranges[cmem->nr_ranges].start = start;
> +		cmem->ranges[cmem->nr_ranges].end = end - 1;
> +		cmem->nr_ranges++;
> +	}
>  
>  	return 0;
>  }
>  
> -int arch_crash_populate_cmem(struct crash_mem *cmem)
> -{
> -	return walk_system_ram_res(0, -1, cmem, prepare_elf64_ram_headers_callback);
> -}
> -
>  static char *setup_kdump_cmdline(struct kimage *image, char *cmdline,
>  				 unsigned long cmdline_len)
>  {


