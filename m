Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FE7FC4332F
	for <kexec@archiver.kernel.org>; Thu, 14 Dec 2023 22:36:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=VtKIwTWuNrSxQd+HVbAugf5W6VfZLCPFhV1jRx4ewN8=; b=OPP4gIjiAqm3WT
	pUo6o0E+hqv/ywvUImp0N7BcFb3kvvlWnY6nKW/wnF31GFsk8/M8glmv9tBLg04AWAlVRmEI/c3uu
	OvK4zreaNqMtfGSzvspDHxXdKuhYquImqbYIZVZ45I/dBvQg3Bka4wPvqfnKn/HDjfZiQFigJx8yW
	aU8dOJyboikT7kqELOZBHFVcn+xxA3Q/uLh8cwbRcvMFOteElJzHM+sH4KRjvWeVCNFxQDPTXJdyL
	Bm3itNBAuvt5MR50fHi4CEVs+eyX1fY36+siDMUBFFd0ZZMpG7sqOl2u5YXU2bHwyIqVsGgxTO8Ac
	JxLqOqJ/wxLmPhM1d14w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rDuJQ-001SjJ-1z;
	Thu, 14 Dec 2023 22:36:12 +0000
Received: from mail-ot1-f43.google.com ([209.85.210.43])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rDuJM-001Sho-17;
	Thu, 14 Dec 2023 22:36:09 +0000
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-6d9d307a732so64764a34.1;
        Thu, 14 Dec 2023 14:36:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702593367; x=1703198167;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TPGpS3N5cf7hiGlwsGmwzPf9DamC+4nzAyalFlTf6vc=;
        b=Y6S00WZUfvRkXjmTleiBjJWusYziUDmCtRuCK1iat9Qb/AJ+RJogVIrCmFlKfPvMta
         eKm2iCNT4sFx82tXWzunV5MxTETQK45KOGh07MvNzoWDcqJUjtvMzRqN2U6zoU1MrwDb
         iZJgv9leUhPjz3z/EC+5jPoujBN3iOVGdODt6J4iW0QrH97yI1duNKHowEv21DB5C5dw
         uvDP31LY6mBmaXbCfyJvo5MK59P00caEVypndv13B3MgE5lnlGKRTj2Fo5pu5i6bBeui
         u1dah96DGUZ8Tl1uUIRR4Yw5q6Fp38FtyFsQo9wxAId80KGDCyE0bE+47xV/MFkZo9DI
         Hpcg==
X-Gm-Message-State: AOJu0YwsUsnJA8mX5fh2acuBv3DUj/ruKZNXTXgfSAW23VYvHw89DvN4
	ZF4WGKsuSWM4yeK6dZ4lBQ==
X-Google-Smtp-Source: AGHT+IH/ntYBrk6W3zFr9Ig4vAkaNVNC1PcAuUD1j3FxDQR5iGtwTMlXCspq02WUlgURzzmxe383HA==
X-Received: by 2002:a9d:7f8a:0:b0:6da:3f3e:7b30 with SMTP id t10-20020a9d7f8a000000b006da3f3e7b30mr2248166otp.39.1702593367061;
        Thu, 14 Dec 2023 14:36:07 -0800 (PST)
Received: from herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id k13-20020a056830150d00b006d81e704023sm3338450otp.2.2023.12.14.14.36.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 14:36:06 -0800 (PST)
Received: (nullmailer pid 1058742 invoked by uid 1000);
	Thu, 14 Dec 2023 22:36:04 -0000
Date: Thu, 14 Dec 2023 16:36:04 -0600
From: Rob Herring <robh@kernel.org>
To: Alexander Graf <graf@amazon.com>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, linux-mm@kvack.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, kexec@lists.infradead.org, linux-doc@vger.kernel.org, x86@kernel.org, Eric Biederman <ebiederm@xmission.com>, "H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Steven Rostedt <rostedt@goodmis.org>, Andrew Morton <akpm@linux-foundation.org>, Mark Rutland <mark.rutland@arm.com>, Tom Lendacky <thomas.lendacky@amd.com>, Ashish Kalra <ashish.kalra@amd.com>, James Gowans <jgowans@amazon.com>, Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>, arnd@arndb.de, pbonzini@redhat.com, madvenka@linux.microsoft.com, Anthony Yznaga <anthony.yznaga@oracle.com>, Usama Arif <usama.arif@bytedance.com>, David Woodhouse <dwmw@amazon.co.uk>, Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 06/15] arm64: Add KHO support
Message-ID: <20231214223604.GA1045434-robh@kernel.org>
References: <20231213000452.88295-1-graf@amazon.com>
 <20231213000452.88295-7-graf@amazon.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20231213000452.88295-7-graf@amazon.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231214_143608_383521_210704F9 
X-CRM114-Status: GOOD (  34.48  )
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

On Wed, Dec 13, 2023 at 12:04:43AM +0000, Alexander Graf wrote:
> We now have all bits in place to support KHO kexecs. This patch adds
> awareness of KHO in the kexec file as well as boot path for arm64 and
> adds the respective kconfig option to the architecture so that it can
> use KHO successfully.
> 
> Signed-off-by: Alexander Graf <graf@amazon.com>
> ---
>  arch/arm64/Kconfig        | 12 ++++++++++++
>  arch/arm64/kernel/setup.c |  2 ++
>  arch/arm64/mm/init.c      |  8 ++++++++
>  drivers/of/fdt.c          | 41 +++++++++++++++++++++++++++++++++++++++
>  drivers/of/kexec.c        | 36 ++++++++++++++++++++++++++++++++++
>  5 files changed, 99 insertions(+)
> 
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 7b071a00425d..1ba338ce7598 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -1501,6 +1501,18 @@ config ARCH_SUPPORTS_CRASH_DUMP
>  config ARCH_HAS_GENERIC_CRASHKERNEL_RESERVATION
>  	def_bool CRASH_CORE
>  
> +config KEXEC_KHO
> +	bool "kexec handover"
> +	depends on KEXEC
> +	select MEMBLOCK_SCRATCH
> +	select LIBFDT
> +	select CMA
> +	help
> +	  Allow kexec to hand over state across kernels by generating and
> +	  passing additional metadata to the target kernel. This is useful
> +	  to keep data or state alive across the kexec. For this to work,
> +	  both source and target kernels need to have this option enabled.

Why do we have the same kconfig entry twice? Here and x86.

> +
>  config TRANS_TABLE
>  	def_bool y
>  	depends on HIBERNATION || KEXEC_CORE
> diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
> index 417a8a86b2db..8035b673d96d 100644
> --- a/arch/arm64/kernel/setup.c
> +++ b/arch/arm64/kernel/setup.c
> @@ -346,6 +346,8 @@ void __init __no_sanitize_address setup_arch(char **cmdline_p)
>  
>  	paging_init();
>  
> +	kho_reserve_mem();
> +
>  	acpi_table_upgrade();
>  
>  	/* Parse the ACPI tables for possible boot-time configuration */
> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
> index 74c1db8ce271..254d82f3383a 100644
> --- a/arch/arm64/mm/init.c
> +++ b/arch/arm64/mm/init.c
> @@ -358,6 +358,8 @@ void __init bootmem_init(void)
>  	 */
>  	arch_reserve_crashkernel();
>  
> +	kho_reserve();
> +

reserve what? It is not obvious what the difference between 
kho_reserve_mem() and kho_reserve() are.

>  	memblock_dump_all();
>  }
>  
> @@ -386,6 +388,12 @@ void __init mem_init(void)
>  	/* this will put all unused low memory onto the freelists */
>  	memblock_free_all();
>  
> +	/*
> +	 * Now that all KHO pages are marked as reserved, let's flip them back
> +	 * to normal pages with accurate refcount.
> +	 */
> +	kho_populate_refcount();
> +
>  	/*
>  	 * Check boundaries twice: Some fundamental inconsistencies can be
>  	 * detected at build time already.
> diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
> index bf502ba8da95..af95139351ed 100644
> --- a/drivers/of/fdt.c
> +++ b/drivers/of/fdt.c
> @@ -1006,6 +1006,44 @@ void __init early_init_dt_check_for_usable_mem_range(void)
>  		memblock_add(rgn[i].base, rgn[i].size);
>  }
>  
> +/**
> + * early_init_dt_check_kho - Decode info required for kexec handover from DT
> + */
> +void __init early_init_dt_check_kho(void)
> +{
> +#ifdef CONFIG_KEXEC_KHO

if (!IS_ENABLED(CONFIG_KEXEC_KHO))
  return;

You'll need a kho_populate() stub.

> +	unsigned long node = chosen_node_offset;
> +	u64 kho_start, scratch_start, scratch_size, mem_start, mem_size;
> +	const __be32 *p;
> +	int l;
> +
> +	if ((long)node < 0)
> +		return;
> +
> +	p = of_get_flat_dt_prop(node, "linux,kho-dt", &l);
> +	if (l != (dt_root_addr_cells + dt_root_size_cells) * sizeof(__be32))
> +		return;
> +
> +	kho_start = dt_mem_next_cell(dt_root_addr_cells, &p);
> +
> +	p = of_get_flat_dt_prop(node, "linux,kho-scratch", &l);
> +	if (l != (dt_root_addr_cells + dt_root_size_cells) * sizeof(__be32))
> +		return;
> +
> +	scratch_start = dt_mem_next_cell(dt_root_addr_cells, &p);
> +	scratch_size = dt_mem_next_cell(dt_root_addr_cells, &p);
> +
> +	p = of_get_flat_dt_prop(node, "linux,kho-mem", &l);
> +	if (l != (dt_root_addr_cells + dt_root_size_cells) * sizeof(__be32))
> +		return;
> +
> +	mem_start = dt_mem_next_cell(dt_root_addr_cells, &p);
> +	mem_size = dt_mem_next_cell(dt_root_addr_cells, &p);
> +
> +	kho_populate(kho_start, scratch_start, scratch_size, mem_start, mem_size);
> +#endif
> +}
> +
>  #ifdef CONFIG_SERIAL_EARLYCON
>  
>  int __init early_init_dt_scan_chosen_stdout(void)
> @@ -1304,6 +1342,9 @@ void __init early_init_dt_scan_nodes(void)
>  
>  	/* Handle linux,usable-memory-range property */
>  	early_init_dt_check_for_usable_mem_range();
> +
> +	/* Handle kexec handover */
> +	early_init_dt_check_kho();
>  }
>  
>  bool __init early_init_dt_scan(void *params)
> diff --git a/drivers/of/kexec.c b/drivers/of/kexec.c
> index 68278340cecf..a612e6bb8c75 100644
> --- a/drivers/of/kexec.c
> +++ b/drivers/of/kexec.c
> @@ -264,6 +264,37 @@ static inline int setup_ima_buffer(const struct kimage *image, void *fdt,
>  }
>  #endif /* CONFIG_IMA_KEXEC */
>  
> +static int kho_add_chosen(const struct kimage *image, void *fdt, int chosen_node)
> +{
> +	int ret = 0;
> +
> +#ifdef CONFIG_KEXEC_KHO

ditto

Though perhaps image->kho is not defined?


> +	if (!image->kho.dt.buffer || !image->kho.mem_cache.buffer)
> +		goto out;
> +
> +	pr_debug("Adding kho metadata to DT");
> +
> +	ret = fdt_appendprop_addrrange(fdt, 0, chosen_node, "linux,kho-dt",
> +				       image->kho.dt.mem, image->kho.dt.memsz);
> +	if (ret)
> +		goto out;
> +
> +	ret = fdt_appendprop_addrrange(fdt, 0, chosen_node, "linux,kho-scratch",
> +				       kho_scratch_phys, kho_scratch_len);
> +	if (ret)
> +		goto out;
> +
> +	ret = fdt_appendprop_addrrange(fdt, 0, chosen_node, "linux,kho-mem",
> +				       image->kho.mem_cache.mem,
> +				       image->kho.mem_cache.bufsz);
> +	if (ret)
> +		goto out;
> +
> +out:
> +#endif
> +	return ret;
> +}
> +
>  /*
>   * of_kexec_alloc_and_setup_fdt - Alloc and setup a new Flattened Device Tree
>   *
> @@ -412,6 +443,11 @@ void *of_kexec_alloc_and_setup_fdt(const struct kimage *image,
>  		}
>  	}
>  
> +	/* Add kho metadata if this is a KHO image */
> +	ret = kho_add_chosen(image, fdt, chosen_node);
> +	if (ret)
> +		goto out;
> +
>  	/* add bootargs */
>  	if (cmdline) {
>  		ret = fdt_setprop_string(fdt, chosen_node, "bootargs", cmdline);
> -- 
> 2.40.1
> 
> 
> 
> 
> Amazon Development Center Germany GmbH
> Krausenstr. 38
> 10117 Berlin
> Geschaeftsfuehrung: Christian Schlaeger, Jonathan Weiss
> Eingetragen am Amtsgericht Charlottenburg unter HRB 149173 B
> Sitz: Berlin
> Ust-ID: DE 289 237 879
> 
> 
> 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
